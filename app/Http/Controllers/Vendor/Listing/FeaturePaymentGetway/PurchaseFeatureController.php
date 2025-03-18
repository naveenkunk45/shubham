<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\OfflineController;
use Illuminate\Support\Facades\Session;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\PayPalController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\PaytmController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\InstamojoController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\MollieController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\AuthorizeNetController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\StripeController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\RazorpayController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\MercadoPagoController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\FlutterwaveController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\PaystackController;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Response;

class PurchaseFeatureController extends Controller
{

    public function index(Request $request)
    {

        $rules = [
            'gateway' => 'required',
            'charge' => 'required',
        ];

        $message = [
            'gateway.required' => 'The gateway field is required.',
            'charge.required' => 'The charge field is required.'
        ];

        $validator = Validator::make($request->all(), $rules, $message);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }


        if (!$request->exists('gateway')) {

            $errorMessageKey = "select_payment_".$request->listing_id;

            Session::flash($errorMessageKey, 'Please select a payment method.');

            return redirect()->back()->withInput();
        }
        if (!$request->exists('charge')) {

            $errorMessageKey = "select_days_" . $request->listing_id;

            Session::flash($errorMessageKey, 'Please select promotion list.');


            return redirect()->back()->withInput();
        }

        if ($request['gateway'] == 'paypal') {
            $paypal = new PayPalController();

            return $paypal->index($request, 'product purchase');
        } else if ($request['gateway'] == 'instamojo') {
            $instamojo = new InstamojoController();

            return $instamojo->index($request, 'product purchase');
        } else if ($request['gateway'] == 'paystack') {
            $paystack = new PaystackController();

            return $paystack->index($request, 'product purchase');
        } else if ($request['gateway'] == 'flutterwave') {
            $flutterwave = new FlutterwaveController();

            return $flutterwave->index($request, 'product purchase');
        } else if ($request['gateway'] == 'razorpay') {
            $razorpay = new RazorpayController();

            return $razorpay->index($request, 'product purchase');
        } else if ($request['gateway'] == 'mercadopago') {
            $mercadopago = new MercadoPagoController();

            return $mercadopago->index($request, 'product purchase');
        } else if ($request['gateway'] == 'mollie') {
            $mollie = new MollieController();

            return $mollie->index($request, 'product purchase');
        } else if ($request['gateway'] == 'stripe') {
            $stripe = new StripeController();

            return $stripe->index($request, 'product purchase');
        } else if ($request['gateway'] == 'paytm') {
            $paytm = new PaytmController();

            return $paytm->index($request, 'product purchase');
        } else if ($request['gateway'] == 'authorize.net') {
            $author = new AuthorizeNetController();

            return $author->index($request, 'product purchase');
        } else {
            $offline = new OfflineController();

            return $offline->index($request, 'product purchase');
        }
    }
    public function sessionForget()
    {
        Session::forget('modalName');
        Session::forget('featurePament');
    }
}
