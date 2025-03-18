<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Admin\AdminController;
use DB;
use Config;
use Session;
use Exception;
use App\Models\Aminite;
use App\Models\BasicSettings\Basic;
use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\BasicSettings\MailTemplate;
use App\Models\BusinessHour;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Mail;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingFaq;
use App\Models\Listing\ListingFeature;
use App\Models\Listing\ListingImage;
use Illuminate\Support\Facades\Validator;
use App\Models\Listing\ListingReview;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ListingProduct;
use Illuminate\Support\Facades\Auth;
use App\Models\Listing\ListingSocialMedia;
use App\Models\Listing\ProductMessage;
use App\Models\ListingCategory;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Models\VendorInfo;
use App\Models\Visitor;
use Illuminate\Support\Carbon;

class ListingContoller extends Controller
{
    public function getState(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        if ($request->id) {
            $data['states'] = State::where('country_id', $request->id)->get();
            $data['cities'] = City::where('country_id', $request->id)->get();
        } else {

            $data['states'] = State::where('language_id', $language->id)->get();
            $data['cities'] = City::where('language_id', $language->id)->get();
        }

        return $data;
    }
    public function getAddress(Request $request)
    {
        if ($request->country_id) {
            $country = Country::Where('id', $request->country_id)->first()
                ->name;
        }
        if ($request->state_id) {
            $state = State::Where('id', $request->state_id)->first()
                ->name;
        }
        if ($request->city_id) {
            $city = City::Where('id', $request->city_id)->first()
                ->name;
        }
        $address = '';
        if ($request->city_id) {
            if ($city) {
                $address .= $city;
            }
        }
        if ($request->state_id) {
            if ($state) {
                $address .= ($address ? ', ' : '') . $state;
            }
        }
        if ($request->country_id) {
            if ($country) {
                $address .= ($address ? ', ' : '') . $country;
            }
        }

        return $address;
    }

    public function getCity(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        if ($request->id) {
            $data = City::where('state_id', $request->id)->get();
        } else {
            $data = City::where('language_id', $language->id)->get();
        }
        return $data;
    }

    public function index(Request $request)
    {
        $view = Basic::query()->pluck('listing_view')->first();
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        $information['bgImg'] = $misc->getBreadcrumb();

        $information['pageHeading'] = $misc->getPageHeading($language);

        $information['language'] = $language;
        $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_listings', 'meta_description_listings')->first();

        $information['currencyInfo'] = $this->getCurrencyInfo();

        $title = $location = $category_id = $max_val = $min_val  = $ratings = $amenitie = $vendor = $country = $state = $city = null;

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

        if ($request->query('searchquery')) {
            $listingIds = [];
            $searchquery = $request->query('searchquery');
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $searchquery . '%')
                ->orWhere('slug', 'like', '%' . $searchquery . '%')
                ->orWhere('description', 'like', '%' . $searchquery . '%')
                ->orWhere('address', 'like', '%' . $searchquery . '%')
                ->orWhere('meta_description', 'like', '%' . $searchquery . '%')
                ->get()
                ->pluck('listing_id');

            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }



        // $cityIds = [];
        // if ($request->filled('city')) {
        //     $city = $request->city;
        //     $listing_contents = ListingContent::where('language_id', $language->id)
        //         ->where('city_id', $city)
        //         ->get()
        //         ->pluck('listing_id');
        //     foreach ($listing_contents as $listing_content) {
        //         if (!in_array($listing_content, $cityIds)) {
        //             array_push($cityIds, $listing_content);
        //         }
        //     }
        // }

        $cityIds = [];
        if ($request->query('city')) {
            $cityName = $request->query('city');
            $city = City::where('name', $cityName)->first();
            if (!$city) {
                return response()->json(['message' => 'City not found'], 404);
            }
            $listing_contents = ListingContent::where('city_id', $city->id)->pluck('listing_id');

            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $cityIds)) {
                    array_push($cityIds, $listing_content);
                }
            }
        }




        $locationIds = [];
        if ($request->filled('location')) {
            $location = $request->location;
            $contents = ListingContent::where('language_id', $language->id)
                ->where('address', 'like', '%' . $location . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($contents as $content) {
                if (!in_array($content, $locationIds)) {
                    array_push($locationIds, $content);
                }
            }
        }



        $category_listingIds = [];
        if ($request->filled('category_id')) {
            $category = $request->category_id;
            $category_content = ListingCategory::where([['language_id', $language->id], ['slug', $category]])->first();

            if (!empty($category_content)) {
                $category_id = $category_content->id;
                $contents = ListingContent::where('language_id', $language->id)
                    ->where('category_id', $category_id)
                    ->get()
                    ->pluck('listing_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_listingIds)) {
                        array_push($category_listingIds, $content);
                    }
                }
            }
        }

        $priceIds = [];
        if ($request->filled('min_val') && $request->filled('max_val')) {
            $min_val = intval($request->min_val);
            $max_val = intval($request->max_val);

            $price_products = DB::table('listings')
                ->select('*')
                ->where(function ($query) use ($min_val, $max_val) {
                    $query->where('min_price', '>=', $min_val)
                        ->where('max_price', '<=', $max_val);
                })
                ->orWhere(function ($query) use ($min_val, $max_val) {
                    $query->where('min_price', '<=', $min_val)
                        ->where('max_price', '>=', $max_val);
                })
                ->orWhereNot(function ($query) use ($min_val, $max_val) {
                    $query->where('max_price', '<', $min_val)
                        ->orWhere('min_price', '>', $max_val);
                })
                ->get()
                ->pluck('id');
            foreach ($price_products as $product) {
                if (!in_array($product, $priceIds)) {
                    array_push($priceIds, $product);
                }
            }
        }


        if ($request->filled('sort')) {
            if ($request['sort'] == 'new') {
                $order_by_column = 'listings.id';
                $order = 'desc';
            } elseif ($request['sort'] == 'old') {
                $order_by_column = 'listings.id';
                $order = 'asc';
            } elseif ($request['sort'] == 'high') {
                $order_by_column = 'listings.max_price';
                $order = 'desc';
            } elseif ($request['sort'] == 'low') {
                $order_by_column = 'listings.min_price';
                $order = 'asc';
            } else {
                $order_by_column = 'listings.id';
                $order = 'desc';
            }
        } else {
            $order_by_column = 'listings.id';
            $order = 'desc';
        }

        $featured_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->Join('feature_orders', 'listings.id', '=', 'feature_orders.listing_id')
            ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
            ->where('listing_contents.language_id', $language->id)
            ->where('feature_orders.order_status', '=', 'completed')
            ->where([
                ['listings.status', '=', '1'],
                ['listings.visibility', '=', '1']
            ])
            ->whereDate('feature_orders.end_date', '>=', Carbon::now()->format('Y-m-d'))
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })


            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('listings.id', $listingIds);
            })
            ->when($location, function ($query) use ($locationIds) {
                return $query->whereIn('listings.id', $locationIds);
            })
            ->when($category_id, function ($query) use ($category_listingIds) {
                return $query->whereIn('listings.id', $category_listingIds);
            })
            ->when($min_val && $max_val, function ($query) use ($priceIds) {
                return $query->whereIn('listings.id', $priceIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('listings.id', $cityIds);
            })
            ->select(
                'listings.*',
                'listing_contents.title',
                'listing_contents.slug',
                'listing_contents.category_id',
                'listing_contents.city_id',
                'listing_contents.state_id',
                'listing_contents.country_id',
                'listing_contents.description',
                'listing_contents.address',
                'listing_categories.name as category_name',
                'listing_categories.icon as icon',
                'feature_orders.listing_id as feature_order_listing_id'
            )
            ->inRandomOrder()
            ->limit(3)
            ->get();

        $totalFeatured_content = Count($featured_contents);

        $featured_contentsIds = [];
        if ($featured_contents) {

            foreach ($featured_contents as $content) {
                if (!in_array($content->id, $featured_contentsIds)) {
                    array_push($featured_contentsIds, $content->id);
                }
            }
        }

        $listing_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
            ->where('listing_contents.language_id', $language->id)
            ->where([
                ['listings.status', '=', '1'],
                ['listings.visibility', '=', '1']
            ])
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('listings.id', $listingIds);
            })
            ->when($location, function ($query) use ($locationIds) {
                return $query->whereIn('listings.id', $locationIds);
            })
            ->when($category_id, function ($query) use ($category_listingIds) {
                return $query->whereIn('listings.id', $category_listingIds);
            })
            ->when($min_val && $max_val, function ($query) use ($priceIds) {
                return $query->whereIn('listings.id', $priceIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('listings.id', $cityIds);
            })
            ->when($featured_contents, function ($query) use ($featured_contentsIds) {
                return $query->whereNotIn('listings.id', $featured_contentsIds);
            })
            ->select(
                'listings.*',
                'listing_contents.title',
                'listing_contents.slug',
                'listing_contents.category_id',
                'listing_contents.city_id',
                'listing_contents.state_id',
                'listing_contents.country_id',
                'listing_contents.description',
                'listing_contents.address',
                'listing_categories.name as category_name',
                'listing_categories.icon as icon',
            )
            ->orderBy($order_by_column, $order)
            ->get();


        if ($totalFeatured_content == 3) {
            $perPage = 9;
        } elseif ($totalFeatured_content == 2) {
            $perPage = 10;
        } elseif ($totalFeatured_content == 1) {
            $perPage = 11;
        } else {
            $perPage = 12;
        }
        $page = 1;

        $offset = ($page - 1) * $perPage;

        $currentPageData = $listing_contents->slice($offset, $perPage);

        $information['categories'] = ListingCategory::where('language_id', $language->id)->where('status', 1)
            ->orderBy('serial_number', 'asc')->get();

        $information['vendors'] = Vendor::join('memberships', 'vendors.id', '=', 'memberships.vendor_id')
            ->where([
                ['memberships.status', '=', 1],
                ['memberships.start_date', '<=', Carbon::now()->format('Y-m-d')],
                ['memberships.expire_date', '>=', Carbon::now()->format('Y-m-d')]
            ])
            ->get();


        $information['aminites'] = Aminite::where('language_id', $language->id)
            ->orderBy('updated_at', 'asc')->get();

        $information['countries'] = Country::where('language_id', $language->id)
            ->orderBy('id', 'asc')->get();

        $information['states'] = State::where('language_id', $language->id)
            ->orderBy('id', 'asc')->get();

        $information['cities'] = City::where('language_id', $language->id)
            ->orderBy('id', 'asc')->get();

        $information['listing_contents'] = $listing_contents;
        $information['featured_contents'] = $featured_contents;
        $information['currentPageData'] = $currentPageData;
        $information['perPage'] = $perPage;


        $information['min'] = Listing::where([
            ['listings.status', '=', '1'],
            ['listings.visibility', '=', '1']
        ])
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->min('listings.min_price');
        $information['max'] = Listing::where([
            ['listings.status', '=', '1'],
            ['listings.visibility', '=', '1']
        ])
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })->max('max_price');

        if ($view == 0) {
            return view('frontend.listing.listing-map', $information);
        } else {
            return view('frontend.listing.listing-gird', $information);
        }
    }



    // public function index(Request $request)
    // {
    //     $cityIds = [];
    //     if ($request->query('city')) {


    //         $cityName = $request->query('city');

    //         $city = City::where('name', $cityName)->first();

    //         if (!$city) {
    //             return response()->json(['message' => 'City not found'], 404);
    //         }


    //         $listing_contents = ListingContent::where('city_id', $city->id)->pluck('listing_id');

    //         foreach ($listing_contents as $listing_content) {
    //             if (!in_array($listing_content, $cityIds)) {
    //                 array_push($cityIds, $listing_content);
    //             }
    //         }
    //     }
    // }




    public function search_listing(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        $information['language'] = $language;
        $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_listings', 'meta_description_listings')->first();

        $information['currencyInfo'] = $this->getCurrencyInfo();
        $title = $location = $category_id = $max_val = $min_val  = $ratings = $amenitie = $vendor = $country = $state = $city = null;

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
        $countryIds = [];
        if ($request->filled('country')) {
            $country = $request->country;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('country_id', $country)
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $countryIds)) {
                    array_push($countryIds, $listing_content);
                }
            }
        }
        $stateIds = [];
        if ($request->filled('state')) {
            $state = $request->state;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('state_id', $state)
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $stateIds)) {
                    array_push($stateIds, $listing_content);
                }
            }
        }

        $cityIds = [];
        if ($request->filled('city')) {
            $city = $request->city;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('city_id', $city)
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $cityIds)) {
                    array_push($cityIds, $listing_content);
                }
            }
        }

        $vendorIds = [];
        if ($request->filled('vendor')) {
            $vendor = $vendor == 'admin' ? 0 : $request->vendor;
            $listing_contents = Listing::where('vendor_id', $vendor)
                ->get()
                ->pluck('id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $vendorIds)) {
                    array_push($vendorIds, $listing_content);
                }
            }
        }

        $locationIds = [];
        if ($request->filled('location')) {
            $location = $request->location;
            $contents = ListingContent::where('language_id', $language->id)
                ->where('address', 'like', '%' . $location . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($contents as $content) {
                if (!in_array($content, $locationIds)) {
                    array_push($locationIds, $content);
                }
            }
        }

        $category_listingIds = [];
        if ($request->filled('category_id')) {
            $category = $request->category_id;
            $category_content = ListingCategory::where([['language_id', $language->id], ['slug', $category]])->first();

            if (!empty($category_content)) {
                $category_id = $category_content->id;
                $contents = ListingContent::where('language_id', $language->id)
                    ->where('category_id', $category_id)
                    ->get()
                    ->pluck('listing_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_listingIds)) {
                        array_push($category_listingIds, $content);
                    }
                }
            }
        }

        $priceIds = [];
        if ($request->filled('min_val') && $request->filled('max_val')) {
            $min_val = intval($request->min_val);
            $max_val = intval($request->max_val);

            $price_products = DB::table('listings')
                ->select('*')
                ->where(function ($query) use ($min_val, $max_val) {
                    $query->where('min_price', '>=', $min_val)
                        ->where('max_price', '<=', $max_val);
                })
                ->orWhere(function ($query) use ($min_val, $max_val) {
                    $query->where('min_price', '<=', $min_val)
                        ->where('max_price', '>=', $max_val);
                })
                ->orWhereNot(function ($query) use ($min_val, $max_val) {
                    $query->where('max_price', '<', $min_val)
                        ->orWhere('min_price', '>', $max_val);
                })
                ->get()
                ->pluck('id');
            foreach ($price_products as $product) {
                if (!in_array($product, $priceIds)) {
                    array_push($priceIds, $product);
                }
            }
        }


        $ratingIds = [];
        if ($request->filled('ratings')) {
            $ratings = $request->ratings;
            $contents = Listing::where('average_rating', '>=', $ratings)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $ratingIds)) {
                    array_push($ratingIds, $content);
                }
            }
        }

        $amenitieIds = [];
        if ($request->filled('amenitie')) {
            $amenitie = $request->amenitie;
            $array = explode(',', $amenitie);

            $contents = ListingContent::where('language_id', $language->id)
                ->get(['listing_id', 'aminities']);

            foreach ($contents as $content) {
                $aminities = (json_decode($content->aminities));
                $listingId = $content->listing_id;
                $diff1 = array_diff($array, $aminities);
                $diff2 = array_diff($array, $aminities);

                if (empty($diff1) && empty($diff2)) {

                    array_push($amenitieIds, $listingId);
                }
            }
        }

        if ($request->filled('sort')) {
            if ($request['sort'] == 'new') {
                $order_by_column = 'listings.id';
                $order = 'desc';
            } elseif ($request['sort'] == 'old') {
                $order_by_column = 'listings.id';
                $order = 'asc';
            } elseif ($request['sort'] == 'high') {
                $order_by_column = 'listings.max_price';
                $order = 'desc';
            } elseif ($request['sort'] == 'low') {
                $order_by_column = 'listings.min_price';
                $order = 'asc';
            } else {
                $order_by_column = 'listings.id';
                $order = 'desc';
            }
        } else {
            $order_by_column = 'listings.id';
            $order = 'desc';
        }

        $featured_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->Join('feature_orders', 'listings.id', '=', 'feature_orders.listing_id')
            ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
            ->where('listing_contents.language_id', $language->id)
            ->where('feature_orders.order_status', '=', 'completed')
            ->where([
                ['listings.status', '=', '1'],
                ['listings.visibility', '=', '1']
            ])
            ->whereDate('feature_orders.end_date', '>=', Carbon::now()->format('Y-m-d'))
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })


            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('listings.id', $listingIds);
            })
            ->when($vendor, function ($query) use ($vendorIds) {
                return $query->whereIn('listings.id', $vendorIds);
            })
            ->when($location, function ($query) use ($locationIds) {
                return $query->whereIn('listings.id', $locationIds);
            })
            ->when($category_id, function ($query) use ($category_listingIds) {
                return $query->whereIn('listings.id', $category_listingIds);
            })
            ->when($min_val && $max_val, function ($query) use ($priceIds) {
                return $query->whereIn('listings.id', $priceIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('listings.id', $ratingIds);
            })
            ->when($amenitie, function ($query) use ($amenitieIds) {
                return $query->whereIn('listings.id', $amenitieIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('listings.id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('listings.id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('listings.id', $cityIds);
            })
            ->select(
                'listings.*',
                'listing_contents.title',
                'listing_contents.slug',
                'listing_contents.category_id',
                'listing_contents.city_id',
                'listing_contents.state_id',
                'listing_contents.country_id',
                'listing_contents.description',
                'listing_contents.address',
                'listing_categories.name as category_name',
                'listing_categories.icon as icon',
                'feature_orders.listing_id as feature_order_listing_id'
            )
            ->inRandomOrder()
            ->limit(3)
            ->get();

        $totalFeatured_content = Count($featured_contents);

        $featured_contentsIds = [];
        if ($featured_contents) {

            foreach ($featured_contents as $content) {
                if (!in_array($content->id, $featured_contentsIds)) {
                    array_push($featured_contentsIds, $content->id);
                }
            }
        }

        $listing_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
            ->where('listing_contents.language_id', $language->id)
            ->where([
                ['listings.status', '=', '1'],
                ['listings.visibility', '=', '1']
            ])
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('listings.id', $listingIds);
            })
            ->when($vendor, function ($query) use ($vendorIds) {
                return $query->whereIn('listings.id', $vendorIds);
            })
            ->when($location, function ($query) use ($locationIds) {
                return $query->whereIn('listings.id', $locationIds);
            })
            ->when($category_id, function ($query) use ($category_listingIds) {
                return $query->whereIn('listings.id', $category_listingIds);
            })
            ->when($min_val && $max_val, function ($query) use ($priceIds) {
                return $query->whereIn('listings.id', $priceIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('listings.id', $ratingIds);
            })
            ->when($amenitie, function ($query) use ($amenitieIds) {
                return $query->whereIn('listings.id', $amenitieIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('listings.id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('listings.id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('listings.id', $cityIds);
            })
            ->when($featured_contents, function ($query) use ($featured_contentsIds) {
                return $query->whereNotIn('listings.id', $featured_contentsIds);
            })
            ->select(
                'listings.*',
                'listing_contents.title',
                'listing_contents.slug',
                'listing_contents.category_id',
                'listing_contents.city_id',
                'listing_contents.state_id',
                'listing_contents.country_id',
                'listing_contents.description',
                'listing_contents.address',
                'listing_categories.name as category_name',
                'listing_categories.icon as icon',
            )
            ->orderBy($order_by_column, $order)
            ->get();

        if ($totalFeatured_content == 3) {
            $perPage = 9;
        } elseif ($totalFeatured_content == 2) {
            $perPage = 10;
        } elseif ($totalFeatured_content == 1) {
            $perPage = 11;
        } else {
            $perPage = 12;
        }

        $page = $request->query('page');

        $offset = ($page - 1) * $perPage;

        // Get the subset of data for the current page
        $currentPageData = $listing_contents->slice($offset, $perPage);


        $information['listing_contents'] = $listing_contents;
        $information['featured_contents'] = $featured_contents;
        $information['currentPageData'] = $currentPageData;
        $information['perPage'] = $perPage;

        return view('frontend.listing.search-listing', $information)->render();
    }


    // public function search_listing(Request $request)
    // {

    //     echo " im here";
    // }

    public function details($slug, $id)
    {
        $misc = new MiscellaneousController();

        $vendorId = Listing::where('id', $id)->pluck('vendor_id')->first();

        $language = $misc->getLanguage();

        $listing = Listing::with(['listing_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        },])
            ->when($vendorId && $vendorId != 0, function ($query) {
                $query->join('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
                    ->where([
                        ['memberships.status', '=', 1],
                        ['memberships.start_date', '<=', now()->format('Y-m-d')],
                        ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                    ]);
            })
            ->where([
                ['listings.status', '=', '1'],
                ['listings.visibility', '=', '1']
            ])

            ->select('listings.*')
            ->where('listings.id', $id)
            ->firstOrFail();

        $vendor_id = $listing->vendor_id;

        $information['bgImg'] = $misc->getBreadcrumb();
        $information['listing'] = $listing;
        $information['listingImages'] = ListingImage::Where('listing_id', $id)->get();

        $listing_content = ListingContent::where('language_id', $language->id)->where('listing_id', $id)->first();
        $information['socialLinks'] = ListingSocialMedia::where('listing_id', $id)->get();

        if (is_null($listing_content)) {
            Session::flash('error', 'No Listing information found for ' . $language->name . ' language');
            return redirect()->route('index');
        }
        $information['language'] = $language;

        $listing_features = ListingFeature::join('listing_feature_contents', 'listing_features.id', '=', 'listing_feature_contents.listing_feature_id')
            ->where('listing_id', $id)
            ->where('listing_feature_contents.language_id', $language->id)->get();

        $information['listing_features'] = $listing_features;
        if ($vendorId == 0) {
            $information['vendor'] = Admin::first();
            $information['userName'] = 'admin';
        } else {
            $information['vendor'] = Vendor::Where('id', $vendor_id)->first();
            $information['userName'] = $information['vendor']->username;
            $information['vendorInfo'] = VendorInfo::Where('vendor_id', $vendor_id)
                ->where('language_id', $language->id)
                ->first();
        }


        $reviews = ListingReview::query()->where('listing_id', '=', $id)->orderByDesc('id')->get();

        $reviews->map(function ($review) {
            $review['user'] = $review->userInfo()->first();
        });

        $information['reviews'] = $reviews;
        $numOfReview = count($reviews);
        $information['numOfReview'] = $numOfReview;

        $information['info'] = Basic::select('google_recaptcha_status')->first();

        $product_contents = ListingProduct::with('galleries')
            ->join('listing_product_contents', 'listing_products.id', 'listing_product_contents.listing_product_id')
            ->where('listing_product_contents.language_id', $language->id)
            ->where('listing_products.listing_id', $id)
            ->where('listing_products.status', 1)
            ->select('listing_products.*', 'listing_product_contents.title',   'listing_product_contents.slug', 'listing_product_contents.content')
            ->paginate(9);
        $information['product_contents'] = $product_contents;

        $businessHours = BusinessHour::query()->where('listing_id', '=', $id)->orderBy('id')->get();
        $information['businessHours'] = $businessHours;

        $faqs = ListingFaq::where('listing_id', $id)
            ->where('language_id', $language->id)
            ->orderBy('serial_number', 'asc')
            ->get();
        $information['faqs'] = $faqs;

        return view('frontend.listing.listing-details', $information);
    }
    public function contact(Request $request)
    {
        $rule = [
            'name' => 'required',
            'email' => 'required|email',
            'phone' => 'required',
            'message' => 'required',
        ];

        $validator = Validator::make($request->all(), $rule);

        if ($validator->fails()) {
            return redirect()->back()
                ->with('error', 'Field is missing')
                ->withInput();
        }

        $in = $request->all();
        $listing = ListingMessage::create($in);

        $mail_template = MailTemplate::where('mail_type', 'inquiry_about_listing')->first();



        $info = Basic::select('google_recaptcha_status')->first();
        if ($info->google_recaptcha_status == 1) {
            $rules['g-recaptcha-response'] = 'required|captcha';
        }

        $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();

        $misc = new MiscellaneousController();

        $language = $misc->getLanguage();

        $listing = Listing::with(['listing_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        }])->where('id', $request->listing_id)->first();

        $listing_name = $listing->listing_content[0]->title;
        $slug = $listing->listing_content[0]->slug;
        $url = route('frontend.listing.details', ['slug' => $slug, 'id' => $listing->id]);


        if ($listing->vendor_id != 0) {
            $vendor = Vendor::where('id', $listing->vendor_id)->select('to_mail', 'username', 'email')->first();

            if (isset($vendor->to_mail)) {
                $send_email_address = $vendor->to_mail;
            } else {
                $send_email_address = $vendor->email;
            }
            $user_name = $vendor->username;
        } else {
            $send_email_address = $be->to_mail;
            $user_name = 'Admin';
        }

        if ($be->smtp_status == 1) {
            $subject = 'Inquiry about ' . $listing_name;

            $body = $mail_template->mail_body;
            $body = preg_replace("/{username}/", $user_name, $body);
            $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
            $body = preg_replace("/{enquirer_name}/", $request->name, $body);
            $body = preg_replace("/{enquirer_email}/", $request->email, $body);
            $body = preg_replace("/{enquirer_phone}/", $request->phone, $body);
            $body = preg_replace("/{enquirer_message}/", nl2br($request->message), $body);
            $body = preg_replace("/{website_title}/", $be->website_title, $body);

            // if smtp status == 1, then set some value for PHPMailer
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
                    'to' => $send_email_address,
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
                Session::flash('error', 'Something went wrong.');
                return back();
            }
        }
    }
    public function productContact(Request $request)
    {
        $mail_template = MailTemplate::where('mail_type', 'inquiry_about_product')->first();

        $rule = [
            'name' => 'required',
            'email' => 'required|email',
            'message' => 'required',
        ];

        $validator = Validator::make($request->all(), $rule);

        if ($validator->fails()) {
            return redirect()->back()
                ->with('error', 'Field is missing')
                ->withInput();
        }

        $info = Basic::select('google_recaptcha_status')->first();
        if ($info->google_recaptcha_status == 1) {
            $rules['g-recaptcha-response'] = 'required|captcha';
        }

        $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();

        $misc = new MiscellaneousController();

        $language = $misc->getLanguage();

        $product = ListingProduct::with(['listing_product_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        }])->where('id', $request->product_id)->first();

        $listing = Listing::with(['listing_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        }])->where('id', $product->listing_id)->first();

        $listing_name = $listing->listing_content[0]->title;
        $slug = $listing->listing_content[0]->slug;
        $url = route('frontend.listing.details', ['slug' => $slug, 'id' => $listing->id]);

        $product_name = $product->listing_product_content->title;

        $in = $request->all();
        $message = ProductMessage::create($in);

        if ($message->vendor_id != 0) {
            $vendor = Vendor::where('id', $message->vendor_id)->select('to_mail', 'username', 'email')->first();

            if (isset($vendor->to_mail)) {
                $send_email_address = $vendor->to_mail;
            } else {
                $send_email_address = $vendor->email;
            }
            $user_name = $vendor->username;
        } else {
            $send_email_address = $be->to_mail;
            $user_name = 'Admin';
        }


        if ($be->smtp_status == 1) {
            $subject = 'Inquiry about ' . $product_name;

            $body = $mail_template->mail_body;
            $body = preg_replace("/{username}/", $user_name, $body);
            $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
            $body = preg_replace("/{product_name}/", $product_name, $body);
            $body = preg_replace("/{enquirer_name}/", $request->name, $body);
            $body = preg_replace("/{enquirer_email}/", $request->email, $body);
            $body = preg_replace("/{enquirer_message}/", nl2br($request->message), $body);
            $body = preg_replace("/{website_title}/", $be->website_title, $body);

            // if smtp status == 1, then set some value for PHPMailer
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
                    'to' => $send_email_address,
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
                Session::flash('error', 'Something went wrong.');
                return back();
            }
        }
    }
    public function storeReview(Request $request, $id)
    {

        $rule = ['rating' => 'required'];
        $validator = Validator::make($request->all(), $rule);

        if ($validator->fails()) {
            return redirect()->back()
                ->with('error', 'The rating field is required for product review.')
                ->withInput();
        }

        $user = Auth::guard('web')->user();

        if ($user) {
            ListingReview::updateOrCreate(
                ['user_id' => $user->id, 'listing_id' => $id],
                ['review' => $request->review, 'rating' => $request->rating]
            );

            // now, get the average rating of this product
            $reviews = ListingReview::where('listing_id', $id)->get();

            $totalRating = 0;

            foreach ($reviews as $review) {
                $totalRating += $review->rating;
            }

            $numOfReview = count($reviews);

            $averageRating = $totalRating / $numOfReview;

            // finally, store the average rating of this Listing
            Listing::find($id)->update(['average_rating' => $averageRating]);

            Session::flash('success', 'Your review submitted successfully.');
        } else {
            Session::flash('error', 'You have to Login First!');
        }
        return redirect()->back();
    }
    public function store_visitor(Request $request)
    {
        $request->validate([
            'listing_id'
        ]);
        $ipAddress = \Request::ip();
        $check = Visitor::where([['listing_id', $request->listing_id], ['ip_address', $ipAddress], ['date', Carbon::now()->format('y-m-d')]])->first();
        $listing = Listing::where('id', $request->listing_id)->first();
        if ($listing) {
            if (!$check) {
                $visitor = new Visitor();
                $visitor->listing_id = $request->listing_id;
                $visitor->ip_address = $ipAddress;
                $visitor->vendor_id = $listing->vendor_id;
                $visitor->date = Carbon::now()->format('y-m-d');
                $visitor->save();
            }
        }
    }
}
