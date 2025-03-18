<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Location\City;

class SearchController extends Controller
{
    public function autocomplete(Request $request)
    {
        $query = $request->input('query');

        $data = City::where('name', 'LIKE', "%{$query}%")
            ->limit(5)
            ->pluck('name'); // Change field if needed

        return response()->json($data);
    }


    public function getCities()
    {
        // $cities = City::orderBy('name')->pluck('name');
        // Fetch all city names
        // return response()->json($cities);

        $cities = City::orderBy('name')->get(); // Fetch all columns
        return response()->json($cities);
    }
}
