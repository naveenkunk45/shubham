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

class MercadoPagoController extends Controller
{
    private $token, $sandbox_status;

    public function __construct()
    {
        $data = OnlineGateway::whereKeyword('mercadopago')->first();
        $mercadopagoData = json_decode($data->information, true);

        $this->token = $mercadopagoData['token'];
        $this->sandbox_status = $mercadopagoData['sandbox_status'];
    }

    public function index(Request $request, $paymentFor)
    {
        $v = $request->charge;

        $charge = FeaturedListingCharge::find($v);


        $allowedCurrencies = array('ARS', 'BOB', 'BRL', 'CLF', 'CLP', 'COP', 'CRC', 'CUC', 'CUP', 'DOP', 'EUR', 'GTQ', 'HNL', 'MXN', 'NIO', 'PAB', 'PEN', 'PYG', 'USD', 'UYU', 'VEF', 'VES');

        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the base currency is allowed or not
        if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
            return redirect()->back()->with('error', 'Invalid currency for mercadopago payment.');
        }


        $title = 'Feature Activation ';
        $notifyURL = route('vendor.listing_management.listing.purchase_feature.mercadopago.notify');
        $cancelURL = route('vendor.listing_management.listing');

        $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

        if (isset($vendor_mail->to_mail)) {
            $vendorEmail = $vendor_mail->to_mail;
        } else {
            $vendorEmail = $vendor_mail->email;
        }


        $curl = curl_init();

        $preferenceData = [
            'items' => [
                [
                    'id' => uniqid(),
                    'title' => $title,
                    'description' => $title . ' via MercadoPago',
                    'quantity' => 1,
                    'currency' => $currencyInfo->base_currency_text,
                    'unit_price' => $charge->price
                ]
            ],
            'payer' => [
                'email' => $vendorEmail
            ],
            'back_urls' => [
                'success' => $notifyURL,
                'pending' => '',
                'failure' => $cancelURL
            ],
            'notification_url' => $notifyURL,
            'auto_return' => 'approved'
        ];

        $httpHeader = ['Content-Type: application/json'];

        $url = 'https://api.mercadopago.com/checkout/preferences?access_token=' . $this->token;

        $curlOPT = [
            CURLOPT_URL             => $url,
            CURLOPT_CUSTOMREQUEST   => 'POST',
            CURLOPT_POSTFIELDS      => json_encode($preferenceData, true),
            CURLOPT_HTTP_VERSION    => CURL_HTTP_VERSION_1_1,
            CURLOPT_RETURNTRANSFER  => true,
            CURLOPT_TIMEOUT         => 30,
            CURLOPT_HTTPHEADER      => $httpHeader
        ];

        curl_setopt_array($curl, $curlOPT);

        $response = curl_exec($curl);
        $responseInfo = json_decode($response, true);

        curl_close($curl);

        // put some data in session before redirect to mercadopago url
        $request->session()->put('paymentFor', $paymentFor);

        if ($this->sandbox_status == 1) {
            return redirect($responseInfo['sandbox_init_point']);
        } else {
            return redirect($responseInfo['init_point']);
        }
    }

    public function notify(Request $request)
    {
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');


        if ($request->status == 'approved') {


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
            $order->payment_method = "Mercado Pago";
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

                $body = preg_replace("/{payment_via}/", "Mercado Pago", $body);

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
    }
}
