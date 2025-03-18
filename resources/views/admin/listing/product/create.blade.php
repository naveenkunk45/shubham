@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Add Product') }}</h4>
    <ul class="breadcrumbs">
      <li class="nav-home">
        <a href="{{ route('admin.dashboard') }}">
          <i class="flaticon-home"></i>
        </a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Listings Management') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a
          href="{{ route('admin.listing_management.listing', ['language' => $defaultLang->code]) }}">{{ __('Manage Listings') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a
          href="{{ route('admin.listing_management.listing.products', ['id' => $listing_id, 'language' => $defaultLang->code]) }}">{{ __('Products') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Add Product') }}</a>
      </li>
    </ul>
  </div>
  @php
    $vendor_id = App\Models\Listing\Listing::where('id', $listing_id)->pluck('vendor_id')->first();

    if ($vendor_id != 0) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendor_id);

        $dowgraded = App\Http\Helpers\VendorPermissionHelper::packagesDowngraded($vendor_id);
        $listingCanAdd = packageTotalListing($vendor_id) - vendorTotalListing($vendor_id);

        if ($current_package != '[]') {
            $numberoffImages = $current_package->number_of_images_per_products;
        } else {
            $numberoffImages = 0;
        }

        if ($current_package != '[]') {
            if (TotalProductPerListing($listing_id) >= $current_package->number_of_products) {
                $can_product_add = 2;
            } else {
                $can_product_add = 1;
            }
        } else {
            $can_product_add = 0;
        }
    } else {
        $numberoffImages = 99999999;
        $can_product_add = 1;
    }
  @endphp

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Add Product') }}</div>
          <a class="btn btn-info btn-sm float-right d-inline-block"
            href="{{ route('admin.listing_management.listing.products', ['id' => $listing_id, 'language' => $defaultLang->code]) }}">
            <span class="btn-label">
              <i class="fas fa-backward"></i>
            </span>
            {{ __('Back') }}
          </a>

          @php
            $dContent = App\Models\Listing\ListingContent::where('listing_id', $listing_id)
                ->where('language_id', $defaultLang->id)
                ->first();
            $slug = !empty($dContent) ? $dContent->slug : '';
          @endphp
          @if ($dContent)
            <a class="btn btn-success btn-sm float-right mr-1 d-inline-block"
              href="{{ route('frontend.listing.details', ['slug' => $slug, 'id' => $listing_id]) }}" target="_blank">
              <span class="btn-label">
                <i class="fas fa-eye"></i>
              </span>
              {{ __('Preview') }}
            </a>
          @endif
          @if ($vendor_id != 0)
            <button type="button" class="btn btn-primary btn-sm btn-sm btn-round float-right" id="aa"
              data-toggle="modal" data-target="#adminCheckLimitModal">

              @if (
                  $dowgraded['listingImgDown'] ||
                      $dowgraded['listingFaqDown'] ||
                      $dowgraded['listingProductDown'] ||
                      $dowgraded['featureDown'] ||
                      $dowgraded['socialLinkDown'] ||
                      $dowgraded['amenitieDown'] ||
                      $dowgraded['listingProductImgDown'] ||
                      $listingCanAdd < 0)
                <i class="fas fa-exclamation-triangle text-danger"></i>
              @endif
              {{ __('Check Limit') }}
            </button>
          @endif
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-8 offset-lg-2">
              <div class="alert alert-danger pb-1 dis-none" id="productErrors">
                <ul></ul>
              </div>
              <div class="col-lg-12">
                <label for="" class="mb-2"><strong>{{ __('Gallery Images') }} *</strong></label>
                <form action="{{ route('admin.listing.product.imagesstore') }}" id="my-dropzone"
                  enctype="multipart/formdata" class="dropzone create">
                  @csrf
                  <div class="fallback">
                    <input name="file" type="file" multiple />
                  </div>
                </form>
                <p class="em text-danger mb-0" id="errslider_images"></p>
                @if ($vendor_id != 0)
                  @if ($current_package != '[]')
                    <p class="text-warning">
                      {{ __('You can upload maximum ' . $current_package->number_of_images_per_products . ' images under one product') }}
                    </p>
                  @endif
                @else
                  <p class="text-warning">
                    {{ __('You can upload unlimited images under one product') }}
                  </p>
                @endif
              </div>

              <form id="productForm" action="{{ route('admin.listing_management.listing.store_product') }}"
                enctype="multipart/form-data" method="POST">
                @csrf

                <div id="slider-image-id"></div>
                <input type="hidden"name="listing_id" value="{{ $listing_id }}">
                <div class="row">
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label for="">{{ __('Featured Image') . '*' }}</label>
                      <br>
                      <div class="thumb-preview">
                        <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..." class="uploaded-img">
                      </div>

                      <div class="mt-3">
                        <div role="button" class="btn btn-primary btn-sm upload-btn">
                          {{ __('Choose Image') }}
                          <input type="file" class="img-input" name="feature_image">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-lg-6">
                    <div class="form-group">
                      <label>{{ __('Status') . '*' }}</label>
                      <select name="status" class="form-control">
                        <option selected disabled>{{ __('Select a Status') }}</option>
                        <option value="1">{{ __('Active') }}</option>
                        <option value="0">{{ __('Inactive') }}</option>
                      </select>
                    </div>
                  </div>

                  @php $currencyText = $currencyInfo->base_currency_text; @endphp

                  <div class="col-lg-6">
                    <div class="form-group">
                      <label>{{ __('Current Price') . '* (' . $currencyText . ')' }}</label>
                      <input type="number" step="0.01" class="form-control" name="current_price"
                        placeholder="Enter Product Current Price">
                    </div>
                  </div>
                  <input type="hidden" name="vendor_id" value="{{ $vendor_id }}">

                  <div class="col-lg-6">
                    <div class="form-group">
                      <label>{{ __('Previous Price') . ' (' . $currencyText . ')' }}</label>
                      <input type="number" step="0.01" class="form-control" name="previous_price"
                        placeholder="Enter Product Previous Price">
                    </div>
                  </div>
                </div>

                <div id="accordion" class="mt-5">
                  @foreach ($languages as $language)
                    <div class="version">
                      <div class="version-header" id="heading{{ $language->id }}">
                        <h5 class="mb-0">
                          <button type="button"
                            class="btn btn-link {{ $language->direction == 1 ? 'rtl text-right' : '' }}"
                            data-toggle="collapse" data-target="#collapse{{ $language->id }}"
                            aria-expanded="{{ $language->is_default == 1 ? 'true' : 'false' }}"
                            aria-controls="collapse{{ $language->id }}">
                            {{ $language->name . __(' Language') }} {{ $language->is_default == 1 ? '(Default)' : '' }}
                          </button>
                        </h5>
                      </div>

                      <div id="collapse{{ $language->id }}"
                        class="collapse {{ $language->is_default == 1 ? 'show' : '' }}"
                        aria-labelledby="heading{{ $language->id }}" data-parent="#accordion">
                        <div class="version-body">
                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Title') . '*' }}</label>
                                <input type="text" class="form-control" name="{{ $language->code }}_title"
                                  placeholder="Enter Title">
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Content') . '*' }}</label>
                                <textarea class="form-control summernote" name="{{ $language->code }}_content" data-height="300"></textarea>
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-lg-12">
                              @php $currLang = $language; @endphp

                              @foreach ($languages as $language)
                                @continue($language->id == $currLang->id)

                                <div class="form-check py-0">
                                  <label class="form-check-label">
                                    <input class="form-check-input" type="checkbox"
                                      onchange="cloneInput('collapse{{ $currLang->id }}', 'collapse{{ $language->id }}', event)">
                                    <span class="form-check-sign">{{ __('Clone for') }} <strong
                                        class="text-capitalize text-secondary">{{ $language->name }}</strong>
                                      {{ __('language') }}</span>
                                  </label>
                                </div>
                              @endforeach
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  @endforeach
                </div>
                <div id="sliders">
                </div>
              </form>
            </div>
          </div>
        </div>

        <div class="card-footer">
          <div class="row">
            <div class="col-12 text-center">
              <button type="submit" form="productForm" data-can_product_add="{{ $can_product_add }}"
                class="btn btn-success">
                {{ __('Save') }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  @includeIf('admin.listing.check-limit')
@endsection

@section('script')
  <script>
    'use strict';
    var storeUrl = "{{ route('admin.listing.product.imagesstore') }}";
    var removeUrl = "{{ route('admin.listing.product.imagermv') }}";
    var galleryImages = {{ $numberoffImages }};
  </script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
@endsection
