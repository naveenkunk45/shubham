<?php

namespace App\Http\Controllers\Admin\FeaturedListing;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Exports\ProductOrdersExport;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Models\BasicSettings\Basic;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Shop\ProductOrder;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Session;
use Maatwebsite\Excel\Facades\Excel;
use App\Models\FeatureOrder;
use App\Models\BasicSettings\MailTemplate;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\VendorInfo;
use Config;
use Exception;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Mail;

class OrderRequestController extends Controller
{
    public function index(Request $request)
    {
        $information['langs'] = Language::all();
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $orderNumber = $paymentStatus = $orderStatus = $title = null;

        $listingIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }

        $orders = FeatureOrder::query()->when($orderNumber, function ($query, $orderNumber) {
            return $query->where('order_number', 'like', '%' . $orderNumber . '%');
        })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('feature_orders.listing_id', $listingIds);
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('order_status', '=', $orderStatus);
            })
            ->orderByDesc('id')
            ->paginate(10);

        $information['orders'] = $orders;
        return view('admin.featured-listing.index',  $information);
    }
    public function pending(Request $request)
    {
        $information['langs'] = Language::all();
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $orderNumber = $paymentStatus = $orderStatus = $title = null;

        $listingIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }

        $orders = FeatureOrder::query()->when($orderNumber, function ($query, $orderNumber) {
            return $query->where('order_number', 'like', '%' . $orderNumber . '%');
        })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('feature_orders.listing_id', $listingIds);
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('order_status', '=', $orderStatus);
            })
            ->where('order_status', 'pending')
            ->orderByDesc('id')
            ->paginate(10);

        $information['orders'] = $orders;
        return view('admin.featured-listing.pending',  $information);
    }
    public function approved(Request $request)
    {
        $information['langs'] = Language::all();
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $orderNumber = $paymentStatus = $orderStatus = $title = null;

        $listingIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }

        $orders = FeatureOrder::query()->when($orderNumber, function ($query, $orderNumber) {
            return $query->where('order_number', 'like', '%' . $orderNumber . '%');
        })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('feature_orders.listing_id', $listingIds);
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('order_status', '=', $orderStatus);
            })
            ->where('order_status', 'completed')
            ->orderByDesc('id')
            ->paginate(10);

        $information['orders'] = $orders;
        return view('admin.featured-listing.approve',  $information);
    }
    public function rejected(Request $request)
    {
        $information['langs'] = Language::all();
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $orderNumber = $paymentStatus = $orderStatus = $title = null;

        $listingIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }

        $orders = FeatureOrder::query()->when($orderNumber, function ($query, $orderNumber) {
            return $query->where('order_number', 'like', '%' . $orderNumber . '%');
        })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('feature_orders.listing_id', $listingIds);
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('order_status', '=', $orderStatus);
            })
            ->where('order_status', 'rejected')
            ->orderByDesc('id')
            ->paginate(10);

        $information['orders'] = $orders;
        return view('admin.featured-listing.rejected',  $information);
    }

    public function updatePaymentStatus(Request $request, $id)
    {
        $order = FeatureOrder::find($id);
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        $listing = Listing::with(['listing_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        }])->where('id', $order->listing_id)->first();

        $listing_name = $listing->listing_content[0]->title;
        $slug = $listing->listing_content[0]->slug;
        $url = route('frontend.listing.details', ['slug' => $slug, 'id' => $listing->id]);


        $vendor = VendorInfo::Where('vendor_id', $order->vendor_id)->first();

        $info = Basic::select('google_recaptcha_status')->first();
        if ($info->google_recaptcha_status == 1) {
            $rules['g-recaptcha-response'] = 'required|captcha';
        }

        $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();



        if ($request['payment_status'] == 'pending') {

            $order->update([
                'payment_status' => 'pending'
            ]);
        } else if ($request['payment_status'] == 'completed') {

            $order->update([
                'payment_status' => 'completed'
            ]);

            $mail_template = MailTemplate::where('mail_type', 'payment_accepted_for_featured_offline_gateway')->first();

            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;
                $body = preg_replace("/{username}/", $vendor->name, $body);
                $body = preg_replace("/{payment_via}/", $order->payment_method, $body);
                $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
                $body = preg_replace("/{package_price}/", symbolPrice($order->total), $body);
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
                        'to' => $order->vendor_mail,
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

                    Session::flash('success', 'Message sent successfully');
                    return back();
                } catch (Exception $e) {
                    Session::flash('error', $e);
                    return back();
                }
            }
        } else {

            $order->update([
                'payment_status' => 'rejected',
                'order_status' => 'rejected'
            ]);
            $mail_template = MailTemplate::where('mail_type', 'payment_rejected_for_buy_feature_offline_gateway')->first();

            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;

                $body = preg_replace("/{payment_via}/", $order->payment_method, $body);
                $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
                $body = preg_replace("/{package_price}/", symbolPrice($order->total), $body);
                $body = preg_replace("/{username}/", $vendor->name, $body);
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
                        'to' => $order->vendor_mail,
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

                    Session::flash('success', 'Message sent successfully');
                    return back();
                } catch (Exception $e) {
                    Session::flash('error', $e);
                    return back();
                }
            }
        }
        return redirect()->back();
    }


    public function updateOrderStatus(Request $request, $id)
    {
        $order = FeatureOrder::find($id);

        $vendor = VendorInfo::Where('vendor_id', $order->vendor_id)->first();

        $info = Basic::select('google_recaptcha_status')->first();
        if ($info->google_recaptcha_status == 1) {
            $rules['g-recaptcha-response'] = 'required|captcha';
        }

        $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();

        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        $listing = Listing::with(['listing_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        }])->where('id', $order->listing_id)->first();

        $listing_name = $listing->listing_content[0]->title;
        $slug = $listing->listing_content[0]->slug;
        $url = route('frontend.listing.details', ['slug' => $slug, 'id' => $listing->id]);



        if ($request['order_status'] == 'pending') {

            $order->update([
                'order_status' => 'pending'
            ]);
        } else if ($request['order_status'] == 'completed') {

            $days = $order->days;

            $startDates = Carbon::now()->startOfDay();
            $endDates = $startDates->copy()->addDays($days);

            $order->update([

                'order_status' => 'completed',
                'start_date' => $startDates,
                'end_date' => $endDates

            ]);
            $startDate = $startDates->format('j F, Y');
            $endDate = $endDates->format('j F, Y');
            $mail_template = MailTemplate::where('mail_type', 'listing_feature_active')->first();

            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;
                $body = preg_replace("/{username}/", $vendor->name, $body);
                $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
                $body = preg_replace("/{days}/", $days, $body);

                $body = preg_replace("/{activation_date}/", $startDate, $body);

                $body = preg_replace("/{end_date}/", $endDate, $body);
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
                        'to' => $order->vendor_mail,
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

                    Session::flash('success', 'Message sent successfully');
                    return back();
                } catch (Exception $e) {
                    Session::flash('error', $e);
                    return back();
                }
            }
        } else {

            $order->update([
                'order_status' => 'rejected'
            ]);

            $mail_template = MailTemplate::where('mail_type', 'listing_feature_reject')->first();

            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;
                $body = preg_replace("/{username}/", $vendor->name, $body);
                $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
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
                        'to' => $order->vendor_mail,
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

                    Session::flash('success', 'Message sent successfully');
                    return back();
                } catch (Exception $e) {
                    Session::flash('error', $e);
                    return back();
                }
            }
        }

        return redirect()->back();
    }



    public function destroy($id)
    {
        $order = FeatureOrder::find($id);

        // delete the attachment
        @unlink(public_path('assets/file/attachments/feature-activation/') . $order->attachment);

        $order->delete();

        return redirect()->back()->with('success', 'Deleted successfully!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $order = FeatureOrder::find($id);

            // delete the attachment
            @unlink(public_path('assets/file/attachments/feature-activation/') . $order->attachment);

            $order->delete();
        }

        Session::flash('success', 'Selectet item deleted successfully!');

        return response()->json(['status' => 'success'], 200);
    }
}
