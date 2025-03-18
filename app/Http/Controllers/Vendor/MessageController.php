<?php

namespace App\Http\Controllers\Vendor;

use App\Http\Controllers\Controller;
use App\Models\Language;
use Illuminate\Http\Request;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ProductMessage;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;

class MessageController extends Controller
{
    public function index(Request $request)
    {
        $information['langs'] = Language::all();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        $vendor_id = Auth::guard('vendor')->user()->id;
        $permissions = listingMessagePermission($vendor_id);
        if ($permissions) {
            $information['messages'] = ListingMessage::where('vendor_id', Auth::guard('vendor')->user()->id)
                ->orderBy('id', 'desc')
                ->paginate(10);
            return view('vendors.message.listing', $information);
        } else {
            Session::flash('warning', "Your Listing message Permission is not granted.");
            return redirect()->route('vendor.dashboard');
        }
    }
    public function delete(Request $request)
    {
        $message = ListingMessage::findOrFail($request->message_id);

        $message->delete();
        Session::flash('success', 'Message deleted successfully!');
        return redirect()->back();
    }
    public function bulkDelete(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $message = ListingMessage::findOrFail($id);

            $message->delete();
        }

        Session::flash('success', 'Message deleted successfully!');

        return response()->json(['status' => 'success'], 200);
    }

    public function productIndex(Request $request)
    {
        $information['langs'] = Language::all();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $vendor_id = Auth::guard('vendor')->user()->id;
        $permissions = productMessagePermission($vendor_id);
        if ($permissions) {
            $information['messages'] = ProductMessage::where('vendor_id', Auth::guard('vendor')->user()->id)
                ->orderBy('id', 'desc')
                ->paginate(10);
            return view('vendors.message.product', $information);
        } else {
            Session::flash('warning', "Your Product message Permission is not granted.");
            return redirect()->route('vendor.dashboard');
        }
    }

    public function productDelete(Request $request)
    {
        $message = ProductMessage::findOrFail($request->message_id);

        $message->delete();
        Session::flash('success', 'Message deleted successfully!');
        return redirect()->back();
    }

    public function productBulkDelete(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $message = ProductMessage::findOrFail($id);

            $message->delete();
        }

        Session::flash('success', 'Message deleted successfully!');

        return response()->json(['status' => 'success'], 200);
    }
}
