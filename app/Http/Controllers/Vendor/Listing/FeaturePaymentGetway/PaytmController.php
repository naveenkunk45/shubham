<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Anand\LaravelPaytmWallet\Facades\PaytmWallet;
use App\Http\Helpers\BasicMailer;
use App\Models\FeaturedListingCharge;
use App\Models\Vendor;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Exception;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use App\Models\BasicSettings\MailTemplate;
use App\Models\VendorInfo;
use Illuminate\Mail\Message;
use App\Models\BasicSettings\Basic;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Config;



class PaytmController extends Controller
{
    public function index(Request $request, $paymentFor)
    {
        $v = $request->charge;

        $charge = FeaturedListingCharge::find($v);

        $currencyInfo = $this->getCurrencyInfo();



        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the currency is set to 'INR' or not
        if ($currencyInfo->base_currency_text !== 'INR') {
            Session::flash('warning', 'Invalid currency for instamojo payment.');
            return redirect()->back();
        }

       
        $notifyURL = route('vendor.listing_management.listing.purchase_feature.paytm.notify');

        $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

        if (isset($vendor_mail->to_mail)) {
            $to_mail = $vendor_mail->to_mail;
        } else {
            $to_mail = $vendor_mail->email;
        }

        $customerEmail = $to_mail;
        $customerPhone = $vendor_mail->phone;

        $payment = PaytmWallet::with('receive');

        $payment->prepare([
            'order' => time(),
            'user' => uniqid(),
            'mobile_number' => $customerPhone,
            'email' => $customerEmail,
            'amount' => round($charge->price, 2),
            'callback_url' => $notifyURL
        ]);

        // put some data in session before redirect to paytm url
        // put some data in session before redirect to paypal url
        $request->session()->put('paymentFor', $paymentFor);
        $request->session()->put('chargeId', $request->charge);
        $request->session()->put('listingId', $request->listing_id);

        return $payment->receive();
    }

    public function notify(Request $request)
    {
        $paymentId = $request->session()->get('paymentId');
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');

        $arrData = $request->session()->get('arrData');

        $transaction = PaytmWallet::with('receive');

        // this response is needed to check the transaction status
        $response = $transaction->response();

        if ($transaction->isSuccessful()) {
            // remove this session datas
            $request->session()->forget('paymentFor');
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

            $vendor = VendorInfo::Where('vendor_id',
                Auth::guard('vendor')->user()->id
            )->first();
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
                                ->html($data['body'],
                                    'text/html'
                                );
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
