<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| vendor Interface Routes
|--------------------------------------------------------------------------
*/

Route::prefix('vendor')->middleware('change.lang')->group(function () {
  Route::get('/signup', 'Vendor\VendorController@signup')->name('vendor.signup');
  Route::post('/signup/submit', 'Vendor\VendorController@create')->name('vendor.signup_submit');
  Route::get('/login', 'Vendor\VendorController@login')->name('vendor.login');
  Route::post('/login/submit', 'Vendor\VendorController@authentication')->name('vendor.login_submit');

  Route::get('/email/verify', 'Vendor\VendorController@confirm_email');

  Route::get('/forget-password', 'Vendor\VendorController@forget_passord')->name('vendor.forget.password');
  Route::post('/send-forget-mail', 'Vendor\VendorController@forget_mail')->name('vendor.forget.mail');
  Route::get('/reset-password', 'Vendor\VendorController@reset_password')->name('vendor.reset.password');
  Route::post('/update-forget-password', 'Vendor\VendorController@update_password')->name('vendor.update-forget-password');
});

Route::prefix('vendor')->middleware('auth:vendor', 'Demo', 'Deactive', 'email.verify')->group(function () {

  Route::prefix('listing-management')->group(function () {

    Route::get('/', 'Vendor\Listing\ListingController@index')->name('vendor.listing_management.listing');

    Route::prefix('/purchase-feature')->group(function () {

      Route::post('', 'Vendor\Listing\FeaturePaymentGetway\PurchaseFeatureController@index')->name('vendor.listing_management.listing.purchase_feature');

      Route::post('/ss', 'Vendor\Listing\FeaturePaymentGetway\PurchaseFeatureController@sessionForget')->name('vendor.listing_management.listing.purchase_feature.session_forget');

      Route::get('/paypal/notify', 'Vendor\Listing\FeaturePaymentGetway\PayPalController@notify')->name('vendor.listing_management.listing.purchase_feature.paypal.notify');

      Route::get('/instamojo/notify', 'Vendor\Listing\FeaturePaymentGetway\InstamojoController@notify')->name('vendor.listing_management.listing.purchase_feature.instamojo.notify');

      Route::get('/mollie/notify', 'Vendor\Listing\FeaturePaymentGetway\MollieController@notify')->name('vendor.listing_management.listing.purchase_feature.mollie.notify');

      Route::post('/razorpay/notify', 'Vendor\Listing\FeaturePaymentGetway\RazorpayController@notify')->name('vendor.listing_management.listing.purchase_feature.razorpay.notify');

      Route::get('/mercadopago/notify', 'Vendor\Listing\FeaturePaymentGetway\MercadoPagoController@notify')->name('vendor.listing_management.listing.purchase_feature.mercadopago.notify');

      Route::get('/flutterwave/notify', 'Vendor\Listing\FeaturePaymentGetway\FlutterwaveController@notify')->name('vendor.listing_management.listing.purchase_feature.flutterwave.notify');

      Route::get('/paystack/notify', 'Vendor\Listing\FeaturePaymentGetway\PaystackController@notify')->name('vendor.listing_management.listing.purchase_feature.paystack.notify');
      Route::post('/paytm/notify', 'Vendor\Listing\FeaturePaymentGetway\PaytmController@notify')->name('vendor.listing_management.listing.purchase_feature.paytm.notify');
    });

    Route::post('update_visibility', 'Vendor\Listing\ListingController@updateVisibility')->name('vendor.listing_management.update_listing_visibility');


    Route::post('/get-state', 'Vendor\Listing\ListingController@getState')->name('vendor.listing_management.get-state');
    Route::post('/get-city', 'Vendor\Listing\ListingController@getCity')->name('vendor.listing_management.get-city');

    Route::get('/create', 'Vendor\Listing\ListingController@create')->name('vendor.listing_management.create_listing');
    Route::post('store', 'Vendor\Listing\ListingController@store')->name('vendor.listing_management.store_listing')->middleware('packageLimitsCheck:listing,store');

    Route::get('edit-listing/{id}', 'Vendor\Listing\ListingController@edit')->name('vendor.listing_management.edit_listing');
    Route::post('update/{id}', 'Vendor\Listing\ListingController@update')->name('vendor.listing_management.update_listing')->middleware('packageLimitsCheck:listing,update');

    Route::post('delete-video-image/{id}', 'Vendor\Listing\ListingController@videoImageRemove')->name('vendor.listing_management.video_image.delete');

    Route::get('slider-images/{id}', 'Vendor\Listing\ListingController@getSliderImages');

    Route::post('delete/{id}', 'Vendor\Listing\ListingController@delete')->name('vendor.listing_management.delete_listing');

    Route::post('bulk_delete', 'Vendor\Listing\ListingController@bulkDelete')->name('vendor.listing_management.bulk_delete.listing');

    Route::post('specification/delete', 'Vendor\Listing\ListingController@featureDelete')->name('vendor.listing_management.feature_delete');

    Route::post('social/delete', 'Vendor\Listing\ListingController@socialDelete')->name('vendor.listing_management.social_delete');
    Route::post('aminitie/cng', 'Vendor\Listing\ListingController@aminitieUpdate')->name('vendor.listing_management.update_aminitie');


    //listing plugins route start
    Route::get('/plugins/{id}', 'Vendor\Listing\ListingController@plugins')->name('vendor.listing_management.listing.plugins');


    Route::post('/update-tawkto/{id}', 'Vendor\Listing\ListingController@updateTawkTo')->name('vendor.listing_management.listing.update_tawkto');

    Route::post('/update-telegram/{id}', 'Vendor\Listing\ListingController@updateTelegram')->name('vendor.listing_management.listing.update_telegram');

    Route::post('/update-whatsapp/{id}', 'Vendor\Listing\ListingController@updateWhatsApp')->name('vendor.listing_management.listing.update_whatsapp');

    Route::post('/update-messenger/{id}', 'Vendor\Listing\ListingController@updateMessanger')->name('vendor.listing_management.listing.update_messenger');
    // listing plugins route end

    //mnange social link

    Route::get('manage-social-link/{id}', 'Vendor\Listing\ListingController@manageSocialLink')->name('vendor.listing_management.manage_social_link');

    Route::post('upadte-social-link/{id}', 'Vendor\Listing\ListingController@updateSocialLink')->name('vendor.listing_management.update_social_link')->middleware('packageLimitsCheck:listing,update');

    //end managing social link

    //mnange Feature link

    Route::get('manage-additional-specification/{id}', 'Vendor\Listing\ListingController@manageAdditionalSpecification')->name('vendor.listing_management.manage_additional_specifications');

    Route::post('upadte-additional-specification/{id}', 'Vendor\Listing\ListingController@updateAdditionalSpecification')->name('vendor.listing_management.update_additional_specification')->middleware('packageLimitsCheck:listing,update');

    //end managing Feature link

    //business hours

    Route::get('/business-hours/{id}', 'Vendor\Listing\ListingController@businessHours')->name('vendor.listing_management.listing.business_hours');

    Route::post('update-business-hours/{id}', 'Vendor\Listing\ListingController@updateBusinessHours')->name('vendor.listing_management.listing.business_hours_update');

    Route::post('update_holiday', 'Vendor\Listing\ListingController@updateHoliday')->name('vendor.listing_management.listing.business_hours.update_holiday');

    //end Business Hours

    //FAQ ROUTE START

    Route::get('/faq/{id}', 'Vendor\Listing\FaqController@index')->name('vendor.listing_management.listing.faq');

    Route::post('/store-faq', 'Vendor\Listing\FaqController@store')->name('vendor.listing_management.listing.store_faq')->middleware('packageLimitsCheck:faq,store');

    Route::post('/update-faq', 'Vendor\Listing\FaqController@update')->name('vendor.listing_management.listing.update_faq')->middleware('packageLimitsCheck:listing,update');

    Route::post('/delete-faq/{id}', 'Vendor\Listing\FaqController@destroy')->name('vendor.listing_management.listing.delete_faq');

    Route::post('/bulk-delete-faq', 'Vendor\Listing\FaqController@bulkDestroy')->name('vendor.listing_management.listing.bulk_delete_faq');

    //FAQ ROUTE END


    //#----------Listing Products

    Route::get('/listing-products/{id}', 'Vendor\Listing\ProductController@index')->name('vendor.listing_management.listing.products');

    Route::get('/product-create/{id}', 'Vendor\Listing\ProductController@create')->name('vendor.listing_management.create_Product');

    Route::post('product-store', 'Vendor\Listing\ProductController@store')->name('vendor.listing_management.listing.store_product')->middleware('packageLimitsCheck:product,store');

    Route::post('pro-update_status', 'Vendor\Listing\ProductController@updateStatus')->name('vendor.listing_management.listing.update_product_status');

    Route::get('edit-product/{id}', 'Vendor\Listing\ProductController@edit')->name('vendor.listing_management.edit_product');

    Route::post('product-update/{id}', 'Vendor\Listing\ProductController@update')->name('vendor.listing_management.update_product')->middleware('packageLimitsCheck:listing,update');


    Route::post('pro-delete/{id}', 'Vendor\Listing\ProductController@delete')->name('vendor.listing_management.product.delete_product');

    Route::post('/product-bulk-delete', 'Vendor\Listing\ProductController@bulkDelete')->name('vendor.listing_management.listing.product.bulk_delete_product');


    //#==========Listing product slider image
    Route::post('/pro-img-store', 'Vendor\Listing\ProductController@imagesstore')->name('vendor.listing.product.imagesstore');

    Route::post('/pro-img-remove', 'Vendor\Listing\ProductController@imagermv')->name('vendor.listing.product.imagermv');
    Route::post('/pro-img-db-remove', 'Vendor\Listing\ProductController@imagedbrmv')->name('vendor.listing.product.imgdbrmv');
    //#==========Listing Product slider image End

    //#================Listing Products End

    //#==========Listing slider image
    Route::post('/img-store', 'Vendor\Listing\ListingController@imagesstore')->name('vendor.listing.imagesstore');
    Route::post('/img-remove', 'Vendor\Listing\ListingController@imagermv')->name('vendor.listing.imagermv');
    Route::post('/img-db-remove', 'Vendor\Listing\ListingController@imagedbrmv')->name('vendor.listing.imgdbrmv');
    //#==========Listing slider image End
  });





  //MAil set for recived Mail
  Route::get('/mail-to-vendor', 'Vendor\MAilSetController@mailToAdmin')->name('vendor.email_setting.mail_to_admin');

  Route::post('/update-mail-to-vendor', 'Vendor\MAilSetController@updateMailToAdmin')->name('vendor.update_mail_to_vendor');

  //Show message
  Route::get('/listing-messages', 'Vendor\MessageController@index')->name('vendor.listing.messages');
  Route::post('/listing-message/delete', 'Vendor\MessageController@delete')->name('vendor.listing.message.delete_message');

  Route::post('listing-bulk_delete', 'Vendor\MessageController@bulkDelete')->name('vendor.listing.message.bulk_delete.message');


  Route::get('/product-messages', 'Vendor\MessageController@productIndex')->name('vendor.product.messages');
  Route::post('/product-message/delete', 'Vendor\MessageController@productDelete')->name('vendor.product.message.delete_message');

  Route::post('product-bulk_delete', 'Vendor\MessageController@productBulkDelete')->name('vendor.product.message.bulk_delete.message');
  //End Message

  //profile

  Route::get('dashboard', 'Vendor\VendorController@dashboard')->name('vendor.dashboard');
  Route::get('/change-password', 'Vendor\VendorController@change_password')->name('vendor.change_password');
  Route::post('/update-password', 'Vendor\VendorController@updated_password')->name('vendor.update_password');
  Route::get('/edit-profile', 'Vendor\VendorController@edit_profile')->name('vendor.edit.profile');
  Route::post('/profile/update', 'Vendor\VendorController@update_profile')->name('vendor.update_profile');
  Route::get('/logout', 'Vendor\VendorController@logout')->name('vendor.logout');

  // change admin-panel theme (dark/light) route
  Route::post('/change-theme', 'Vendor\VendorController@changeTheme')->name('vendor.change_theme');
  Route::get('/payment-log', 'Vendor\VendorController@payment_log')->name('vendor.payment_log');

  //vendor package extend route
  Route::get('/package-list', 'Vendor\BuyPlanController@index')->name('vendor.plan.extend.index');
  Route::get('/package/checkout/{package_id}', 'Vendor\BuyPlanController@checkout')->name('vendor.plan.extend.checkout');
  Route::post('/package/checkout', 'Vendor\VendorCheckoutController@checkout')->name('vendor.plan.checkout');

  Route::post('/payment/instructions', 'Vendor\VendorCheckoutController@paymentInstruction')->name('vendor.payment.instructions');


  //checkout payment gateway routes
  Route::prefix('membership')->group(function () {
    Route::get('paypal/success', "Payment\PaypalController@successPayment")->name('membership.paypal.success');
    Route::get('paypal/cancel', "Payment\PaypalController@cancelPayment")->name('membership.paypal.cancel');
    Route::get('stripe/cancel', "Payment\StripeController@cancelPayment")->name('membership.stripe.cancel');
    Route::post('paytm/payment-status', "Payment\PaytmController@paymentStatus")->name('membership.paytm.status');
    Route::get('paystack/success', 'Payment\PaystackController@successPayment')->name('membership.paystack.success');
    Route::post('mercadopago/cancel', 'Payment\paymenMercadopagoController@cancelPayment')->name('membership.mercadopago.cancel');
    Route::get('mercadopago/success', 'Payment\MercadopagoController@successPayment')->name('membership.mercadopago.success');
    Route::post('razorpay/success', 'Payment\RazorpayController@successPayment')->name('membership.razorpay.success');
    Route::post('razorpay/cancel', 'Payment\RazorpayController@cancelPayment')->name('membership.razorpay.cancel');
    Route::get('instamojo/success', 'Payment\InstamojoController@successPayment')->name('membership.instamojo.success');
    Route::post('instamojo/cancel', 'Payment\InstamojoController@cancelPayment')->name('membership.instamojo.cancel');
    Route::post('flutterwave/success', 'Payment\FlutterWaveController@successPayment')->name('membership.flutterwave.success');
    Route::post('flutterwave/cancel', 'Payment\FlutterWaveController@cancelPayment')->name('membership.flutterwave.cancel');
    Route::get('/mollie/success', 'Payment\MollieController@successPayment')->name('membership.mollie.success');
    Route::post('mollie/cancel', 'Payment\MollieController@cancelPayment')->name('membership.mollie.cancel');
    Route::get('anet/cancel', 'Payment\AuthorizeController@cancelPayment')->name('membership.anet.cancel');
    Route::get('/offline/success', 'Front\CheckoutController@offlineSuccess')->name('membership.offline.success');
    Route::get('/trial/success', 'Front\CheckoutController@trialSuccess')->name('membership.trial.success');

    Route::get('/online/success', 'Vendor\VendorCheckoutController@onlineSuccess')->name('success.page');
  });

  #====support tickets ============
  Route::get('support/ticket/create', 'Vendor\SupportTicketController@create')->name('vendor.support_ticket.create');
  Route::post('support/ticket/store', 'Vendor\SupportTicketController@store')->name('vendor.support_ticket.store');
  Route::get('support/tickets', 'Vendor\SupportTicketController@index')->name('vendor.support_tickets');
  Route::get('support/message/{id}', 'Vendor\SupportTicketController@message')->name('vendor.support_tickets.message');
  Route::post('support-ticket/zip-upload', 'Vendor\SupportTicketController@zip_file_upload')->name('vendor.support_ticket.zip_file.upload');
  Route::post('support-ticket/reply/{id}', 'Vendor\SupportTicketController@ticketreply')->name('vendor.support_ticket.reply');

  Route::post('support-ticket/delete/{id}', 'Vendor\SupportTicketController@delete')->name('vendor.support_tickets.delete');
});
