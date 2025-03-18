<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use App\Http\Helpers\UploadFile;
use App\Models\BasicSettings\Basic;
use App\Models\FeaturedListingCharge;
use App\Models\PaymentGateway\OfflineGateway;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Models\Vendor;

class OfflineController extends Controller
{
    public function index(Request $request)
    {
        $gatewayId = $request->gateway;
        $offlineGateway = OfflineGateway::query()->findOrFail($gatewayId);

        $v = $request->charge;

        $charge = FeaturedListingCharge::find($v);

        if ($offlineGateway->has_attachment == 1) {
            $fieldName = "attachment_" . $request->listing_id;

            $rules = [
                $fieldName => [
                    'required',
                    new ImageMimeTypeRule()
                ]
            ];

            $message = [
                "$fieldName.required" => 'Please attach your payment receipt.'
            ];

            $validator = Validator::make($request->only($fieldName), $rules, $message);

            Session::flash('gatewayId', $offlineGateway->id);


            if ($validator->fails()) {
                Session::put('featurePaymentModal', 'ok');
                Session::put('modalName', "featurePaymentModal_" . $request->listing_id);
                return redirect()->back()->withErrors($validator->errors())->withInput();
            }
        }
        // validation end

        $directory = public_path('assets/file/attachments/feature-activation/');

        // store attachment in local storage
        if ($request->hasFile('attachment_' . $request->listing_id)) {
            $attachmentName = UploadFile::store($directory, $request->file('attachment_' . $request->listing_id));
        } else {
            $attachmentName = null;
        }


        $startDate = Carbon::now()->startOfDay();
        $endDate = $startDate->copy()->addDays($charge->days);
        $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

        if (isset($vendor_mail->to_mail)) {
            $to_mail = $vendor_mail->to_mail;
        } else {
            $to_mail = $vendor_mail->email;
        }



        $order =  FeatureOrder::where('listing_id', $request->listing_id)->first();
        if (empty($order)) {
            $order = new FeatureOrder();
        }

        $order->listing_id = $request->listing_id;
        $order->vendor_id = Auth::guard('vendor')->user()->id;
        $order->vendor_mail = $to_mail;
        $order->order_number = uniqid();
        $order->total = $charge->price;
        $order->payment_method = $offlineGateway->name;
        $order->gateway_type = "offline";
        $order->payment_status = "pending";
        $order->order_status = 'pending';
        $order->attachment = $attachmentName;
        $order->days = $charge->days;
        $order->start_date = $startDate;
        $order->end_date = $endDate;

        $order->save();
        $info = Basic::select('to_mail', 'website_title')->first();
        $vendor = Auth::guard('vendor')->user()->username;

        $mailData['subject'] = "$vendor wants to feature a listing on $info->website_title";
        $mailBody = "Dear Admin,
            
I hope this email finds you well. I wanted to bring to your attention that $vendor wants to feature a listing on our website by.

Thank you for your attention to this matter.";

        $mailData['body'] = nl2br($mailBody);
        $mailData['recipient'] = $info->to_mail;

        BasicMailer::sendMail($mailData);


        return view('vendors.listing.offline-success');
    }
}
