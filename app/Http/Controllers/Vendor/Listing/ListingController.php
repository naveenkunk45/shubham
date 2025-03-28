<?php

namespace App\Http\Controllers\Vendor\Listing;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use App\Http\Helpers\VendorPermissionHelper;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use App\Models\Listing\ListingImage;
use App\Models\Listing\Listing;
use App\Http\Requests\Listing\ListingStoreRequest;
use App\Models\Language;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingFeature;
use App\Models\Listing\ListingSocialMedia;
use App\Models\BusinessHour;
use App\Models\Listing\ListingProduct;
use Mews\Purifier\Facades\Purifier;
use Illuminate\Support\Facades\Auth;
use App\Models\FeaturedListingCharge;
use App\Models\Location\City;
use App\Models\Location\State;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\PaymentGateway\OfflineGateway;
use App\Http\Requests\Listing\ListingUpdateRequest;
use App\Models\BasicSettings\Basic;
use App\Models\FeatureOrder;
use App\Models\Listing\ListingFeatureContent;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ListingReview;
use App\Models\Listing\ProductMessage;
use App\Models\ListingCategory;
use App\Models\Visitor;

class ListingController extends Controller
{
    public function index(Request $request)
    {
        $information['currencyInfo'] = $this->getCurrencyInfo();
        $information['langs'] = Language::all();

        if ($request->language) {
            $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        } else {
            $language = Language::where('is_default', 1)->first();
        }

        $information['language'] = $language;

        $language_id = $language->id;
        $status = $title = $category =  null;
        if (request()->filled('status') && request()->input('status') !== "All") {
            $status = request()->input('status');
        }

        $category_listingIds = [];
        if ($request->filled('category') && $request->input('category') !== "All") {
            $category = $request->input('category');
            $category_content = ListingCategory::where([['language_id', $language->id], ['slug', $category]])->first();

            if (!is_null($category_content)) {
                $category = $category_content->id;
                $contents = ListingContent::where('language_id', $language->id)
                    ->where('category_id', $category)
                    ->get()
                    ->pluck('listing_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_listingIds)) {
                        array_push($category_listingIds, $content);
                    }
                }
            }
        }

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

        $information['listings'] = Listing::with([
            'listing_content' => function ($q) use ($language_id) {
                $q->where('language_id', $language_id);
            }, 'vendor'
        ])
            ->when($category, function ($query) use ($category_listingIds) {
                return $query->whereIn('listings.id', $category_listingIds);
            })

            ->when($status, function ($query) use ($status) {

                if ($status === 'approved') {
                    return $query->where('status', 1);
                } elseif ($status === 'pending') {
                    return $query->where('status', 0);
                } else {
                    return $query->where('status', 2);
                }
            })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('listings.id', $listingIds);
            })
            ->where('vendor_id', Auth::guard('vendor')->user()->id)
            ->orderBy('id', 'desc')
            ->paginate(10);
        $information['vendors'] = Vendor::where('id', '!=', 0)->get();
        $information['categories'] = ListingCategory::Where('language_id', $language_id)->get();

        //Feature part
        $information['onlineGateways'] = OnlineGateway::where('status', 1)->get();

        $information['offline_gateways'] = OfflineGateway::where('status', 1)->orderBy('serial_number', 'asc')->get();

        $stripe = OnlineGateway::where('keyword', 'stripe')->first();
        $stripe_info = json_decode($stripe->information, true);
        $information['stripe_key'] = $stripe_info['key'];

        $authorizenet = OnlineGateway::query()->whereKeyword('authorize.net')->first();
        $anetInfo = json_decode($authorizenet->information);

        if ($anetInfo->sandbox_check == 1) {
            $information['anetSource'] = 'https://jstest.authorize.net/v1/Accept.js';
        } else {
            $information['anetSource'] = 'https://js.authorize.net/v1/Accept.js';
        }

        $information['anetClientKey'] = $anetInfo->public_key;
        $information['anetLoginId'] = $anetInfo->login_id;



        $charges = FeaturedListingCharge::orderBy('days')->get();
        $information['charges'] = $charges;
        return view('vendors.listing.index', $information);
    }

    public function updateVisibility(Request $request)
    {

        $vendorId = Auth::guard('vendor')->user()->id;
        $current_package = VendorPermissionHelper::packagePermission($vendorId);

        if ($current_package != '[]') {

            $listing = Listing::findOrFail($request->listingId);

            if ($request->visibility == 1) {
                $listing->update(['visibility' => 1]);

                Session::flash('success', 'Listing Show successfully!');
            }
            if ($request->visibility == 0) {
                $listing->update(['visibility' => 0]);

                Session::flash('success', 'Listing Hide successfully!');
            }

            return redirect()->back();
        } else {

            Session::flash('warning', 'Please Buy a plan to manage Hide/Show!');
            return redirect()->route('vendor.listing_management.listing');
        }
    }

    public function create()
    {
        $information = [];
        $languages = Language::get();
        $information['languages'] = $languages;
        $information['vendors'] = Vendor::get();
        return view('vendors.listing.create', $information);
    }
    public function imagesstore(Request $request)
    {
        $img = $request->file('file');
        $allowedExts = array('jpg', 'png', 'jpeg', 'svg', 'webp');
        $rules = [
            'file' => [
                function ($attribute, $value, $fail) use ($img, $allowedExts) {
                    $ext = $img->getClientOriginalExtension();
                    if (!in_array($ext, $allowedExts)) {
                        return $fail("Only png, jpg, jpeg images are allowed");
                    }
                },
            ]
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            $validator->getMessageBag()->add('error', 'true');
            return response()->json($validator->errors());
        }
        $filename = uniqid() . '.jpg';

        $directory = public_path('assets/img/listing-gallery/');
        @mkdir($directory, 0775, true);
        $img->move($directory, $filename);

        $pi = new ListingImage();
        $pi->image = $filename;
        $pi->save();
        return response()->json(['status' => 'success', 'file_id' => $pi->id]);
    }
    public function imagermv(Request $request)
    {
        $pi = ListingImage::findOrFail($request->fileid);
        $image_count = ListingImage::where('listing_id', $pi->listing_id)->get()->count();
        if ($image_count > 1) {
            @unlink(public_path('assets/img/listing-gallery/') . $pi->image);
            $pi->delete();
            return $pi->id;
        } else {
            return 'false';
        }
    }
    public function imagedbrmv(Request $request)
    {
        $pi = ListingImage::findOrFail($request->fileid);
        $image_count = ListingImage::where('listing_id', $pi->listing_id)->get()->count();
        if ($image_count > 1) {
            @unlink(public_path('assets/img/listing-gallery/') . $pi->image);
            $pi->delete();

            Session::flash('success', 'Slider image deleted successfully!');

            return Response::json(['status' => 'success'], 200);
        } else {
            Session::flash('warning', 'You can\'t delete all images.!!');

            return Response::json(['status' => 'success'], 200);
        }
    }
    public function getState(Request $request)
    {
        $data['states'] = State::where('country_id', $request->id)->get();
        $data['cities'] = City::where('country_id', $request->id)->get();
        return $data;
    }
    public function getCity(Request $request)
    {
        $data = City::where('state_id', $request->id)->get();
        return $data;
    }
    public function store(ListingStoreRequest $request)
    {
        if ($request->can_listing_add == 2) {

            Session::flash('warning', 'You listings limit reached or exceeded');

            return Response::json(['status' => 'error'], 200);
        } elseif ($request->can_listing_add == 1) {

            $featuredImgURL = $request->feature_image;
            $videoImgURL = $request->video_background_image;

            $languages = Language::all();

            $in = $request->all();


            if ($request->feature_image) {
                $featuredImgExt = $featuredImgURL->getClientOriginalExtension();
                // set a name for the featured image and store it to local storage
                $featuredImgName = time() . '.' . $featuredImgExt;
                $featuredDir = public_path('assets/img/listing/');

                if (!file_exists($featuredDir)) {
                    @mkdir($featuredDir, 0777, true);
                }

                copy($featuredImgURL, $featuredDir . $featuredImgName);
                $in['feature_image'] = $featuredImgName;
            }

            if ($request->video_background_image) {
                $videoImgExt = $videoImgURL->getClientOriginalExtension();
                // set a name for the featured image and store it to local storage
                $videoImgName = time() . '.' . $videoImgExt;
                $videoDir = public_path('assets/img/listing/video/');

                if (!file_exists($videoDir)) {
                    @mkdir($videoDir, 0777, true);
                }

                copy($videoImgURL, $videoDir . $videoImgName);
                $in['video_background_image'] = $videoImgName;
            }

            $videoLink = $request->video_url;
            if ($videoLink) {
                if (strpos($videoLink, "&") != false) {
                    $videoLink = substr($videoLink, 0, strpos($videoLink, "&"));
                }
                $in['video_url'] = $videoLink;
            }

            $listing = Listing::create($in);

            $siders = $request->slider_images;
            if ($siders) {
                $pis = ListingImage::findOrFail($siders);

                foreach ($pis as $key => $pi) {
                    $pi->listing_id = $listing->id;
                    $pi->save();
                }
            }

            foreach ($languages as $language) {
                $listingContent = new ListingContent();

                $listingContent->language_id = $language->id;
                $listingContent->listing_id = $listing->id;
                $listingContent->title = $request[$language->code . '_title'];
                $listingContent->slug = createSlug($request[$language->code . '_title']);
                $listingContent->category_id = $request[$language->code . '_category_id'];
                $listingContent->country_id = $request[$language->code . '_country_id'];
                $listingContent->state_id = $request[$language->code . '_state_id'];
                $listingContent->city_id = $request[$language->code . '_city_id'];
                $listingContent->address = $request[$language->code . '_address'];

                $aminities = $request->input($language->code . '_aminities', []);
                $listingContent->aminities = json_encode($aminities);

                $listingContent->description = Purifier::clean($request[$language->code . '_description'], 'youtube');
                $listingContent->meta_keyword = $request[$language->code . '_meta_keyword'];
                $listingContent->meta_description = $request[$language->code . '_meta_description'];

                $listingContent->save();
            }

            //adding business hours
            $days = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
            foreach ($days as $day) {
                $businessHours = new BusinessHour();

                $businessHours->listing_id = $listing->id;
                $businessHours->day = $day;
                $businessHours->start_time = "10:00 AM";
                $businessHours->end_time = "07:00 PM";
                $businessHours->holiday = 1;

                $businessHours->save();
            }
            Session::flash('success', 'New Listing added successfully!');
            $info = Basic::select('to_mail', 'website_title')->first();
            $vendor =Auth::guard('vendor')->user()->username;

            $mailData['subject'] = "New Listing Posted on $info->website_title";
            $mailBody = "Dear Admin,
            
I hope this email finds you well. I wanted to bring to your attention that a new listing has been posted on our website by $vendor.

Thank you for your attention to this matter.";

            $mailData['body'] = nl2br($mailBody);
            $mailData['recipient'] = $info->to_mail;

            BasicMailer::sendMail($mailData);

            return Response::json(['status' => 'success'], 200);
        } else {
            Session::flash('warning', 'Please Buy a plan to add a Listing.!');

            return Response::json(['status' => 'error'], 200);
        }
    }

    public function manageSocialLink($id)
    {
        Listing::findOrFail($id);
        $permission = socialLinksPermission($id);
        if ($permission) {
            $vendor_id = Listing::where('id', $id)->pluck('vendor_id')->first();
            if ($vendor_id == Auth::guard('vendor')->user()->id) {
                $vendorId = Auth::guard('vendor')->user()->id;
                $current_package = VendorPermissionHelper::packagePermission($vendorId);

                if ($current_package != '[]') {

                    $information['listing_id'] = $id;
                    $information['socialLinks'] = ListingSocialMedia::Where('listing_id', $id)->get();
                    $information['totalsocialLinks'] = ListingSocialMedia::where('listing_id', $id)->count();
                    return view('vendors.listing.social-link', $information);
                } else {

                    Session::flash('warning', 'Please Buy a plan to manage social link!');
                    return redirect()->route('vendor.listing_management.listing');
                }
            } else {

                Session::flash('warning', 'You dont have any permission!');
                return redirect()->route('vendor.listing_management.listing');
            }
        } else {
            Session::flash('warning', "You dont have Permission.");
            return redirect()->route('vendor.listing_management.listing');
        }
    }

    public function updateSocialLink(Request $request, $id)
    {
        $SocialLinkLimit = packageTotalSocialLink(Auth::guard('vendor')->user()->id);

        $request->validate([
            'socail_link' => [
                'sometimes',
                'array',
                'max:' . $SocialLinkLimit,
            ],
            'socail_link.*' => [
                'required',
            ],
            'icons' => 'required',
        ]);

        ListingSocialMedia::where('listing_id', $id)->delete();

        $iconsString = ($request->icons);
        $iconArray = explode(',', $iconsString);

        if (!empty($request->socail_link)) {

            foreach ($request->socail_link as $key => $link) {

                ListingSocialMedia::create([
                    'listing_id' => $id,
                    'link' => $link,
                    'icon' => $iconArray[$key]
                ]);
            }
        }

        Session::flash('success', 'Social Link Updated successfully!');

        return Response::json(['status' => 'success'], 200);
    }
    public function manageAdditionalSpecification($id)
    {
        Listing::findOrFail($id);
        $permission = additionalSpecificationsPermission($id);
        if ($permission) {

            $vendor_id = Listing::where('id', $id)->pluck('vendor_id')->first();
            if ($vendor_id == Auth::guard('vendor')->user()->id) {
                $vendorId = Auth::guard('vendor')->user()->id;
                $current_package = VendorPermissionHelper::packagePermission($vendorId);

                if ($current_package != '[]') {

                    $information['listing_id'] = $id;
                    $information['languages'] = Language::all();
                    $information['features'] = ListingFeature::where('listing_id', $id)->get();
                    $information['totalFeature'] = ListingFeature::where('listing_id', $id)->count();
                    return view('vendors.listing.feature', $information);
                } else {

                    Session::flash('warning', 'Please Buy a plan to manage Features!');
                    return redirect()->route('vendor.listing_management.listing');
                }
            } else {

                Session::flash('warning', 'You dont have any permission!');
                return redirect()->route('vendor.listing_management.listing');
            }
        } else {
            Session::flash('warning', "You dont have any permission.");
            return redirect()->route('vendor.listing_management.listing');
        }
    }

    public function updateAdditionalSpecification(Request $request, $id)
    {
        $rules = [];
        $messages = [];
        $languages = Language::all();

        $additionalFeatureLimit = packageTotalAdditionalSpecification(Auth::guard('vendor')->user()->id);
        foreach ($languages as $language) {

            $rules[$language->code . '_feature_heading'] = 'sometimes|array|max:' . $additionalFeatureLimit;
            $rules[$language->code . '_feature_heading.*'] = 'required';


            $messages[$language->code . '_feature_heading.*.required'] = 'The ' . $language->name . ' Feature Heading is required.';
            $messages[$language->code . '_feature_heading.array'] = 'The ' . $language->name . ' Feature Heading must be an array.';
            $messages[$language->code . '_feature_heading.max'] =  'Maximum ' . $additionalFeatureLimit . ' Additional Features can be added per listing for ' . $language->name . ' Language';
        }

        $request->validate($rules, $messages);

        $listingFeatures = ListingFeature::where('listing_id', $id)->get();
        foreach ($listingFeatures as $listingFeature) {
            $listingFeaturesContents = ListingFeatureContent::where('listing_feature_id', $listingFeature->id)->get();
            foreach ($listingFeaturesContents as $listingFeaturesContent) {
                $listingFeaturesContent->delete();
            }
            $listingFeature->delete();
        }

        foreach ($languages as $language) {

            if (!empty(($request[$language->code . '_feature_heading']))) {

                foreach ($request[$language->code . '_feature_heading'] as $key => $v_helper) {
                    $feature_value = $request[$language->code . '_feature_value_' . $key];

                    $listing_feature = ListingFeature::where([['listing_id', $id], ['indx', $key]])->first();
                    if (is_null($listing_feature)) {

                        ListingFeature::create([
                            'listing_id' => $id,
                            'indx' =>  $key
                        ]);
                    }
                    $listing_feature = ListingFeature::where([['listing_id', $id], ['indx', $key]])->first();
                    $listing_specification_content = new ListingFeatureContent();
                    $listing_specification_content->language_id = $language->id;
                    $listing_specification_content->listing_feature_id = $listing_feature->id;
                    $listing_specification_content->feature_heading = $v_helper;
                    $listing_specification_content->feature_value = json_encode($feature_value);
                    $listing_specification_content->save();
                }
            }
        }

        Session::flash('success', 'Feature Updated successfully!');

        return Response::json(['status' => 'success'], 200);
    }

    public function edit($id)
    {
        $vendorId = Auth::guard('vendor')->user()->id;
        $current_package = VendorPermissionHelper::packagePermission($vendorId);

        if ($current_package != '[]') {
            $information['listing'] = Listing::with('galleries')->where('vendor_id', '=', Auth::guard('vendor')->user()->id)->findOrFail($id);
            $information['languages'] = Language::all();
            return view('vendors.listing.edit', $information);
        } else {

            Session::flash('warning', 'Please Buy a plan to edit listing!');
            return redirect()->route('vendor.listing_management.listing');
        }
    }

    public function update(ListingUpdateRequest $request, $id)
    {
        $featuredImgURL = $request->thumbnail;
        $videoImgURL = $request->video_background_image;

        $allowedExts = array('jpg', 'png', 'jpeg', 'svg');
        if ($request->hasFile('thumbnail')) {
            $rules['thumbnail'] = [
                'required',
                function ($attribute, $value, $fail) use ($featuredImgURL, $allowedExts) {
                    $ext = $featuredImgURL->getClientOriginalExtension();
                    if (!in_array($ext, $allowedExts)) {
                        return $fail("Only png, jpg, jpeg images are allowed");
                    }
                },
            ];
        }

        if ($request->hasFile('video_background_image')) {
            $rules['video_background_image'] = [
                'required',
                function ($attribute, $value, $fail) use ($featuredImgURL, $allowedExts) {
                    $ext = $featuredImgURL->getClientOriginalExtension();
                    if (!in_array($ext, $allowedExts)) {
                        return $fail("Only png, jpg, jpeg images are allowed");
                    }
                },
            ];
        }

        $languages = Language::all();

        $in = $request->all();
        $listing = Listing::findOrFail($request->listing_id);
        if ($request->hasFile('thumbnail')) {
            $featuredImgExt = $featuredImgURL->getClientOriginalExtension();

            $featuredImgName = time() . '.' . $featuredImgExt;
            $featuredDir = public_path('assets/img/listing/');

            if (!file_exists($featuredDir)) {
                mkdir($featuredDir, 0777, true);
            }
            copy($featuredImgURL, $featuredDir . $featuredImgName);
            @unlink(public_path('assets/img/listing/') . $listing->feature_image);

            $in['feature_image'] = $featuredImgName;
        }

        if ($request->hasFile('video_background_image')) {
            $videoImgExt = $videoImgURL->getClientOriginalExtension();

            $videoImgName = time() . '.' . $videoImgExt;
            $videoDir = public_path('assets/img/listing/video/');

            if (!file_exists($videoDir)) {
                mkdir($videoDir, 0777, true);
            }
            copy($videoImgURL, $videoDir . $videoImgName);
            @unlink(public_path('assets/img/listing/video/') . $listing->video_background_image);

            $in['video_background_image'] = $videoImgName;
        }
        $videoLink = $request->video_url;
        if ($videoLink) {
            if (strpos($videoLink, "&") != false) {
                $videoLink = substr($videoLink, 0, strpos($videoLink, "&"));
            }
            $in['video_url'] = $videoLink;
        }


        $listing = $listing->update($in);

        $slders = $request->slider_images;
        if ($slders) {
            $pis = ListingImage::findOrFail($slders);
            foreach ($pis as $key => $pi) {
                $pi->listing_id = $request->listing_id;
                $pi->save();
            }
        }


        foreach ($languages as $language) {
            $listingContent =  ListingContent::where('listing_id', $request->listing_id)->where('language_id', $language->id)->first();
            if (empty($listingContent)) {
                $listingContent = new ListingContent();
            }
            $listingContent->language_id = $language->id;
            $listingContent->title = $request[$language->code . '_title'];
            $listingContent->slug = createSlug($request[$language->code . '_title']);
            $listingContent->category_id = $request[$language->code . '_category_id'];
            $listingContent->country_id = $request[$language->code . '_country_id'];
            $listingContent->state_id = $request[$language->code . '_state_id'];
            $listingContent->city_id = $request[$language->code . '_city_id'];
            $listingContent->address = $request[$language->code . '_address'];
            $aminities = $request->input($language->code . '_aminities', []);
            $listingContent->aminities = json_encode($aminities);
            $listingContent->description = Purifier::clean($request[$language->code . '_description'], 'youtube');
            $listingContent->meta_keyword = $request[$language->code . '_meta_keyword'];
            $listingContent->meta_description = $request[$language->code . '_meta_description'];
            $listingContent->save();
        }

        Session::flash('success', 'Listing Updated successfully!');

        return Response::json(['status' => 'success'], 200);
    }

    public function videoImageRemove($id)
    {

        $Listing = Listing::Where('id', $id)->first();


        $Listing->video_background_image = null;

        $Listing->save();

        Session::flash('success', 'Successfully Delete Video Image');

        return Response::json(['status' => 'success'], 200);
    }
    public function delete($id)
    {
        $listing = Listing::findOrFail($id);

        //delete all the contents of this listing
        $contents = $listing->listing_content()->get();

        foreach ($contents as $content) {
            $content->delete();
        }

        // delete feature_image image and video image of this listing
        if (!is_null($listing->feature_image)) {
            @unlink(public_path('assets/img/listing/') . $listing->feature_image);
        }
        if (!is_null($listing->video_background_image)) {
            @unlink(public_path('assets/img/listing/video/') . $listing->video_background_image);
        }

        //delete all the images of this listing
        $galleries = $listing->galleries()->get();

        foreach ($galleries as $gallery) {
            @unlink(public_path('assets/img/listing-gallery/') . $gallery->image);
            $gallery->delete();
        }
        //delete all Features for this listing
        $listingFeatures =  $listing->specifications()->get();
        foreach ($listingFeatures as $listingFeature) {
            $listingFeaturesContents = ListingFeatureContent::where('listing_feature_id', $listingFeature->id)->get();
            foreach ($listingFeaturesContents as $listingFeaturesContent) {
                $listingFeaturesContent->delete();
            }
            $listingFeature->delete();
        }

        //delete feature order
        $featureOrders = FeatureOrder::where('listing_id', $id)->get();
        if (!is_null($featureOrders)) {

            foreach ($featureOrders as $order) {
                if (!is_null($order->attachment)) {
                    @unlink(public_path('assets/file/attachments/feature-activation/') . $order->attachment);
                }
                $order->delete();
            }
        }
        //delete all message for this listing
        $listingMessages = ListingMessage::where('listing_id', $id)->get();
        if (!is_null($listingMessages)) {

            foreach ($listingMessages as $message) {
                $message->delete();
            }
        }
        //delete all reviews for this listing
        $reviews = ListingReview::where('listing_id', $id)->get();
        if (!is_null($reviews)) {
            foreach ($reviews as $review) {
                $review->delete();
            }
        }
        //delete all visitoirs for this listing
        $visitors  = Visitor::where('listing_id', $id)->get();
        if (!is_null($visitors)) {
            foreach ($visitors as $visitor) {
                $visitor->delete();
            }
        }

        //delete all faq for this listing
        $faqs = $listing->listingFaqs()->get();
        foreach ($faqs as $faq) {
            $faq->delete();
        }
        //delete all follow us  for this listing
        $sociallinks = $listing->sociallinks()->get();
        foreach ($sociallinks as $sociallink) {
            $sociallink->delete();
        }

        //delete all business hours for this listing
        BusinessHour::where('listing_id', $id)->delete();


        //delete all products
        $products = ListingProduct::where('listing_id', $id)->get();

        if (!is_null($products)) {

            foreach ($products as $product) {

                $productcontents = $product->listing_product_content()->get();
                //delete all product contents
                foreach ($productcontents as $productcontent) {
                    $productcontent->delete();
                }
                //delete product feature image
                if (!is_null($product->feature_image)) {
                    @unlink(public_path('assets/img/listing/product/') . $product->feature_image);
                }

                //delete all product slider images
                $galleries = $product->galleries()->get();

                foreach ($galleries as $gallery) {
                    @unlink(public_path('assets/img/listing/product-gallery/') . $gallery->image);
                    $gallery->delete();
                }
                //delete this product
                //delete all message for this product
                $productMessages = ProductMessage::where('product_id', $product->id)->get();
                if (!is_null($productMessages)) {
                    foreach ($productMessages as $message) {
                        $message->delete();
                    }
                }
                $product->delete();
            }
        }
        // finally, delete this listing
        $listing->delete();

        Session::flash('success', 'Listing deleted successfully!');

        return redirect()->back();
    }
    public function bulkDelete(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $listing = Listing::findOrFail($id);

            //delete all the contents of this listing
            $contents = $listing->listing_content()->get();

            foreach ($contents as $content) {
                $content->delete();
            }

            // delete feature_image image and video image of this listing
            if (!is_null($listing->feature_image)) {
                @unlink(public_path('assets/img/listing/') . $listing->feature_image);
            }
            if (!is_null($listing->video_background_image)) {
                @unlink(public_path('assets/img/listing/video/') . $listing->video_background_image);
            }

            //delete all the images of this listing
            $galleries = $listing->galleries()->get();

            foreach ($galleries as $gallery) {
                @unlink(public_path('assets/img/listing-gallery/') . $gallery->image);
                $gallery->delete();
            }
            //delete all Features for this listing
            $listingFeatures =  $listing->specifications()->get();
            foreach ($listingFeatures as $listingFeature) {
                $listingFeaturesContents = ListingFeatureContent::where('listing_feature_id', $listingFeature->id)->get();
                foreach ($listingFeaturesContents as $listingFeaturesContent) {
                    $listingFeaturesContent->delete();
                }
                $listingFeature->delete();
            }

            //delete feature order
            $featureOrders = FeatureOrder::where('listing_id', $id)->get();
            if (!is_null($featureOrders)) {

                foreach ($featureOrders as $order) {
                    if (!is_null($order->attachment)) {
                        @unlink(public_path('assets/file/attachments/feature-activation/') . $order->attachment);
                    }
                    $order->delete();
                }
            }
            //delete all message for this listing
            $listingMessages = ListingMessage::where('listing_id', $id)->get();
            if (!is_null($listingMessages)) {

                foreach ($listingMessages as $message) {
                    $message->delete();
                }
            }
            //delete all reviews for this listing
            $reviews = ListingReview::where('listing_id', $id)->get();
            if (!is_null($reviews)) {
                foreach ($reviews as $review) {
                    $review->delete();
                }
            }
            //delete all visit for this listing
            $visitors  = Visitor::where('listing_id', $id)->get();
            if (!is_null($visitors)) {
                foreach ($visitors as $visitor) {
                    $visitor->delete();
                }
            }
            //delete all faq for this listing
            $faqs = $listing->listingFaqs()->get();
            foreach ($faqs as $faq) {
                $faq->delete();
            }
            //delete all follow us  for this listing
            $sociallinks = $listing->sociallinks()->get();
            foreach ($sociallinks as $sociallink) {
                $sociallink->delete();
            }

            //delete all business hours for this listing
            BusinessHour::where('listing_id', $id)->delete();


            //delete all products
            $products = ListingProduct::where('listing_id', $id)->get();

            if (!is_null($products)) {

                foreach ($products as $product) {

                    $productcontents = $product->listing_product_content()->get();
                    //delete all product contents
                    foreach ($productcontents as $productcontent) {
                        $productcontent->delete();
                    }
                    //delete product feature image
                    if (!is_null($product->feature_image)) {
                        @unlink(public_path('assets/img/listing/product/') . $product->feature_image);
                    }

                    //delete all product slider images
                    $galleries = $product->galleries()->get();

                    foreach ($galleries as $gallery) {
                        @unlink(public_path('assets/img/listing/product-gallery/') . $gallery->image);
                        $gallery->delete();
                    }
                    //delete this product
                    //delete all message for this listing
                    $productMessages = ProductMessage::where('product_id', $product->id)->get();
                    if (!is_null($productMessages)) {
                        foreach ($productMessages as $message) {
                            $message->delete();
                        }
                    }
                    $product->delete();
                }
            }
            // finally, delete this listing
            $listing->delete();
        }

        Session::flash('success', 'Listing deleted successfully!');

        return response()->json(['status' => 'success'], 200);
    }

    public function featureDelete(Request $request)
    {
        $listing_feature = ListingFeature::find($request->spacificationId);
        $listing_feature_contents = ListingFeatureContent::where('listing_feature_id', $listing_feature->id)->get();
        foreach ($listing_feature_contents as $listing_feature_content) {
            $listing_feature_content->delete();
        }
        $listing_feature->delete();

        Session::flash('success', 'Feature deleted successfully!');

        return Response::json(['status' => 'success'], 200);
    }
    public function socialDelete(Request $request)
    {
        $listing_feature = ListingSocialMedia::find($request->socialID);

        $listing_feature->delete();

        Session::flash('success', 'Socail Link deleted successfully!');

        return Response::json(['status' => 'success'], 200);
    }
    public function aminitieUpdate(Request $request)
    {
        $Listing = ListingContent::Where([['listing_id', $request->listingId], ['language_id', $request->languageId]])->first();


        $aminities = $request->aminities;
        $aminitiesArray = explode(',', $aminities);
        $aminitiesArray = array_map('strval', $aminitiesArray);
        $Listing->aminities = $aminitiesArray;

        $Listing->save();

        Session::flash('success', 'Aminities updated successfully!');

        return Response::json(['status' => 'success'], 200);
    }

    public function plugins($id)
    {
        Listing::findorFail($id);
        $vendorId = Auth::guard('vendor')->user()->id;
        $current_package = VendorPermissionHelper::packagePermission($vendorId);

        if ($current_package != '[]') {

            $language = Language::where('is_default', 1)->first();

            $information['title'] = ListingContent::where([['language_id', $language->id], ['listing_id', $id]])
                ->select('title')
                ->first();

            $information['data'] = DB::table('listings')
                ->where('id', $id)
                ->select('whatsapp_status', 'whatsapp_number', 'whatsapp_header_title', 'whatsapp_popup_status', 'whatsapp_popup_message',  'tawkto_status', 'tawkto_direct_chat_link', 'telegram_status', 'telegram_username', 'messenger_status', 'messenger_direct_chat_link')
                ->first();
            $information['id'] = $id;

            return view('vendors.listing.plugins', $information);
        } else {

            Session::flash('warning', 'Please Buy a plan to manage plugins!');
            return redirect()->route('vendor.listing_management.listing');
        }
    }
    public function updateTawkTo(Request $request, $id)
    {
        $rules = [
            'tawkto_status' => 'required',
            'tawkto_direct_chat_link' => 'required'
        ];

        $messages = [
            'tawkto_status.required' => 'The tawk.to status field is required.',
            'tawkto_direct_chat_link.required' => 'The tawk.to direct chat link field is required.'
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors());
        }

        DB::table('listings')->where('id', $id)->update(
            [
                'tawkto_status' => $request->tawkto_status,
                'tawkto_direct_chat_link' => $request->tawkto_direct_chat_link
            ]
        );

        Session::flash('success', 'Tawk.To info updated successfully!');

        return redirect()->back();
    }
    public function updateTelegram(Request $request, $id)
    {
        $rules = [
            'telegram_status' => 'required',
            'telegram_username' => 'required'
        ];

        $messages = [
            'telegram_status.required' => 'The Telegram status field is required.',
            'telegram_username.required' => 'The Telegram Username field is required.'
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors());
        }

        DB::table('listings')->where('id', $id)->update(
            [
                'telegram_status' => $request->telegram_status,
                'telegram_username' => $request->telegram_username
            ]
        );

        Session::flash('success', 'Telegram info updated successfully!');

        return redirect()->back();
    }
    public function updateWhatsApp(Request $request, $id)
    {
        $rules = [
            'whatsapp_status' => 'required',
            'whatsapp_number' => 'required',
            'whatsapp_header_title' => 'required',
            'whatsapp_popup_status' => 'required',
            'whatsapp_popup_message' => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors());
        }

        DB::table('listings')->where('id', $id)->update(
            [
                'whatsapp_status' => $request->whatsapp_status,
                'whatsapp_number' => $request->whatsapp_number,
                'whatsapp_header_title' => $request->whatsapp_header_title,
                'whatsapp_popup_status' => $request->whatsapp_popup_status,
                'whatsapp_popup_message' => $request->whatsapp_popup_message
            ]
        );

        Session::flash('success', 'WhatsApp info updated successfully!');

        return redirect()->back();
    }
    public function updateMessanger(Request $request, $id)
    {
        $rules = [
            'messenger_status' => 'required',
            'messenger_direct_chat_link' => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors());
        }

        DB::table('listings')->where('id', $id)->update(
            [
                'messenger_status' => $request->messenger_status,
                'messenger_direct_chat_link' => $request->messenger_direct_chat_link
            ]
        );

        Session::flash('success', 'Messanger info updated successfully!');

        return redirect()->back();
    }
    public function businessHours($id)
    {
        Listing::findorFail($id);
        $vendor_id = Listing::where('id', $id)->pluck('vendor_id')->first();
        if ($vendor_id == Auth::guard('vendor')->user()->id) {
            $vendorId = Auth::guard('vendor')->user()->id;
            $current_package = VendorPermissionHelper::packagePermission($vendorId);

            if ($current_package != '[]') {

                $permissions = businessHoursPermission($id);

                if ($permissions) {
                    $information['id'] = $id;

                    $information['days'] = DB::table('business_hours')
                        ->Where('listing_id', $id)
                        ->get();

                    $language = Language::where('is_default', 1)->first();
                    $information['title'] = ListingContent::where([['language_id', $language->id], ['listing_id', $id]])
                        ->select('title')
                        ->first();

                    return view('vendors.listing.business-hours', $information);
                } else {

                    Session::flash('warning', "Your Business Hours Permission is not granted.");
                    return redirect()->route('vendor.listing_management.listing');
                }
            } else {

                Session::flash('warning', 'Please Buy a plan to manage business hours!');
                return redirect()->route('vendor.listing_management.listing');
            }
        } else {

            Session::flash('warning', 'You dont have any permission!');
            return redirect()->route('vendor.listing_management.listing');
        }
    }
    public function updateHoliday(Request $request)
    {
        $listing = BusinessHour::findOrFail($request->holidayId);

        if ($request->holiday == 1) {
            $listing->update(['holiday' => 1]);

            Session::flash('success', 'Holiday Updated successfully!');
        } else {
            $listing->update(['holiday' => 0]);

            Session::flash('success', 'Holiday Updated successfully!');
        }

        return Response::json(['status' => 'success'], 200);
    }
    public function updateBusinessHours(Request $request, $id)
    {
        $days = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
        foreach ($days as $day) {

            $businessHours =  BusinessHour::where('id', $request[$day . '_id'])->first();

            if (empty($businessHours)) {
                $businessHours = new BusinessHour();
            }
            $businessHours->start_time = $request[$day . '_start_time'];
            $businessHours->end_time = $request[$day . '_end_time'];

            $businessHours->save();
        }
        Session::flash('success', 'Business Hours Updated successfully!');
        return back();
    }
}
