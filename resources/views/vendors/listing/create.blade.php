@extends('vendors.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Add Listing') }}</h4>
    <ul class="breadcrumbs">
      <li class="nav-home">
        <a href="{{ route('vendor.dashboard') }}">
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
        <a href="#">{{ __('Add Listing') }}</a>
      </li>
    </ul>
  </div>

  @php
    $vendorId = Auth::guard('vendor')->user()->id;

    if ($vendorId) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

        if ($current_package != '[]') {
            $numberoffImages = $current_package->number_of_images_per_listing;
        } else {
            $numberoffImages = 0;
        }
        if (!empty($current_package) && !empty($current_package->features)) {
            $permissions = json_decode($current_package->features, true);
        } else {
            $permissions = null;
        }
    } else {
        $permissions = null;
    }
  @endphp


  <div class="row">
    <div class="col-md-12">
      @if ($current_package != '[]')
        @if (vendorTotalAddedListing($vendorId) >= $current_package->number_of_listing)
          <div class="alert alert-warning">
            {{ __("You can't add more Listing. Please buy/extend a plan to add Listing") }}
          </div>
          @php
            $can_listing_add = 2;
          @endphp
        @else
          @php
            $can_listing_add = 1;
          @endphp
        @endif
      @else
        @php
          $pendingMemb = \App\Models\Membership::query()
              ->where([['vendor_id', '=', Auth::id()], ['status', 0]])
              ->whereYear('start_date', '<>', '9999')
              ->orderBy('id', 'DESC')
              ->first();
          $pendingPackage = isset($pendingMemb)
              ? \App\Models\Package::query()->findOrFail($pendingMemb->package_id)
              : null;
        @endphp
        @if ($pendingPackage)
          <div class="alert alert-warning">
            {{ __('You have requested a package which needs an action (Approval / Rejection) by Admin. You will be notified via mail once an action is taken.') }}
          </div>
          <div class="alert alert-warning">
            <strong>{{ __('Pending Package') . ':' }} </strong> {{ $pendingPackage->title }}
            <span class="badge badge-secondary">{{ $pendingPackage->term }}</span>
            <span class="badge badge-warning">{{ __('Decision Pending') }}</span>
          </div>
        @else
          @php
            $newMemb = \App\Models\Membership::query()
                ->where([['vendor_id', '=', Auth::id()], ['status', 0]])
                ->first();
          @endphp
          @if ($newMemb)
            <div class="alert alert-warning">
              {{ __('Your membership is expired. Please purchase a new package / extend the current package.') }}
            </div>
          @endif
          <div class="alert alert-warning">
            {{ __('Please purchase a new package to add Listing.') }}
          </div>
        @endif
        @php
          $can_listing_add = 0;
        @endphp
      @endif
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Add Listing') }}</div>
        </div>
        <div class="card-body">

          <div class="row">
            <div class="col-lg-10 offset-lg-1">


              <div class="alert alert-danger pb-1 dis-none" id="listingErrors">
                <ul></ul>
              </div>
              <div class="col-lg-12">
                <label for="" class="mb-2"><strong>{{ __('Gallery Images') }} *</strong></label>
                <form action="{{ route('vendor.listing.imagesstore') }}" id="my-dropzone" enctype="multipart/formdata"
                  class="dropzone create">
                  @csrf
                  <div class="fallback">
                    <input name="file" type="file" multiple />
                  </div>
                </form>
                <p class="em text-danger mb-0" id="errslider_images"></p>
                @if ($current_package != '[]')
                  @if (vendorTotalAddedListing($vendorId) <= $current_package->number_of_listing)
                    <p class="text-warning">
                      {{ __('You can upload maximum ' . $current_package->number_of_images_per_listing . ' images under one listing') }}
                    </p>
                  @endif
                @endif
              </div>

              <form id="listingForm" action="{{ route('vendor.listing_management.store_listing') }}" method="POST"
                enctype="multipart/form-data">
                @csrf
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
                      <p class="mt-2 mb-0 text-warning">{{ __('Image Size 600x400') }}</p>
                    </div>
                  </div>

                  @if (is_array($permissions) && in_array('Video', $permissions))
                    <div class="col-lg-3">
                      <div class="form-group">
                        <label for="">{{ __('Video Image') }}</label>
                        <br>
                        @php
                          $display = 'none';
                        @endphp
                        <div class="thumb-preview">
                          <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..." class="uploaded-img2">
                          <button class="remove-img2 btn btn-remove" type="button" style="display:{{ $display }};">
                            <i class="fal fa-times"></i>
                          </button>
                        </div>
                        <div class="mt-3">
                          <div role="button" class="btn btn-primary btn-sm upload-btn">
                            {{ __('Choose Image') }}
                            <input type="file" class="video-img-input" name="video_background_image">
                          </div>
                        </div>
                      </div>
                    </div>
                  @endif
                </div>

                <div class="row">
                  @if (is_array($permissions) && in_array('Video', $permissions))
                    <div class="col-lg-3">
                      <div class="form-group">
                        <label>{{ __('Video Link') }} </label>
                        <input type="text" class="form-control" name="video_url" placeholder="Enter Your video url">
                      </div>
                    </div>
                  @endif

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Mail') }} *</label>
                      <input type="text" class="form-control" name="mail" placeholder="Enter Contact Mail">
                    </div>
                  </div>
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Phone') }} *</label>
                      <input type="text" class="form-control" name="phone" placeholder="Enter Phone Number">
                    </div>
                  </div>
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Hide/Show') }} </label>
                      <select name="visibility" id="visibility" class="form-control">
                        <option value="1">{{ __('Show') }}
                        </option>
                        <option selected value="0">{{ __('Hide') }}
                        </option>
                      </select>
                    </div>
                  </div>
                  @php
                    $approve = App\Models\BasicSettings\Basic::select('admin_approve_status')->first();
                    $status = $approve->admin_approve_status;
                  @endphp
                  <input type="hidden" value="{{ $status }}"name="status" id="status">

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Latitude') }} *</label>
                      <input type="text" class="form-control" name="latitude" placeholder="Enter Latitude">
                      <p class="text-warning">
                        {{ __('The Latitude must be between -90 and 90. Ex:49.43453') }}</p>
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Longitude') }} *</label>
                      <input type="text" class="form-control" name="longitude" placeholder="Enter Longitude">
                      <p class="text-warning">
                        {{ __('The Longitude must be between -180 and 180. Ex:149.91553') }}</p>
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Min Price') }}({{ $settings->base_currency_text }})*</label>
                      <input type="text" class="form-control" name="min_price" placeholder="Enter Min Price">
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Max Price') }}({{ $settings->base_currency_text }})*</label>
                      <input type="text" class="form-control" name="max_price" placeholder="Enter Max Price">
                    </div>
                  </div>

                  <input type="hidden" name="vendor_id" id="vendor_id"
                    value="{{ Auth::guard('vendor')->user()->id }}">
                  <input type="hidden" name="can_listing_add" value="{{ $can_listing_add }}">
                </div>

                <div id="accordion" class="mt-3">
                  @foreach ($languages as $language)
                    <div class="version">
                      <div class="version-header" id="heading{{ $language->id }}">
                        <h5 class="mb-0">
                          <button type="button" class="btn btn-link" data-toggle="collapse"
                            data-target="#collapse{{ $language->id }}"
                            aria-expanded="{{ $language->is_default == 1 ? 'true' : 'false' }}"
                            aria-controls="collapse{{ $language->id }}">
                            {{ $language->name . __(' Language') }} {{ $language->is_default == 1 ? '(Default)' : '' }}
                          </button>
                        </h5>
                      </div>

                      <div id="collapse{{ $language->id }}"
                        class="collapse {{ $language->is_default == 1 ? 'show' : '' }}"
                        aria-labelledby="heading{{ $language->id }}" data-parent="#accordion">
                        <div class="version-body {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                          <div class="row">
                            <div class="col-lg-6">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Title') }} *</label>
                                <input type="text" class="form-control" name="{{ $language->code }}_title"
                                  placeholder="Enter Title">
                              </div>
                            </div>
                            <div class="col-lg-3">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Address') . '*' }}</label>
                                <input type="text" name="{{ $language->code }}_address" class="form-control"
                                  placeholder="Enter Address">
                              </div>
                            </div>

                            <div class="col-lg-3">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                @php
                                  $categories = App\Models\ListingCategory::where('language_id', $language->id)
                                      ->where('status', 1)
                                      ->get();
                                @endphp

                                <label>{{ __('Category') }} *</label>
                                <select name="{{ $language->code }}_category_id"
                                  class="form-control js-example-basic-single2">
                                  <option selected disabled>{{ __('Select a Category') }}</option>

                                  @foreach ($categories as $category)
                                    <option value="{{ $category->id }}">{{ $category->name }}</option>
                                  @endforeach
                                </select>
                              </div>
                            </div>
                            @php
                              $Countries = App\Models\Location\Country::where('language_id', $language->id)->get();
                              $totalCountry = $Countries->count();
                            @endphp

                            @if ($totalCountry > 0)
                              <div class="col-lg-3">
                                <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">

                                  <label>{{ __('Country*') }}</label>
                                  <select name="{{ $language->code }}_country_id"
                                    class="form-control js-example-basic-single3" data-code="{{ $language->code }}">
                                    <option selected disabled>{{ __('Select Country') }}</option>
                                    @foreach ($Countries as $Country)
                                      <option value="{{ $Country->id }}">{{ $Country->name }}</option>
                                    @endforeach
                                  </select>
                                </div>
                              </div>
                            @endif

                            @php
                              $States = App\Models\Location\State::where('language_id', $language->id)->get();
                              $totalState = $States->count();
                            @endphp

                            @if ($totalState > 0)
                              <div class="col-lg-3 {{ $language->code }}_hide_state">
                                <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">

                                  <label>{{ __('State*') }} </label>
                                  <select name="{{ $language->code }}_state_id"
                                    class="form-control js-example-basic-single4 {{ $language->code }}_country_state_id"data-code="{{ $language->code }}">
                                    <option selected disabled>{{ __('Select State') }}</option>

                                    @foreach ($States as $State)
                                      <option value="{{ $State->id }}">{{ $State->name }}</option>
                                    @endforeach
                                  </select>
                                </div>
                              </div>
                            @endif

                            @php
                              $cities = App\Models\Location\City::where('language_id', $language->id)->get();
                              $totalCity = $cities->count();
                            @endphp

                            <div class="col-lg-3">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">

                                <label>{{ __('City') }} *</label>
                                <select name="{{ $language->code }}_city_id"
                                  class="form-control js-example-basic-single5 {{ $language->code }}_state_city_id">
                                  <option selected disabled>{{ __('Select a City') }}</option>

                                  @foreach ($cities as $City)
                                    <option value="{{ $City->id }}">{{ $City->name }}</option>
                                  @endforeach
                                </select>
                              </div>
                            </div>

                            @if (is_array($permissions) && in_array('Amenities', $permissions))
                              <div class="col-lg-12">
                                <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                  @php
                                    $aminities = App\Models\Aminite::where('language_id', $language->id)->get();
                                  @endphp

                                  <label>{{ __('Select Amenities') }} *</label>
                                  <div class="dropdown-content" id="checkboxes">
                                    @foreach ($aminities as $amenity)
                                      <input type="checkbox" id="{{ $amenity->id }}"
                                        name="{{ $language->code }}_aminities[]" value="{{ $amenity->id }}">
                                      <label
                                        class="amenities-label {{ $language->direction == 1 ? 'ml-2 mr-0' : 'mr-2' }}"
                                        for="{{ $amenity->id }}">{{ $amenity->title }}</label>
                                    @endforeach
                                  </div>
                                </div>
                              </div>
                            @endif

                          </div>

                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Description') }} *</label>
                                <textarea id="{{ $language->code }}_description" class="form-control summernote"
                                  name="{{ $language->code }}_description" data-height="300"></textarea>
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Meta Keywords') }}</label>
                                <input class="form-control" name="{{ $language->code }}_meta_keyword"
                                  placeholder="Enter Meta Keywords" data-role="tagsinput">
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Meta Description') }}</label>
                                <textarea class="form-control" name="{{ $language->code }}_meta_description" rows="5"
                                  placeholder="Enter Meta Description"></textarea>
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
              <button type="submit" form="listingForm" data-can_listing_add="{{ $can_listing_add }}"
                class="btn btn-success">
                {{ __('Save') }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection

@section('script')
  <script>
    'use strict';
    var storeUrl = "{{ route('vendor.listing.imagesstore') }}";
    var removeUrl = "{{ route('vendor.listing.imagermv') }}";
    var getStateUrl = "{{ route('vendor.listing_management.get-state') }}";
    var getCityUrl = "{{ route('vendor.listing_management.get-city') }}";
    var galleryImages = {{ $numberoffImages }};
    var languages = {!! json_encode($languages) !!};
    const baseURL = "{{ url('/') }}";
  </script>

  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-partial.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
@endsection
