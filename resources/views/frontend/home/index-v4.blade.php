@extends('frontend.layout')

@section('pageHeading')
  {{ __('Home') }}
@endsection
@section('metaKeywords')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_keyword_home }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_description_home }}
  @endif
@endsection

@section('content')
  <!-- Home-area start-->
  <section class="hero-banner hero-banner-4 header-next pb-60">
    <div class="container container-lg-fluid px-lg-0">
      <div class="row align-items-center">
        <div class="col-lg-7">
          <div class="fluid-left">
            <div class="content-left mb-40">
              <div class="content">
                <h1 class="title mb-20 w-75" data-aos="fade-up">
                  {{ !empty($heroSection->title) ? $heroSection->title : 'Are You Looking For A business?' }}
                </h1>
                <p class="text mb-30" data-aos="fade-up" data-aos-delay="100">
                  {{ !empty($heroSection->text) ? $heroSection->text : '' }}</p>
              </div>
              <div class="banner-filter-form mb-20" data-aos="fade-up" data-aos-delay="150">
                <div class="form-wrapper radius-xl">
                  <form action="{{ route('frontend.listings') }}" id="searchForm2" method="GET">
                    <div class="row align-items-center gx-xl-3">
                      <div class="col-lg-4 col-md-6">
                        <div class="input-group border-end">
                          <label for="search"><i class="ico-shopping-mall"></i></label>
                          <input type="text" name="title" id="title" class="form-control"
                            placeholder="{{ __('I’m Looking for') }}">
                        </div>
                      </div>
                      <div class="col-lg-3 col-md-6">
                        <div class="input-group border-end">
                          <label for="category"><i class="ico-category"></i></label>
                          <select aria-label="categories" id="category_id" name="category_id"
                            class="select2 js-example-basic-single1">
                            <option value="">{{ __('All') }}</option>
                            @foreach ($categories as $category)
                              <option value="{{ $category->slug }}">{{ $category->name }}
                              </option>
                            @endforeach
                          </select>
                        </div>
                      </div>
                      <div class="col-lg-3 col-md-6">
                        <div class="input-group">
                          <label for="location"><i class="ico-location-pin"></i></label>
                          <input type="text" name="location" id="location" class="form-control"
                            placeholder="{{ __('Location') }}">
                        </div>
                      </div>
                      <div class="col-lg-2 col-md-6">
                        <button type="button" id="searchBtn2" class="btn btn-lg btn-primary icon-start w-100">
                          <i class="fal fa-search"></i>
                          <span class="d-lg-none">
                            {{ __('Search Now') }}
                          </span>
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-5">
          <div class="img mb-40">
            @if ($heroSectionImage)
              <img class="lazyload" data-src="{{ asset('assets/img/hero-section/' . $heroSectionImage) }}"alt="Bg-img"
                alt="Image">
            @else
              <img class="lazyload" data-src="{{ asset('assets/img/hero-section/' . $heroSectionImage) }}"alt="Bg-img"
                alt="Image">
            @endif
          </div>
        </div>
      </div>
    </div>
    <!-- Bg Shape -->
    <div class="shape">
      <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-23.svg') }}" alt="Shape">
      <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-24.svg') }}" alt="Shape">
      <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-7.svg') }}" alt="Shape">
      <img class="shape-5 opacity-50" src="{{ asset('assets/front/images/shape/shape-2.svg') }}" alt="Shape">
    </div>
  </section>


  <!-- Home-area end -->

  <!-- Works-area start -->
  @if ($secInfo->work_process_section_status == 1)
    <section class="work-area work-process-2 pb-75">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="section-title title-inline mb-40" data-aos="fade-up">
              <h2 class="title mb-0">{{ @$workProcessSecInfo->title }}</h2>
            </div>
          </div>
          <div class="col-lg-12">
            <div class="row">
              @foreach ($processes as $process)
                <div class="col-sm-6 col-xl-4" data-aos="fade-up">
                  <div class="card mb-25 border radius-lg">
                    <div class="card-icon mb-20">
                      <i class="{{ $process->icon }}"></i>
                    </div>
                    <div class="card-content">
                      <h3 class="card-title mb-15">{{ $process->title }}</h3>
                      <p class="card-text mb-0">
                        {{ $process->text }}
                      </p>
                    </div>
                  </div>
                </div>
              @endforeach

            </div>
          </div>
        </div>
      </div>
      <!-- Bg Shape -->
      <div class="shape">
        <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-26.svg') }}" alt="Shape">
        <img class="shape-4 opacity-50" src="{{ asset('assets/front/images/shape/shape-22.svg') }}" alt="Shape">

      </div>
    </section>
  @endif
  <!-- Works-area start -->

  <!-- Category-area start -->
  @if ($secInfo->category_section_status == 1)
    <section class="category-area category-4 bg-primary-light ptb-100">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-12">
            <div class="section-title title-inline mb-30" data-aos="fade-up">
              <h2 class="title mb-20">{{ $catgorySecInfo ? $catgorySecInfo->title : 'CATEGORIES' }}</h2>
            </div>
          </div>
          <div class="col-lg-12">
            @if (count($categories) < 1)
              <h3 class="text-center mt-2">{{ __('NO CATEGORY FOUND') . '!' }}</h3>
            @else
              <div class="swiper" id="category-slider-1" data-aos="fade-up" data-aos-delay="100">
                <div class="swiper-wrapper">
                  @foreach ($categories as $category)
                    <div class="swiper-slide">
                      <a href="{{ route('frontend.listings', ['category_id' => $category->slug]) }}">
                        <div class="category-item border radius-md text-center">
                          <div class="category-icon radius-lg hover-primary">
                            <i class="{{ $category->icon }}"></i>
                          </div>
                          <h3 class="category-title mb-0">{{ $category->name }}</h3>
                          <span class="category-qty">{{ $category->listing_contents_count }}</span>
                        </div>
                      </a>
                    </div>
                  @endforeach
            @endif

          </div>
          <!-- Slider Pagination -->
          <div class="swiper-pagination position-static mt-40" id="category-slider-1-pagination"></div>
        </div>
      </div>
      </div>
      </div>
    </section>
  @endif
  <!-- Category-area end -->

  <!-- Product-area start -->
  @if ($secInfo->featured_listing_section_status == 1)
    <section class="product-area ptb-100">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="section-title title-center" data-aos="fade-up">
              <h2 class="title mb-30">{{ $listingSecInfo ? $listingSecInfo->title : 'LISTINGS' }} </span>
              </h2>
              <div class="tabs-navigation mb-40">
              </div>
            </div>
          </div>
          <div class="col-12">
            <div class="tab-content">
              <div class="tab-pane fade active show" id="forAll">
                <div class="row">
                  @if (count($listing_contents) < 1)
                    <h3 class="text-center mt-2">{{ __('NO LISTING FOUND') }}</h3>
                  @else
                    @foreach ($listing_contents as $listing_content)
                      <div class="col-md-6 col-lg-4 col-xl-6" data-aos="fade-up">
                        <div class="row g-0 product-default product-column border radius-md mb-25 align-items-center">
                          <figure class="product-img radius-0 col-xl-6">
                            <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}"
                              class="lazy-container ratio ratio-2-3">
                              <img class="lazyload"
                                data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
                                alt="{{ optional($listing_content)->title }}">
                            </a>
                            @if (Auth::guard('web')->check())
                              @php
                                $user_id = Auth::guard('web')->user()->id;
                                $checkWishList = checkWishList($listing_content->id, $user_id);
                              @endphp
                            @else
                              @php
                                $checkWishList = false;
                              @endphp
                            @endif
                            <a href="{{ $checkWishList == false ? route('addto.wishlist', $listing_content->id) : route('remove.wishlist', $listing_content->id) }}"
                              class="btn-icon {{ $checkWishList == false ? '' : 'wishlist-active' }}"
                              data-tooltip="tooltip" data-bs-placement="top"
                              title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
                              <i class="fal fa-heart"></i>
                            </a>
                          </figure>
                          <div class="product-details p-4 col-xl-6">
                            <div class="product-top mb-15">
                              @php
                                if ($listing_content->vendor_id == 0) {
                                    $vendorInfo = App\Models\Admin::first();
                                    $userName = 'admin';
                                } else {
                                    $vendorInfo = App\Models\Vendor::findorfail($listing_content->vendor_id);
                                    $userName = $vendorInfo->username;
                                }
                              @endphp

                              <div class="author">
                                <a class="color-medium"
                                  href="{{ route('frontend.vendor.details', ['username' => $userName]) }}"
                                  target="_self" title={{ $vendorInfo->username }}>

                                  @if ($listing_content->vendor_id == 0)
                                    <img class="lazyload" src="assets/images/placeholder.png"
                                      data-src="{{ asset('assets/img/admins/' . $vendorInfo->image) }}" alt="Vendor">
                                  @else
                                    @if ($vendorInfo->photo != null)
                                      <img class="blur-up lazyload"
                                        data-src="{{ asset('assets/admin/img/vendor-photo/' . $vendorInfo->photo) }}"
                                        alt="Image">
                                    @else
                                      <img class="blur-up lazyload" data-src="{{ asset('assets/img/blank-user.jpg') }}"
                                        alt="Image">
                                    @endif
                                  @endif
                                  <span>{{ __('By') }}
                                    {{ $vendorInfo->username }}
                                  </span>
                                </a>
                              </div>
                              @php
                                $categorySlug = App\Models\ListingCategory::findorfail($listing_content->category_id);
                              @endphp
                              <a href="{{ route('frontend.listings', ['category_id' => $categorySlug->slug]) }}"
                                title="Link" class="product-category font-sm icon-start">
                                <i class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
                              </a>
                            </div>
                            <h5 class="product-title mb-10"><a
                                href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}">{{ optional($listing_content)->title }}</a>
                            </h5>
                            <div class="product-ratings mb-10">
                              <div class="ratings">
                                <div class="rate" style="background-image: url('{{ asset($rateStar) }}')">
                                  <div class="rating-icon"
                                    style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing_content->average_rating * 20 . '%;' }}">
                                  </div>
                                </div>
                                <span class="ratings-total font-sm">({{ $listing_content->average_rating }})</span>
                                <span
                                  class="ratings-total color-medium ms-1 font-sm">{{ totalListingReview($listing_content->id) }}
                                  {{ __('Reviews') }}</span>
                              </div>
                            </div>
                            @php
                              $city = null;
                              $State = null;
                              $country = null;

                              if ($listing_content->city_id) {
                                  $city = App\Models\Location\City::Where('id', $listing_content->city_id)->first()
                                      ->name;
                              }
                              if ($listing_content->state_id) {
                                  $State = App\Models\Location\State::Where('id', $listing_content->state_id)->first()
                                      ->name;
                              }
                              if ($listing_content->country_id) {
                                  $country = App\Models\Location\Country::Where(
                                      'id',
                                      $listing_content->country_id,
                                  )->first()->name;
                              }

                            @endphp
                            <span class="product-location icon-start"><i
                                class="fal fa-map-marker-alt"></i>{{ @$city }}
                              @if (@$State)
                                ,{{ $State }}
                                @endif @if (@$country)
                                  ,{{ @$country }}
                                @endif
                            </span>
                            @if ($listing_content->max_price && $listing_content->min_price)
                              <div class="product-price mt-10">
                                <span class="color-medium me-2">{{ __('From') }}</span>
                                <h6 class="price mb-0 lh-1">
                                  {{ symbolPrice($listing_content->min_price) }} -
                                  {{ symbolPrice($listing_content->max_price) }}
                                </h6>
                              </div>
                            @endif
                          </div>
                        </div>
                      </div>
                    @endforeach
                  @endif

                </div>
              </div>
            </div>
            @if (count($total_listing_contents) > count($listing_contents))
              <div class="text-center mt-20">
                <a href="{{ route('frontend.listings') }}"
                  class="btn btn-lg btn-primary">{{ $listingSecInfo ? $listingSecInfo->button_text : 'More' }}</a>
              </div>
            @endif
          </div>
        </div>
      </div>
      <!-- Bg Shape -->
      <div class="shape">
        <img class="shape-1 start-0 opacity-50"src="{{ asset('assets/front/images/shape/shape-23.svg') }}"
          alt="Shape">
        <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-19.svg') }}" alt="Shape">
        <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-11.svg') }}" alt="Shape">
        <img class="shape-4 end-0 opacity-75" src="{{ asset('assets/front/images/shape/shape-23.svg') }}"
          alt="Shape">
      </div>
    </section>
  @endif
  <!-- Product-area end -->

  <!-- Explore-area start -->
  @if ($secInfo->call_to_action_section_status == 1)
    <section class="explore-area pb-60">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-5">
            <div class="content-title mb-40" data-aos="fade-up">
              <h2 class="title mb-10">
                {{ @$callToActionSecInfo->title }}
              </h2>
              <p class="mb-20 w-75 w-sm-100"> {{ @$callToActionSecInfo->subtitle }}
              </p>
              @if ($callToActionSecInfo && $callToActionSecInfo->button_url && $callToActionSecInfo->button_name)
                <a href="{{ @$callToActionSecInfo->button_url }}"
                  class="btn btn-lg btn-primary">{{ @$callToActionSecInfo->button_name }}</a>
              @endif

            </div>
          </div>
          <div class="col-lg-7">
            <div class="image mb-40" data-aos="fade-left">
              <img class="lazyload" data-src="{{ asset('assets/img/' . $callToActionSectionImage) }}" alt="Image">
            </div>
          </div>
        </div>
      </div>
      <!-- Bg Shape -->
      <div class="shape">
        <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-23.svg') }}" alt="Shape">
        <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-24.svg') }}" alt="Shape">
        <img class="shape-4" src="{{ asset('assets/front/images/shape/shape-7.svg') }}" alt="Shape">
        <img class="shape-5 opacity-50" src="{{ asset('assets/front/images/shape/shape-2.svg') }}" alt="Shape">
      </div>
    </section>
  @endif
  <!-- Explore-area end -->

  <!-- Pricing-area start -->
  @if ($secInfo->package_section_status == 1)
    <section class="pricing-area pb-75">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="section-title title-center mb-40" data-aos="fade-up">
              <h2 class="title">{{ $packageSecInfo ? $packageSecInfo->title : 'Most Affordable Package' }}
              </h2>
            </div>
            <div class="tabs-navigation tabs-navigation-2 text-center mb-40" data-aos="fade-up">
              <ul class="nav nav-tabs rounded-pill" data-hover="fancyHover">
                @php
                  $totalTerms = count($terms);
                  $middleTerm = intdiv($totalTerms, 2);
                @endphp
                @foreach ($terms as $index => $term)
                  <li class="nav-item {{ $index == $middleTerm ? 'active' : '' }}">
                    <button class="nav-link hover-effect rounded-pill {{ $index == $middleTerm ? 'active' : '' }}"
                      data-bs-toggle="tab" data-bs-target="#{{ strtolower($term) }}" type="button">
                      {{ __($term) }}
                    </button>
                  </li>
                @endforeach
              </ul>
            </div>
          </div>
          <div class="col-12">
            <div class="tab-content">
              @if (count($terms) < 1)
                <h3 class="text-center mt-2">{{ __('NO PACKAGE FOUND') }}</h3>
              @else
                @foreach ($terms as $index => $term)
                  <div class="tab-pane fade {{ $index == $middleTerm ? 'show active' : '' }}"
                    id="{{ strtolower($term) }}">
                    <div class="row justify-content-center">
                      @php
                        $packages = \App\Models\Package::where('status', '1')->where('term', strtolower($term))->get();
                        $totalItems = count($packages);
                        $middleIndex = intdiv($totalItems, 2);
                      @endphp
                      @foreach ($packages as $index => $package)
                        @php
                          $permissions = $package->features;
                          if (!empty($package->features)) {
                              $permissions = json_decode($permissions, true);
                          }
                        @endphp
                        <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
                          <div class="pricing-item radius-lg {{ $package->recommended ? 'active' : '' }} mb-30">
                            <div class="d-flex align-items-center">
                              <div class="icon"><i class="{{ $package->icon }}"></i></div>
                              <div class="label">
                                <h3> {{ __($package->title) }}</h3>
                                @if ($package->recommended == '1')
                                  <span>{{ __('Popular') }}</span>
                                @endif

                              </div>
                            </div>
                            <p class="text"></p>
                            <div class="d-flex align-items-center">
                              <span class="price">{{ symbolPrice($package->price) }}</span>
                              @if ($package->term == 'monthly')
                                <span class="period">/ {{ __('Monthly') }}</span>
                              @elseif($package->term == 'yearly')
                                <span class="period">/ {{ __('Yearly') }}</span>
                              @elseif($package->term == 'lifetime')
                                <span class="period">/ {{ __('Lifetime') }}</span>
                              @endif
                            </div>
                            <h5>{{ __('What\'s Included') }}</h5>
                            <ul class="item-list list-unstyled p-0 pricing-list">

                              <li><i class="fal fa-check"></i>
                                @if ($package->number_of_listing == 999999)
                                  {{ __('Listing (Unlimited)') }}
                                @elseif($package->number_of_listing == 1)
                                  {{ __('Listing') }} ({{ $package->number_of_listing }})
                                @else
                                  {{ __('Listings') }} ({{ $package->number_of_listing }})
                                @endif
                              </li>

                              <li><i class="fal fa-check"></i>
                                @if ($package->number_of_images_per_listing == 999999)
                                  {{ __('Images Per Listing (Unlimited)') }}
                                @elseif($package->number_of_images_per_listing == 1)
                                  {{ __('Image Per Listing') }} ({{ $package->number_of_images_per_listing }})
                                @else
                                  {{ __('Images Per Listings') }} ({{ $package->number_of_images_per_listing }})
                                @endif
                              </li>
                              <li>
                                <i
                                  class=" @if (is_array($permissions) && in_array('Listing Enquiry Form', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                {{ __('Enquiry Form') }}
                              </li>

                              <li>
                                <i
                                  class=" @if (is_array($permissions) && in_array('Video', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                {{ __('Video') }}
                              </li>

                              <li><i
                                  class=" @if (is_array($permissions) && in_array('Amenities', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>

                                @if (is_array($permissions) && in_array('Amenities', $permissions))
                                  @if ($package->number_of_amenities_per_listing == 999999)
                                    {{ __('Amenities Per Listing(Unlimited)') }}
                                  @elseif($package->number_of_amenities_per_listing == 1)
                                    {{ __('Amenitie Per Listing') }} ({{ $package->number_of_amenities_per_listing }})
                                  @else
                                    {{ __('Amenities Per Listing') }}
                                    ({{ $package->number_of_amenities_per_listing }})
                                  @endif
                                @else
                                  {{ __('Amenities Per Listing') }}
                                @endif
                              </li>

                              <li><i
                                  class=" @if (is_array($permissions) && in_array('Feature', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>

                                @if (is_array($permissions) && in_array('Feature', $permissions))
                                  @if ($package->number_of_additional_specification == 999999)
                                    {{ __('Feature Per Listing (Unlimited)') }}
                                  @elseif($package->number_of_additional_specification == 1)
                                    {{ __('Feature Per Listing') }}
                                    ({{ $package->number_of_additional_specification }})
                                  @else
                                    {{ __('Features Per Listing') }}
                                    ({{ $package->number_of_additional_specification }})
                                  @endif
                                @else
                                  {{ __('Feature Per Listing') }}
                                @endif
                              </li>
                              <li><i
                                  class=" @if (is_array($permissions) && in_array('Social Links', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>

                                @if (is_array($permissions) && in_array('Social Links', $permissions))
                                  @if ($package->number_of_social_links == 999999)
                                    {{ __('Social Links Per Listing(Unlimited)') }}
                                  @elseif($package->number_of_social_links == 1)
                                    {{ __('Social Link Per Listing') }} ({{ $package->number_of_social_links }})
                                  @else
                                    {{ __('Social Links Per Listing') }} ({{ $package->number_of_social_links }})
                                  @endif
                                @else
                                  {{ __('Social Link Per Listing') }}
                                @endif
                              </li>
                              <li><i
                                  class=" @if (is_array($permissions) && in_array('FAQ', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                @if (is_array($permissions) && in_array('FAQ', $permissions))
                                  @if ($package->number_of_faq == 999999)
                                    {{ __('FAQ Per Listing(Unlimited)') }}
                                  @elseif($package->number_of_faq == 1)
                                    {{ __('FAQ Per Listing') }} ({{ $package->number_of_faq }})
                                  @else
                                    {{ __('FAQs Per Listing') }} ({{ $package->number_of_faq }})
                                  @endif
                                @else
                                  {{ __('FAQ Per Listing') }}
                                @endif
                              </li>

                              <li><i
                                  class=" @if (is_array($permissions) && in_array('Business Hours', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                {{ __('Business Hours') }}
                              </li>
                              <li><i
                                  class=" @if (is_array($permissions) && in_array('Products', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                @if (is_array($permissions) && in_array('Products', $permissions))
                                  @if ($package->number_of_products == 999999)
                                    {{ __('Products Per Listing (Unlimited)') }}
                                  @elseif($package->number_of_products == 1)
                                    {{ __('Product Per Listing') }} ({{ $package->number_of_products }})
                                  @else
                                    {{ __('Products Per Listing') }} ({{ $package->number_of_products }})
                                  @endif
                                @else
                                  {{ __('Products Per Listing') }}
                                @endif
                              </li>

                              @if (is_array($permissions) && in_array('Products', $permissions))
                                <li><i class="fal fa-check"></i>
                                  @if ($package->number_of_images_per_products == 999999)
                                    {{ __('Product Image Per Product (Unlimited)') }}
                                  @elseif($package->number_of_images_per_products == 1)
                                    {{ __('Product Image Per Product') }}
                                    ({{ $package->number_of_images_per_products }})
                                  @else
                                    {{ __('Product Images Per Product') }}
                                    ({{ $package->number_of_images_per_products }})
                                  @endif

                                </li>
                              @else
                                <li><i class="fal fa-times not-active"></i>
                                  {{ __('Product Image Per Product') }}</li>
                              @endif


                              @if (is_array($permissions) && in_array('Products', $permissions))
                                <li><i
                                    class=" @if (is_array($permissions) && in_array('Product Enquiry Form', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                  {{ __('Product Enquiry Form') }} </li>
                              @else
                                <li><i class="fal fa-times not-active"></i>
                                  {{ __('Product Enquiry Form') }}</li>
                              @endif
                              <li>
                                <i
                                  class=" @if (is_array($permissions) && in_array('Messenger', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                {{ __('Messenger') }}
                              </li>
                              <li>
                                <i
                                  class=" @if (is_array($permissions) && in_array('WhatsApp', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                {{ __('WhatsApp') }}
                              </li>
                              <li>
                                <i
                                  class=" @if (is_array($permissions) && in_array('Telegram', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                {{ __('Telegram') }}
                              </li>
                              <li>
                                <i
                                  class=" @if (is_array($permissions) && in_array('Tawk.To', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
                                {{ __('Tawk.To') }}
                              </li>


                              @if (!is_null($package->custom_features))
                                @php
                                  $features = explode("\n", $package->custom_features);
                                @endphp
                                @if (count($features) > 0)
                                  @foreach ($features as $key => $value)
                                    <li><i class="fal fa-check"></i>{{ __($value) }}
                                    </li>
                                  @endforeach
                                @endif
                              @endif

                            </ul>
                            @auth('vendor')
                              <a href="{{ route('vendor.plan.extend.checkout', $package->id) }}"
                                class="btn btn-outline btn-lg" title="Purchase" target="_self">{{ __('Purchase') }}</a>
                            @endauth
                            @guest('vendor')
                              <a href="{{ route('vendor.login', ['redirectPath' => 'buy_plan', 'package' => $package->id]) }}"
                                class="btn btn-outline btn-lg" title="Purchase" target="_self">{{ __('Purchase') }}</a>
                            @endguest
                          </div>
                        </div>
                      @endforeach

                    </div>
                  </div>
                @endforeach
              @endif
            </div>
          </div>
        </div>
      </div>
      <!-- Bg Shape -->
      <div class="shape">
        <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-3.svg') }}" alt="Shape">
        <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-6.svg') }}" alt="Shape">
        <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-5.svg') }}" alt="Shape">
        <img class="shape-4" src="{{ asset('assets/front/images/shape/shape-2.svg') }}" alt="Shape">
      </div>
    </section>
  @endif
  <!-- Pricing-area end -->

  <!-- Video banner start -->
  @if ($secInfo->video_section == 1)
    <section class="video-banner pt-100 pb-60">
      <!-- Background Image -->
      <img class="lazyload bg-img blur-up" data-src="{{ asset('assets/img/' . $videoSectionImage) }}" alt="Bg-img">
      <div class="overlay opacity-75"></div>
      <div class="container">
        <div class="row">
          <div class="col-lg-5">
            <div class="content-title mb-40" data-aos="fade-up">
              <h2 class="title color-white mb-15">{{ @$videoSecInfo->title }}</h2>
              <p class="color-light mb-25 w-75 w-sm-100">{{ @$videoSecInfo->subtitle }}</p>
              @if (@$videoSecInfo->button_url && @$videoSecInfo->button_name)
                <a href="{{ @$videoSecInfo->button_url }}" class="btn btn-lg btn-primary rounded-pill"
                  target="_blank">{{ @$videoSecInfo->button_name }}</a>
              @endif
            </div>
          </div>
          @if (@$videoSecInfo->video_url)
            <div class="col-lg-7 py-4 py-lg-0">
              <div class="h-100 position-relative mb-40" data-aos="fade-up">
                <a href="{{ @$videoSecInfo->video_url }}"
                  class="video-btn youtube-popup position-absolute top-50 start-50 translate-middle">
                  <i class="fas fa-play"></i>
                </a>
              </div>
            </div>
          @endif

        </div>
      </div>
    </section>
  @endif
  <!-- Video banner end -->

  <!-- Blog-area start -->
  @if ($secInfo->blog_section_status == 1)
    <section class="blog-area blog-3 pt-100 pb-75">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="section-title title-inline mb-30" data-aos="fade-up">
              <h2 class="title mb-20">
                {{ !empty($blogSecInfo->title) ? $blogSecInfo->title : 'Read Our Latest Blog' }}
              </h2>
              @if (count($blog_count) > count($blogs))
                <a href="{{ route('blog') }}"
                  class="btn btn-lg btn-primary rounded-pill mb-20">{{ $blogSecInfo ? $blogSecInfo->button_text : 'More' }}</a>
              @endif
            </div>
          </div>
          <div class="col-12">
            <div class="row justify-content-center">
              @if (count($blogs) < 1)
                <h3 class="text-center mt-2">{{ __('NO POST FOUND') . '!' }}</h3>
              @else
                @foreach ($blogs as $blog)
                  <div class="col-md-6 col-lg-4" data-aos="fade-up">
                    <article class="card border mb-25">
                      <div class="card-img radius-md">
                        <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}"
                          class="lazy-container ratio ratio-16-10">
                          <img class="lazyload" data-src="{{ asset('assets/img/blogs/' . $blog->image) }}"
                            alt="Blog Image">
                        </a>
                      </div>
                      <div class="content">
                        <h3 class="card-title">
                          <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}">
                            {{ @$blog->title }}
                          </a>
                        </h3>
                        <p class="card-text">
                          {{ strlen(strip_tags(convertUtf8($blog->content))) > 100 ? substr(strip_tags(convertUtf8($blog->content)), 0, 100) . '...' : strip_tags(convertUtf8($blog->content)) }}
                        </p>
                        <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}"
                          class="card-btn">{{ __('Read More') }}</a>
                      </div>
                    </article>
                  </div>
                @endforeach
              @endif
            </div>
          </div>
        </div>
      </div>
      <!-- Bg Shape -->
      <div class="shape">
        <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-20.svg') }}" alt="Shape">
        <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-5.svg') }}" alt="Shape">
        <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-4.svg') }}" alt="Shape">
        <img class="shape-4" src="{{ asset('assets/front/images/shape/shape-2.svg') }}" alt="Shape">
      </div>
    </section>
  @endif
  <!-- Blog-area end -->
@endsection
@section('script')
  <script src="{{ asset('assets/front/js/search-home.js') }}"></script>
@endsection
