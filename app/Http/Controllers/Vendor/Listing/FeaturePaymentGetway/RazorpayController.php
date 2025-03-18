<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use Illuminate\Http\Request;
use App\Models\BasicSettings\Basic;
use App\Models\PaymentGateway\OnlineGateway;
use Illuminate\Support\Facades\Session;
use Razorpay\Api\Api;
use Razorpay\Api\Errors\SignatureVerificationError;
use Illuminate\Support\Facades\Config;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Models\BasicSettings\MailTemplate;
use App\Models\VendorInfo;
use Exception;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Mail;
use App\Models\Vendor;

class RazorpayController extends Controller
{
    private $key, $secret, $api;

    public function __construct()
    {
        $data = OnlineGateway::whereKeyword('razorpay')->first();
        $razorpayData = json_decode($data->information, true);

        $this->key = $razorpayData['key'];

        $this->secret = $razorpayData['secret'];

        $this->api = new Api($this->key, $this->secret);
    }

    public function index(Request $request, $paymentFor)
    {

        $v = $request->charge;

        $charge = FeaturedListingCharge::find($v);

        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the currency is set to 'INR' or not
        if ($currencyInfo->base_currency_text !== 'INR') {
            return redirect()->back()->with('error', 'Invalid currency for razorpay payment.')->withInput();
        }

        $title = 'Activation Feature';
        $notifyURL = route('vendor.listing_management.listing.purchase_feature.razorpay.notify');

        // create order data
        $orderData = [
            'receipt'         => $title,
            'amount'          => intval($charge->price * 100),
            'currency'        => 'INR',
            'payment_capture' => 1
        ];

        $razorpayOrder = $this->api->order->create($orderData);

        $webInfo = Basic::select('website_title')->first();

        $customerName = $request['billing_name'] . ' ' . $request['billing_name'];
        $customerEmail = $request['billing_email'];
        $customerPhone = $request['billing_phone'];

        // create checkout data
        $checkoutData = [
            'key'               => $this->key,
            'amount'            => $orderData['amount'],
            'name'              => $webInfo->website_title,
            'description'       => $title . ' via Razorpay.',
            'prefill'           => [
                "name" => "azim",
                "email" => "azimahmed11041@gmail.com",
                "contact" => "+8801749494949",
            ],
            'order_id'          => $razorpayOrder->id
        ];

        $jsonData = json_encode($checkoutData);

        // put some data in session before redirect to razorpay url
        $request->session()->put('razorpayOrderId', $razorpayOrder->id);
        $request->session()->put('chargeId', $request->charge);
        $request->session()->put('listingId', $request->listing_id);

        return view('frontend.payment.razorpay', compact('jsonData', 'notifyURL'));
    }

    public function notify(Request $request)
    {
        // get the information from session

        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');


        $razorpayOrderId = $request->session()->get('razorpayOrderId');

        $urlInfo = $request->all();

        // assume that the transaction was successful
        $success = true;

        
        try {
            $attributes = [
                'razorpay_order_id' => $razorpayOrderId,
                'razorpay_payment_id' => $urlInfo['razorpayPaymentId'],
                'razorpay_signature' => $urlInfo['razorpaySignature']
            ];

            $this->api->utility->verifyPaymentSignature($attributes);
        } catch (SignatureVerificationError $e) {
            $success = false;
        }

        if ($success === true) {

            $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

            if (isset($vendor_mail->to_mail)) {
                $to_mail = $vendor_mail->to_mail;
            } else {
                $to_mail = $vendor_mail->email;
            }


            $charge = FeaturedListingCharge::find($chargeId);

            $startDate = Carbon::now()->startOfDay();
            $endDate = $startDate->copy()->addDays($charge->days);

            $order =  FeatureOrder::where('listing_id', $listingId)->first();
            if (empty($order)) {
                $order = new FeatureOrder();
            }

            $order->listing_id = $listingId;
            $order->vendor_id = Auth::guard('vendor')->user()->id;
            $order->vendor_mail = $to_mail;
            $order->order_number = uniqid();
            $order->total = $charge->price;
            $order->payment_method = "Razorpay";
            $order->gateway_type = "online";
            $order->payment_status = "completed";
            $order->order_status = 'pending';
            $order->days = $charge->days;
            $order->start_date = $startDate;
            $order->end_date = $endDate;

            $order->save();


            // // send a mail to the Vendor to confirm payment success

            $vendor = VendorInfo::Where('vendor_id', Auth::guard('vendor')->user()->id)->first();
            $info = Basic::select('google_recaptcha_status')->first();
            if ($info->google_recaptcha_status == 1) {
                $rules['g-recaptcha-response'] = 'required|captcha';
            }

            $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();



            $mail_template = MailTemplate::where('mail_type', 'payment_accepted_for_featured_online_gateway')->first();

            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;
                $body = preg_replace("/{username}/", $vendor->name, $body);

                $body = preg_replace("/{payment_via}/", "Razorpay", $body);

                $body = preg_replace("/{package_price}/", $charge->price, $body);
                $body = preg_replace("/{website_title}/", $be->website_title, $body);

                if ($be->smtp_status == 1) {
                    try {
                        $smtp = [
                            'transport' => 'smtp',
                            'host' => $be->smtp_host,
                            'port' => $be->smtp_port,
                            'encryption' => $be->encryption,
                            'username' => $be->smtp_username,
                            'password' => $be->smtp_password,
                            'timeout' => null,
                            'auth_mode' => null,
                        ];
                        Config::set('mail.mailers.smtp', $smtp);
                    } catch (\Exception $e) {
                        Session::flash('error', $e->getMessage());
                        return back();
                    }
                }
                try {
                    $data = [
                        'to' => $to_mail,
                        'subject' => $subject,
                        'body' => $body,
                    ];
                    if ($be->smtp_status == 1) {
                        Mail::send([], [], function (Message $message) use ($data, $be) {
                            $fromMail = $be->from_mail;
                            $fromName = $be->from_name;
                            $message->to($data['to'])
                                ->subject($data['subject'])
                                ->from($fromMail, $fromName)
                                ->html($data['body'], 'text/html');
                        });
                    }

                    Session::flash(
                        'success',
                        'Your Payment successfully completed.'
                    );
                } catch (Exception $e) {
                    Session::flash('error', $e);
                }
                $info = Basic::select('to_mail', 'website_title')->first();
                $vendor = Auth::guard('vendor')->user()->username;

                $mailData['subject'] = "$vendor wants to feature a listing on $info->website_title";
                $mailBody = "Dear Admin,
            
I hope this email finds you well. I wanted to bring to your attention that $vendor wants to feature a listing on our website by.

Thank you for your attention to this matter.";

                $mailData['body'] = nl2br($mailBody);
                $mailData['recipient'] = $info->to_mail;

                BasicMailer::sendMail($mailData);
            }
            $request->session()->forget('chargeId');
            $request->session()->forget('listingId');
            return redirect()->route('success.page');
        } else {
            Session::flash('success', 'Something Went Wrong');
            return redirect()->route('vendor.listing_management.listing');
        }
    }
}
