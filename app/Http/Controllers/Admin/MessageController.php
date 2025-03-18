<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Language;
use Illuminate\Http\Request;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ProductMessage;
use Illuminate\Support\Facades\Session;

class MessageController extends Controller
{
    public function index(Request $request)
    {
        $information['langs'] = Language::all();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $information['messages'] = ListingMessage::orderBy('id', 'desc')
            ->paginate(10);
        return view('admin.message.listing', $information);
    }
    public function productIndex(Request $request)
    {
        $information['langs'] = Language::all();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $information['messages'] = ProductMessage::orderBy('id', 'desc')
            ->paginate(10);
        return view('admin.message.product', $information);
    }
    public function delete(Request $request)
    {
        $message = ListingMessage::findOrFail($request->message_id);

        $message->delete();
        Session::flash('success', 'Message deleted successfully!');
        return redirect()->back();
    }
    public function productDelete(Request $request)
    {
        $message = ProductMessage::findOrFail($request->message_id);

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
