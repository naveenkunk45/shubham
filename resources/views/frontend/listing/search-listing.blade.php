@if (count($featured_contents) < 1 && count($currentPageData) < 1)
  <div class="p-4 text-center bg-light radius-md">
    <h3 class="mb-0">{{ __('NO LISTING FOUND') }}</h3>
  </div>
@else
  <div class="row">
    @foreach ($featured_contents as $listing_content)
      <div class="col-md-6 col-lg-4" data-aos="fade-up">
        <div class="product-default border radius-md mb-25 active">
          <figure class="product-img">
            <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}"
              class="lazy-container ratio ratio-2-3">
              <img class="lazyload" data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
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
              class="btn-icon {{ $checkWishList == false ? '' : 'wishlist-active' }}" data-tooltip="tooltip"
              data-bs-placement="top" title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
              <i class="fal fa-heart"></i>
            </a>
          </figure>

          <div class="product-details">
            <div class="product-top mb-10">

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
                <a class="color-medium" href="{{ route('frontend.vendor.details', ['username' => $userName]) }}"
                  target="_self" title={{ $vendorInfo->username }}>

                  @if ($listing_content->vendor_id == 0)
                    <img class="lazyload" src="assets/images/placeholder.png"
                      data-src="{{ asset('assets/img/admins/' . $vendorInfo->image) }}" alt="Vendor">
                  @else
                    @if ($vendorInfo->photo != null)
                      <img class="blur-up lazyload"
                        data-src="{{ asset('assets/admin/img/vendor-photo/' . $vendorInfo->photo) }}" alt="Image">
                    @else
                      <img class="blur-up lazyload" data-src="{{ asset('assets/img/blank-user.jpg') }}" alt="Image">
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
              <a href="{{ route('frontend.listings', ['category_id' => $categorySlug->slug]) }}" title="Link"
                class="product-category font-sm icon-start">
                <i class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
              </a>
            </div>
            <h6 class="product-title mb-10"><a
                href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}">{{ optional($listing_content)->title }}</a>
            </h6>
            <div class="product-ratings mb-10">
              <div class="ratings">
                <div class="rate" style="background-image: url('{{ asset($rateStar) }}')">
                  <div class="rating-icon"
                    style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing_content->average_rating * 20 . '%;' }}">
                  </div>
                </div>
                <span class="ratings-total font-sm">({{ number_format($listing_content->average_rating, 2) }})</span>
                <span class="ratings-total color-medium ms-1 font-sm">{{ totalListingReview($listing_content->id) }}
                  {{ __('Reviews') }}</span>
              </div>
            </div>
            @php
              $city = null;
              $State = null;
              $country = null;

              if ($listing_content->city_id) {
                  $city = App\Models\Location\City::Where('id', $listing_content->city_id)->first()->name;
              }
              if ($listing_content->state_id) {
                  $State = App\Models\Location\State::Where('id', $listing_content->state_id)->first()->name;
              }
              if ($listing_content->country_id) {
                  $country = App\Models\Location\Country::Where('id', $listing_content->country_id)->first()->name;
              }

            @endphp
            <span class="product-location icon-start font-sm"><i class="fal fa-map-marker-alt"></i>{{ @$city }}
              @if (@$State)
                ,{{ $State }}
                @endif @if (@$country)
                  ,{{ @$country }}
                @endif
            </span>

            @if ($listing_content->max_price && $listing_content->min_price)
              <div class="product-price mt-10 pt-10 border-top">
                <span class="color-medium me-2">{{ __('From') }}</span>
                <h6 class="price mb-0 lh-1">
                  {{ symbolPrice($listing_content->min_price) }} -
                  {{ symbolPrice($listing_content->max_price) }}
                </h6>
              </div>
            @endif
          </div>
        </div><!-- product-default -->
      </div>
    @endforeach
    @foreach ($currentPageData as $listing_content)
      <div class="col-md-6 col-lg-4" data-aos="fade-up">
        <div class="product-default border radius-md mb-25">
          <figure class="product-img">
            <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}"
              class="lazy-container ratio ratio-2-3">
              <img class="lazyload" data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
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
              class="btn-icon {{ $checkWishList == false ? '' : 'wishlist-active' }}" data-tooltip="tooltip"
              data-bs-placement="top" title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
              <i class="fal fa-heart"></i>
            </a>
          </figure>

          <div class="product-details">
            <div class="product-top mb-10">

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
                <a class="color-medium" href="{{ route('frontend.vendor.details', ['username' => $userName]) }}"
                  target="_self" title={{ $vendorInfo->username }}>

                  @if ($listing_content->vendor_id == 0)
                    <img class="lazyload" src="assets/images/placeholder.png"
                      data-src="{{ asset('assets/img/admins/' . $vendorInfo->image) }}" alt="Vendor">
                  @else
                    @if ($vendorInfo->photo != null)
                      <img class="blur-up lazyload"
                        data-src="{{ asset('assets/admin/img/vendor-photo/' . $vendorInfo->photo) }}" alt="Image">
                    @else
                      <img class="blur-up lazyload" data-src="{{ asset('assets/img/blank-user.jpg') }}" alt="Image">
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
              <a href="{{ route('frontend.listings', ['category_id' => $categorySlug->slug]) }}" title="Link"
                class="product-category font-sm icon-start">
                <i class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
              </a>
            </div>
            <h6 class="product-title mb-10"><a
                href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}">{{ optional($listing_content)->title }}</a>
            </h6>
            <div class="product-ratings mb-10">
              <div class="ratings">
                <div class="rate" style="background-image: url('{{ asset($rateStar) }}')">
                  <div class="rating-icon"
                    style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing_content->average_rating * 20 . '%;' }}">
                  </div>
                </div>
                <span class="ratings-total font-sm">({{ number_format($listing_content->average_rating, 2) }})</span>
                <span class="ratings-total color-medium ms-1 font-sm">{{ totalListingReview($listing_content->id) }}
                  {{ __('Reviews') }}</span>
              </div>
            </div>
            @php
              $city = null;
              $State = null;
              $country = null;

              if ($listing_content->city_id) {
                  $city = App\Models\Location\City::Where('id', $listing_content->city_id)->first()->name;
              }
              if ($listing_content->state_id) {
                  $State = App\Models\Location\State::Where('id', $listing_content->state_id)->first()->name;
              }
              if ($listing_content->country_id) {
                  $country = App\Models\Location\Country::Where('id', $listing_content->country_id)->first()->name;
              }

            @endphp
            <span class="product-location icon-start font-sm"><i class="fal fa-map-marker-alt"></i>{{ @$city }}
              @if (@$State)
                ,{{ $State }}
                @endif @if (@$country)
                  ,{{ @$country }}
                @endif
            </span>

            @if ($listing_content->max_price && $listing_content->min_price)
              <div class="product-price mt-10 pt-10 border-top">
                <span class="color-medium me-2">{{ __('From') }}</span>
                <h6 class="price mb-0 lh-1">
                  {{ symbolPrice($listing_content->min_price) }} -
                  {{ symbolPrice($listing_content->max_price) }}
                </h6>
              </div>
            @endif
          </div>
        </div><!-- product-default -->
      </div>
    @endforeach
  </div>
  @if ($listing_contents->count() / $perPage > 1)
    <div class="pagination mt-20 mb-40 justify-content-center" data-aos="fade-up">
      @for ($i = 1; $i <= ceil($listing_contents->count() / $perPage); $i++)
        <li class="page-item @if (request()->input('page') == $i) active @endif">
          <a class="page-link" data-page="{{ $i }}">{{ $i }}</a>
        </li>
      @endfor
    </div>
  @endif
@endif
<script>
  "use strict";
  var featured_contents = {!! json_encode($featured_contents) !!};
  var listing_contents = {!! json_encode($listing_contents) !!};
</script>
