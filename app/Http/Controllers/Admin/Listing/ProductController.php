<?php

namespace App\Http\Controllers\Admin\Listing;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use App\Http\Requests\Listing\ProductStoreRequest;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use Mews\Purifier\Facades\Purifier;
use App\Models\Listing\ListingProductImage;
use App\Models\Listing\ListingProduct;
use App\Models\Listing\ListingProductContent;
use App\Models\Listing\ProductMessage;

class ProductController extends Controller
{
    public function index(Request $request, $id)
    {
        $information['langs'] = Language::all();
        Listing::findorFail($id);
        $permissions = productPermission($id);

        if ($permissions) {
            $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
            $information['language'] = $language;

            $language_id = $language->id;

            $d = ListingContent::where([['language_id', $language_id], ['listing_id', $id]])
                ->select('title')
                ->first();
            $title = ListingContent::where([['language_id', $language_id], ['listing_id', $id]])
            ->select('title', 'slug', 'listing_id')
                ->first();

            $information['title'] = $title;

            $information['dd'] = $d;

            $information['listing_id'] = $id;
            $information['listing_products'] = ListingProduct::with([
                'listing_product_content' => function ($q) use ($id) {
                    $q->where('listing_id', $id);
                },
            ])
                ->where('listing_id', $id)
                ->orderBy('id', 'desc')
                ->paginate(10);

            return view('admin.listing.product.index', $information);
        } else {

            Session::flash('warning', "This Vendor Product Permission is not granted.");
            return redirect()->route('admin.listing_management.listing');
        }
    }
    public function create($id)
    {
        $permissions = productPermission($id);

        if ($permissions) {

            $information['listing_id'] = $id;
            $information['currencyInfo'] = $this->getCurrencyInfo();
            $languages = Language::all();

            $languages->map(function ($language) {
                $language['categories'] = $language->productCategory()->where('status', 1)->orderByDesc('id')->get();
            });

            $information['languages'] = $languages;

            return view('admin.listing.product.create', $information);
        } else {

            Session::flash('warning', "This Vendor Product Permission is not granted.");
            return redirect()->route('admin.listing_management.listing');
        }
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

        $directory = public_path('assets/img/listing/product-gallery/');
        @mkdir($directory, 0775, true);
        $img->move($directory, $filename);

        $pi = new ListingProductImage();

        $pi->image = $filename;
        $pi->save();
        return response()->json(['status' => 'success', 'file_id' => $pi->id]);
    }
    public function imagermv(Request $request)
    {
        $pi = ListingProductImage::findOrFail($request->fileid);
        $image_count = ListingProductImage::where('listing_product_id', $pi->listing_product_id)->get()->count();
        if ($image_count > 1) {
            @unlink(public_path('assets/img/listing/product-gallery/') . $pi->image);
            $pi->delete();
            return $pi->id;
        } else {
            return 'false';
        }
    }
    public function imagedbrmv(Request $request)
    {
        $pi = ListingProductImage::findOrFail($request->fileid);
        $image_count = ListingProductImage::where('listing_product_id', $pi->listing_product_id)->get()->count();
        if ($image_count > 1) {
            @unlink(public_path('assets/img/listing/product-gallery/') . $pi->image);
            $pi->delete();

            Session::flash('success', 'Slider image deleted successfully!');
            return Response::json(['status' => 'success'], 200);
        } else {
            Session::flash('warning', 'You can\'t delete all images.!!');
            return Response::json(['status' => 'success'], 200);
        }
    }
    public function updateStatus(Request $request)
    {
        $listing = ListingProduct::findOrFail($request->productId);

        if ($request->status == 1) {
            $listing->update(['status' => 1]);

            Session::flash('success', 'Product Active successfully!');
        } else {
            $listing->update(['status' => 0]);

            Session::flash('success', 'Product Deactive successfully!');
        }

        return redirect()->back();
    }

    public function store(ProductStoreRequest $request)
    {
        if ($request->vendor_id != 0) {
            $totalproduct = ListingProduct::where('listing_id', $request->listing_id)
                ->count();

            if ($totalproduct < packageTotalProducts($request->listing_id)) {

                DB::transaction(function () use ($request) {

                    $featuredImgURL = $request->feature_image;

                    $languages = Language::all();

                    $in = $request->all();
                    $featuredImgExt = $featuredImgURL->getClientOriginalExtension();

                    // set a name for the featured image and store it to local storage
                    $featuredImgName = time() . '.' . $featuredImgExt;
                    $featuredDir = public_path('assets/img/listing/product/');

                    if (!file_exists($featuredDir)) {
                        @mkdir($featuredDir, 0777, true);
                    }
                    copy($featuredImgURL, $featuredDir . $featuredImgName);

                    $in['feature_image'] = $featuredImgName;

                    $listingProduct = ListingProduct::create($in);

                    $siders = $request->slider_images;
                    if ($siders) {
                        $pis = ListingProductImage::findOrFail($siders);

                        foreach ($pis as $key => $pi) {
                            $pi->listing_product_id = $listingProduct->id;
                            $pi->listing_id = $request->listing_id;
                            $pi->save();
                        }
                    }

                    foreach ($languages as $language) {
                        $listingProductContent = new ListingProductContent();

                        $listingProductContent->language_id = $language->id;
                        $listingProductContent->listing_id = $request->listing_id;
                        $listingProductContent->listing_product_id = $listingProduct->id;
                        $listingProductContent->title = $request[$language->code . '_title'];
                        $listingProductContent->slug = createSlug($request[$language->code . '_title']);
                        $listingProductContent->content = Purifier::clean($request[$language->code . '_content'], 'youtube');
                        $listingProductContent->meta_keyword = $request[$language->code . '_meta_keyword'];
                        $listingProductContent->meta_description = $request[$language->code . '_meta_description'];

                        $listingProductContent->save();
                    }
                });
                Session::flash('success', 'New Product added successfully!');

                return Response::json(['status' => 'success'], 200);
            } else {

                Session::flash('warning', "Products limit reached or exceeded");
                return Response::json(['status' => 'success'], 200);
            }
        } else {
            DB::transaction(function () use ($request) {

                $featuredImgURL = $request->feature_image;

                $languages = Language::all();

                $in = $request->all();
                $featuredImgExt = $featuredImgURL->getClientOriginalExtension();

                // set a name for the featured image and store it to local storage
                $featuredImgName = time() . '.' . $featuredImgExt;
                $featuredDir = public_path('assets/img/listing/product/');

                if (!file_exists($featuredDir)) {
                    @mkdir($featuredDir, 0777, true);
                }

                copy($featuredImgURL, $featuredDir . $featuredImgName);


                $in['feature_image'] = $featuredImgName;

                $listingProduct = ListingProduct::create($in);

                $siders = $request->slider_images;
                if ($siders) {
                    $pis = ListingProductImage::findOrFail($siders);

                    foreach ($pis as $key => $pi) {
                        $pi->listing_product_id = $listingProduct->id;
                        $pi->listing_id = $request->listing_id;
                        $pi->save();
                    }
                }

                foreach ($languages as $language) {
                    $listingProductContent = new ListingProductContent();

                    $listingProductContent->language_id = $language->id;
                    $listingProductContent->listing_id = $request->listing_id;
                    $listingProductContent->listing_product_id = $listingProduct->id;
                    $listingProductContent->title = $request[$language->code . '_title'];
                    $listingProductContent->slug = createSlug($request[$language->code . '_title']);
                    $listingProductContent->content = Purifier::clean($request[$language->code . '_content'], 'youtube');
                    $listingProductContent->meta_keyword = $request[$language->code . '_meta_keyword'];
                    $listingProductContent->meta_description = $request[$language->code . '_meta_description'];

                    $listingProductContent->save();
                }
            });
            Session::flash('success', 'New Product added successfully!');

            return Response::json(['status' => 'success'], 200);
        }
    }
    public function edit($id)
    {
        $Listin_id = ListingProduct::findOrFail($id)->listing_id;
        $permissions = productPermission($Listin_id);

        if ($permissions) {

            $listing = ListingProduct::with('galleries')->findOrFail($id);
            $information['product'] = $listing;
            $information['product_id'] = $id;

            // get all the languages from db
            $information['languages'] = Language::all();

            $information['vendors'] = Vendor::get();
            $information['currencyInfo'] = $this->getCurrencyInfo();


            return view('admin.listing.product.edit', $information);
        } else {

            Session::flash('warning', "This vendor Product Permission is not granted.");
            return redirect()->route('admin.listing_management.listing');
        }
    }

    public function update(Request $request, $id)
    {

        $rules = [
            'status' => 'required',
            'current_price' => 'required',
        ];

        $featuredImgURL = $request->thumbnail;

        $languages = Language::all();


        foreach ($languages as $language) {
            $rules[$language->code . '_title'] = 'required|max:255';
            $rules[$language->code . '_content'] = 'required|min:15';

            $messages[$language->code . '_title.required'] = 'The title field is required for ' . $language->name . ' language';
            $messages[$language->code . '_title.max'] = 'The title field cannot contain more than 255 characters for ' . $language->name . ' language';
            $messages[$language->code . '_content.required'] = 'The content field is required for ' . $language->name . ' language';
            $messages[$language->code . '_content.min'] = 'The content field at least have 15 characters for ' . $language->name . ' language';
        }



        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()->toArray()
            ], 400);
        }

        $in = $request->all();
        $listing = ListingProduct::findOrFail($request->product_id);
        if ($request->hasFile('thumbnail')) {
            $featuredImgExt = $featuredImgURL->getClientOriginalExtension();

            // set a name for the featured image and store it to local storage
            $featuredImgName = time() . '.' . $featuredImgExt;
            $featuredDir = public_path('assets/img/listing/product/');

            if (!file_exists($featuredDir)) {
                mkdir($featuredDir, 0777, true);
            }
            copy($featuredImgURL, $featuredDir . $featuredImgName);
            @unlink(public_path('assets/img/listing/product/') . $listing->feature_image);

            $in['feature_image'] = $featuredImgName;
        }



        $listing = $listing->update($in);

        $siders = $request->slider_images;
        if ($siders) {
            $pis = ListingProductImage::findOrFail($siders);

            foreach ($pis as $key => $pi) {
                $pi->listing_product_id = $request->product_id;
                $pi->listing_id = $request->listing_id;
                $pi->save();
            }
        }

        foreach ($languages as $language) {

            $listingProductContent =  ListingProductContent::where('listing_product_id', $request->product_id)->where('language_id', $language->id)->first();
            if (empty($listingProductContent)) {
                $listingProductContent = new ListingProductContent();
            }

            $listingProductContent->language_id = $language->id;

            $listingProductContent->listing_id = $request->listing_id;

            // $listingProductContent->listing_product_id = $listingProduct->id;

            $listingProductContent->title = $request[$language->code . '_title'];

            $listingProductContent->slug = createSlug($request[$language->code . '_title']);

            $listingProductContent->content = Purifier::clean($request[$language->code . '_content'], 'youtube');

            $listingProductContent->meta_keyword = $request[$language->code . '_meta_keyword'];
            $listingProductContent->meta_description = $request[$language->code . '_meta_description'];

            $listingProductContent->save();
        }

        Session::flash('success', 'Product Updated successfully!');

        return Response::json(['status' => 'success'], 200);
    }



    public function delete($id)
    {
        $product = ListingProduct::findOrFail($id);

        // first, delete all the contents of this package
        $contents = $product->listing_product_content()->get();

        foreach ($contents as $content) {
            $content->delete();
        }
        if (!is_null($product->feature_image)) {
            @unlink(public_path('assets/img/listing/product/') . $product->feature_image);
        }

        // first, delete all the contents of this package
        $galleries = $product->galleries()->get();

        foreach ($galleries as $gallery) {
            @unlink(public_path('assets/img/listing/product-gallery/') . $gallery->image);
            $gallery->delete();
        }

        $productMessages = ProductMessage::where('product_id', $id)->get();
        if (!is_null($productMessages)) {
            foreach ($productMessages as $message) {
                $message->delete();
            }
        }
        
        // finally, delete this package
        $product->delete();

        Session::flash('success', 'Product deleted successfully!');

        return redirect()->back();
    }
    public function bulkDelete(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {


            $product = ListingProduct::findOrFail($id);

            // first, delete all the contents of this package
            $contents = $product->listing_product_content()->get();

            foreach ($contents as $content) {
                $content->delete();
            }
            if (!is_null($product->feature_image)) {
                @unlink(public_path('assets/img/listing/product/') . $product->feature_image);
            }

            // first, delete all the contents of this package
            $galleries = $product->galleries()->get();

            foreach ($galleries as $gallery) {
                @unlink(public_path('assets/img/listing/product-gallery/') . $gallery->image);
                $gallery->delete();
            }

            $productMessages = ProductMessage::where('product_id', $id)->get();
            if (!is_null($productMessages)) {
                foreach ($productMessages as $message) {
                    $message->delete();
                }
            }
            // finally, delete this package
            $product->delete();
        }

        Session::flash('success', 'Listing deleted successfully!');

        return response()->json(['status' => 'success'], 200);
    }
}
