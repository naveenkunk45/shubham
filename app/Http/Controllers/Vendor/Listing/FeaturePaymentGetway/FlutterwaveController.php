<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use Illuminate\Http\Request;
use App\Models\PaymentGateway\OnlineGateway;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Config;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Models\BasicSettings\MailTemplate;
use App\Models\VendorInfo;
use Exception;
use Illuminate\Mail\Message;
use App\Models\BasicSettings\Basic;
use Illuminate\Support\Facades\Mail;
use App\Models\Vendor;

class FlutterwaveController extends Controller
{
    private $public_key, $secret_key;

    public function __construct()
    {
        $data = OnlineGateway::whereKeyword('flutterwave')->first();
        $flutterwaveData = json_decode($data->information, true);

        $this->public_key = $flutterwaveData['public_key'];
        $this->secret_key = $flutterwaveData['secret_key'];
    }

    public function index(Request $request, $paymentFor)
    {


        $v = $request->charge;

        $charge = FeaturedListingCharge::find($v);


        $allowedCurrencies = array('BIF', 'CAD', 'CDF', 'CVE', 'EUR', 'GBP', 'GHS', 'GMD', 'GNF', 'KES', 'LRD', 'MWK', 'MZN', 'NGN', 'RWF', 'SLL', 'STD', 'TZS', 'UGX', 'USD', 'XAF', 'XOF', 'ZMK', 'ZMW', 'ZWD');

        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the base currency is allowed or not
        if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
            return redirect()->back()->with('error', 'Invalid currency for flutterwave payment.')->withInput();
        }

        $title = 'Activation Feature';
        $notifyURL = route('vendor.listing_management.listing.purchase_feature.flutterwave.notify');

        $customerName = $request['billing_name'];
        $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

        if (isset($vendor_mail->to_mail)) {
            $vendorEmail = $vendor_mail->to_mail;
        } else {
            $vendorEmail = $vendor_mail->email;
        }
        $customerPhone = $request['billing_phone'];


        // send payment to flutterwave for processing
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://api.flutterwave.com/v3/payments',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode([
                'tx_ref' => 'FLW | ' . time(),
                'amount' => $charge->price,
                'currency' => $currencyInfo->base_currency_text,
                'redirect_url' => $notifyURL,
                'payment_options' => 'card,banktransfer',
                'customer' => [
                    'email' => $vendorEmail,
                    'phone_number' => $customerPhone,
                    'name' => $customerName
                ],
                'customizations' => [
                    'title' => $title,
                    'description' => $title . ' via Flutterwave.'
                ]
            ]),
            CURLOPT_HTTPHEADER => array(
                'authorization: Bearer ' . $this->secret_key,
                'content-type: application/json'
            )
        ));

        $response = curl_exec($curl);

        curl_close($curl);

        $responseData = json_decode($response, true);

        //curl end

        // put some data in session before redirect to flutterwave url
        $request->session()->put('paymentFor', $paymentFor);
        $request->session()->put('chargeId', $request->charge);
        $request->session()->put('listingId', $request->listing_id);

        // redirect to payment
        if ($responseData['status'] === 'success') {
            return redirect($responseData['data']['link']);
        } else {
            return redirect()->back()->with('error', 'Error: ' . $responseData['message'])->withInput();
        }
    }

    public function notify(Request $request)
    {
        // get the information from session
        $paymentId = $request->session()->get('paymentId');
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');

        $urlInfo = $request->all();

        if ($urlInfo['status'] == 'successful') {
            $txId = $urlInfo['transaction_id'];

            $curl = curl_init();

            curl_setopt_array($curl, array(
                CURLOPT_URL => "https://api.flutterwave.com/v3/transactions/{$txId}/verify",
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => 'GET',
                CURLOPT_HTTPHEADER => array(
                    'authorization: Bearer ' . $this->secret_key,
                    'content-type: application/json'
                )
            ));

            $response = curl_exec($curl);

            curl_close($curl);

            $responseData = json_decode($response, true);
            if ($responseData['status'] === 'success') {


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
                $order->payment_method = "FlutterWave";
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

                    $body = preg_replace("/{payment_via}/", "FlutterWave", $body);

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
                $request->session()->forget('chargeId');
                $request->session()->forget('listingId');

                Session::flash('success', 'Something Went Wrong');
                return redirect()->route('vendor.listing_management.listing');
            }
        } else {
            $request->session()->forget('chargeId');
            $request->session()->forget('listingId');

            Session::flash('success', 'Something Went Wrong');
            return redirect()->route('vendor.listing_management.listing');
        }
    }
}
