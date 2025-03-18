<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Mollie\Laravel\Facades\Mollie;
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

class MollieController extends Controller
{
    public function index(Request $request)
    {
        $v = $request->charge;

        $charge = FeaturedListingCharge::find($v);


        $allowedCurrencies = array('AED', 'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HRK', 'HUF', 'ILS', 'ISK', 'JPY', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'THB', 'TWD', 'USD', 'ZAR');

        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the base currency is allowed or not
        if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
            return redirect()->back()->with('error', 'Invalid currency for mollie payment.')->withInput();
        }


        $title = 'Activation Feature';
        $notifyURL = route('vendor.listing_management.listing.purchase_feature.mollie.notify');


        $payment = Mollie::api()->payments->create([
            'amount' => [
                'currency' => $currencyInfo->base_currency_text,
                'value' => sprintf('%0.2f', $charge->price)
            ],
            'description' => $title . ' via Mollie',
            'redirectUrl' => $notifyURL
        ]);

        // put some data in session before redirect to mollie url
        $request->session()->put('payment', $payment);
        $request->session()->put('chargeId', $request->charge);
        $request->session()->put('listingId', $request->listing_id);

        return redirect($payment->getCheckoutUrl(), 303);
    }

    public function notify(Request $request)
    {

        $productList = $request->session()->get('productCart');

        // get the information from session
        $payment = $request->session()->get('payment');
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');

        $paymentInfo = Mollie::api()->payments->get($payment->id);

        if ($paymentInfo->isPaid() == true) {

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
            $order->payment_method = "Mollie";
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

                $body = preg_replace("/{payment_via}/", "Mollie", $body);

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
