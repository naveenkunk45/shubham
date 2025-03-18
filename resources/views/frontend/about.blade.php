@extends('frontend.layout')

@section('pageHeading')
{{ !empty($pageHeading) ? $pageHeading->about_us_title : __('About Us') }}
@endsection

@section('metaKeywords')
@if (!empty($seoInfo))
{{ $seoInfo->meta_keywords_about_page }}
@endif
@endsection

@section('metaDescription')
@if (!empty($seoInfo))
{{ $seoInfo->meta_description_about_page }}
@endif
@endsection

@section('content')
@includeIf('frontend.partials.breadcrumb', [
'breadcrumb' => $bgImg->breadcrumb,
'title' => !empty($pageHeading) ? $pageHeading->about_us_title : __('About Us'),
])





<section class="about_second">
  <div class="container">

    <div class="row">
      <div class="col-12 col-md-8 about_second_col">
        <h2>About Founder</h2>
        <p>I come from the city of Mysuru and consider myself to be a simple person. In 2021, my friend and I planned a family event in our city and searched for event facilities such as function halls, decorations, food services, and other service providers nearby. However, we encountered several difficulties during the organizing process, including non-availability of function halls, high service costs, and lack of convenience. It took us nearly a month to find the right service provider at an affordable price.</p>
        <p>As a result of these difficulties, I was motivated to solve this problem and decided to start an organization that could assist people in all possible ways. My goal is to help people save their hard-earned money and time by providing them with the contact information of the best service providers in their vicinity.</p>
      </div>
      <div class="col-12 col-md-4 ">
        <img
          src="{{ asset('assets/admin/img/h/a.png') }}" alt="logo">
      </div>
    </div>
  </div>
</section>

<section class="mission_section">
  <div class="container">
    <div class="row">
      <div class="col-12 col-md-6">
        <div class="card">
          <img
            src="{{ asset('assets/admin/img/t/m.png') }}" alt="logo">
          <h3>Mission</h3>
          <p>To provide accessible, affordable, and reliable event service solutions through a user-friendly digital platform.</p>
        </div>
      </div>
      <div class="col-12 col-md-6 mt-2 md-md ">
        <div class="card">
          <img
            src="{{ asset('assets/admin/img/t/v.png') }}" alt="logo">
          <h3>Vision</h3>
          <p>To revolutionize event planning by connecting people with top service providers, ensuring seamless and memorable experiences.</p>
        </div>
      </div>

    </div>
  </div>
</section>

@endsection