<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use Illuminate\Http\Request;
use Cartalyst\Stripe\Exception\CardErrorException;
use Cartalyst\Stripe\Exception\UnauthorizedException;
use Cartalyst\Stripe\Laravel\Facades\Stripe;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
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

class StripeController extends Controller
{
    public function index(Request $request)
    {
        // card validation start
        $rules = [
            'stripeToken' => 'required',
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }
        // card validation end

        $charge = FeaturedListingCharge::find($request->charge);


        $currencyInfo = $this->getCurrencyInfo();

        // changing the currency before redirect to Stripe
        if ($currencyInfo->base_currency_text !== 'USD') {
            $rate = floatval($currencyInfo->base_currency_rate);
            $convertedTotal = round(($charge->price / $rate), 2);
        }

        $stripeTotal = $currencyInfo->base_currency_text === 'USD' ? $charge->price : $convertedTotal;

        try {
            // initialize stripe
            $stripe = new Stripe();
            $stripe = Stripe::make(Config::get('services.stripe.secret'));

            try {

                // generate charge
                $charge = $stripe->charges()->create([
                    'source' => $request->stripeToken,
                    'currency' => 'USD',
                    'amount'   => $stripeTotal
                ]);

                if ($charge['status'] == 'succeeded') {


                    $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

                    if (isset($vendor_mail->to_mail)) {
                        $to_mail = $vendor_mail->to_mail;
                    } else {
                        $to_mail = $vendor_mail->email;
                    }


                    $charge = FeaturedListingCharge::find($request->charge);


                    $startDate = Carbon::now()->startOfDay();
                    $endDate = $startDate->copy()->addDays($charge->days);

                    $order =  FeatureOrder::where('listing_id', $request->listing_id)->first();
                    if (empty($order)) {
                        $order = new FeatureOrder();
                    }

                    $order->listing_id = $request->listing_id;
                    $order->vendor_id = Auth::guard('vendor')->user()->id;
                    $order->vendor_mail = $to_mail;
                    $order->order_number = uniqid();
                    $order->total = $charge->price;
                    $order->payment_method = "Stripe";
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

                        $body = preg_replace("/{payment_via}/", "Stripe", $body);

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
            } catch (CardErrorException $e) {
                Session::flash('error', $e->getMessage());

                Session::flash('success', 'Something Went Wrong');
                return redirect()->route('vendor.listing_management.listing');
            }
        } catch (UnauthorizedException $e) {
            Session::flash('error', $e->getMessage());

            Session::flash('success', 'Something Went Wrong');
            return redirect()->route('vendor.listing_management.listing');
        }
    }
}
