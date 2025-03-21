<?php

namespace App\Http\Controllers\Admin\HomePage;

use App\Http\Controllers\Controller;
use App\Models\BasicSettings\Basic;
use App\Models\HomePage\Section;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class SectionController extends Controller
{
    public function index()
    {
        $sectionInfo = Section::query()->first();

        $themeVersion = Basic::query()->pluck('theme_version')->first();

        return view('admin.home-page.section-customization', compact('sectionInfo', 'themeVersion'));
    }

    public function update(Request $request)
    {
        $sectionInfo = Section::query()->first();

        $sectionInfo->update($request->all());

        Session::flash('success', 'Section status updated successfully!');

        return redirect()->back();
    }
}
