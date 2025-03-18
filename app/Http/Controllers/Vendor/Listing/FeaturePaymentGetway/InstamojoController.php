<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use Illuminate\Http\Request;
use App\Http\Helpers\Instamojo;
use App\Models\PaymentGateway\OnlineGateway;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Config;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use App\Models\BasicSettings\MailTemplate;
use App\Models\VendorInfo;
use Illuminate\Mail\Message;
use App\Models\BasicSettings\Basic;
use Illuminate\Support\Facades\Mail;
use App\Models\Vendor;

class InstamojoController extends Controller
{
    private $api;

    public function __construct()
    {
        $data = OnlineGateway::whereKeyword('instamojo')->first();
        $instamojoData = json_decode($data->information, true);

        if ($instamojoData['sandbox_status'] == 1) {
            $this->api = new Instamojo($instamojoData['key'], $instamojoData['token'], 'https://test.instamojo.com/api/1.1/');
        } else {
            $this->api = new Instamojo($instamojoData['key'], $instamojoData['token']);
        }
    }

    public function index(Request $request, $paymentFor)
    {

        $v = $request->charge;
        $charge = FeaturedListingCharge::find($v);
        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the currency is set to 'INR' or not
        if ($currencyInfo->base_currency_text !== 'INR') {
            Session::flash('warning', 'Invalid currency for instamojo payment.');
            return redirect()->back();
        }

        $title = 'Activation Feature';
        $notifyURL = route('vendor.listing_management.listing.purchase_feature.instamojo.notify');

        $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

        if (isset($vendor_mail->to_mail)) {
            $to_mail = $vendor_mail->to_mail;
        } else {
            $to_mail = $vendor_mail->email;
        }

        try {
            $response = $this->api->paymentRequestCreate(array(
                'purpose' => $title,
                'amount' => round($charge->price, 2),
                'buyer_name' => "Vendor",
                'email' => $to_mail,
                'send_email' => false,
                'phone' => $vendor_mail->phone,
                'send_sms' => false,
                'redirect_url' => $notifyURL
            ));

            // put some data in session before redirect to instamojo url
            $request->session()->put('paymentFor', $paymentFor);
            $request->session()->put('paymentId', $response['id']);
            $request->session()->put('chargeId', $request->charge);
            $request->session()->put('listingId', $request->listing_id);

            return redirect($response['longurl']);
        } catch (Exception $e) {
            Session::flash('warning', 'Something Went Wrong');
            return redirect()->back()->with('error', 'Sorry, transaction failed!')->withInput();
        }
    }

    public function notify(Request $request)
    {

        $paymentId = $request->session()->get('paymentId');
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');

        $urlInfo = $request->all();

        if ($urlInfo['payment_request_id'] == $paymentId) {


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
            $order->payment_method = "Instamojo";
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

                $body = preg_replace("/{payment_via}/", "Instamojo", $body);

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

                    Session::flash('success', 'Your Payment successfully completed.');
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
