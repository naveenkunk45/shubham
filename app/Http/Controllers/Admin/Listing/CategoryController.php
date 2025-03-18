<?php

namespace App\Http\Controllers\Admin\Listing;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Language;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Models\ListingCategory;

class CategoryController extends Controller
{
    public function index(Request $request)
    {
        // first, get the language info from db
        $language = Language::where('code', $request->language)->firstOrFail();
        $information['language'] = $language;


        // then, get the equipment categories of that language from db
        $information['categories'] = $language->listingCategory()->orderByDesc('id')->get();

        $information['langs'] = Language::all();

        return view('admin.listing.category.index', $information);
    }

    public function store(Request $request)
    {
        $rules = [
            'icon' => 'required',
            'language_id' => 'required',
            'name' => [
                'required',
                Rule::unique('listing_categories')->where(function ($query) use ($request) {
                    return $query->where('language_id', $request->input('language_id'));
                }),
                'max:255',
            ],
            'status' => 'required|numeric',
            'serial_number' => 'required|numeric'
        ];

        $message = [
            'language_id.required' => 'The language field is required.'
        ];

        $validator = Validator::make($request->all(), $rules, $message);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $in = $request->all();
        $in['slug'] = createSlug($request->name);

        ListingCategory::create($in);

        Session::flash('success', 'New Listing category added successfully!');

        return Response::json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $rules = [
            'icon' => 'required',
            'name' => [
                'required',
                Rule::unique('listing_categories')->where(function ($query) use ($request) {
                    return $query->where('language_id', $request->input('language_id'));
                })->ignore($request->id, 'id'),
                'max:255',
            ],
            'status' => 'required|numeric',
            'serial_number' => 'required|numeric'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $category = ListingCategory::find($request->id);

        $in = $request->all();


        $in['slug'] = createSlug($request->name);

        $category->update($in);

        Session::flash('success', 'Listing category updated successfully!');

        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {

        $category = ListingCategory::find($id);
        $listingContents = $category->listing_contents()->get();

        if (count($listingContents) > 0) {
            return redirect()->back()->with('warning', 'First delete all the listing of this category!');
        } else {
            $category->delete();

            return redirect()->back()->with('success', 'Category deleted successfully!');
        }
    }

    public function bulkDestroy(Request $request)
    {

        $ids = $request->ids;

        $errorOccurred = false;

        foreach ($ids as $id) {
            $category = ListingCategory::find($id);
            $listingContents = $category->listing_contents()->get();

            if (count($listingContents) > 0) {
                $errorOccurred = true;
                break;
            } else {
                $category->delete();
            }
        }

        if ($errorOccurred == true) {
            Session::flash('warning', 'First delete all the listing of these categories!');
        } else {
            Session::flash('success', 'Listing categories deleted successfully!');
        }

        return Response::json(['status' => 'success'], 200);
    }
}
