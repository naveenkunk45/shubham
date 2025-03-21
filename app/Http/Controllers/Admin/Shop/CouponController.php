<?php

namespace App\Http\Controllers\Admin\Shop;

use App\Http\Controllers\Controller;
use App\Http\Requests\Shop\CouponStoreRequest;
use App\Http\Requests\Shop\CouponUpdateRequest;
use App\Models\Shop\Coupon;
use Carbon\Carbon;
use Illuminate\Support\Facades\Session;

class CouponController extends Controller
{
    public function index()
    {
        // get the coupons from db
        $information['coupons'] = Coupon::orderByDesc('id')->get();

        // also, get the currency information from db
        $information['currencyInfo'] = $this->getCurrencyInfo();

        return view('admin.shop.coupon.index', $information);
    }

    public function store(CouponStoreRequest $request)
    {
        $startDate = Carbon::parse($request->start_date);
        $endDate = Carbon::parse($request->end_date);

        Coupon::create($request->except('start_date', 'end_date') + [
            'start_date' => date_format($startDate, 'Y-m-d'),
            'end_date' => date_format($endDate, 'Y-m-d')
        ]);

        Session::flash('success', 'New coupon added successfully!');

        return response()->json(['status' => 'success'], 200);
    }

    public function update(CouponUpdateRequest $request)
    {
        $startDate = Carbon::parse($request->start_date);
        $endDate = Carbon::parse($request->end_date);

        Coupon::find($request->id)->update($request->except('start_date', 'end_date') + [
            'start_date' => date_format($startDate, 'Y-m-d'),
            'end_date' => date_format($endDate, 'Y-m-d')
        ]);

        Session::flash('success', 'Coupon updated successfully!');

        return response()->json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        Coupon::find($id)->delete();

        return redirect()->back()->with('success', 'Coupon deleted successfully!');
    }
}
