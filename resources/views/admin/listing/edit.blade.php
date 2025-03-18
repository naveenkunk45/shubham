@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Edit Listing') }}</h4>
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
        <a href="#">{{ __('Edit Listing') }}</a>
      </li>
    </ul>
  </div>

  @php
    $vendor_id = $listing->vendor_id;
    if ($listing->vendor_id == 0) {
        $permissions = [
            'Listing Enquiry Form',
            'Video',
            'Amenities',
            'Feature',
            'Social Links',
            'FAQ',
            'Business Hours',
            'Products',
            'Product Enquiry Form',
            'Messenger',
            'WhatsApp',
            'Telegram',
            'Tawk.To',
        ];
        $numberoffImages = 99999999;
    } else {
        $vendorId = $listing->vendor_id;
        if ($vendorId) {
            $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

            $dowgraded = App\Http\Helpers\VendorPermissionHelper::packagesDowngraded($vendor_id);
            $listingCanAdd = packageTotalListing($vendor_id) - vendorTotalListing($vendor_id);

            if (!empty($current_package) && !empty($current_package->features)) {
                $permissions = json_decode($current_package->features, true);
            } else {
                $permissions = null;
            }
            if ($current_package != '[]') {
                $numberoffImages = $current_package->number_of_images_per_listing;
            } else {
                $numberoffImages = 0;
            }
        } else {
            $permissions = null;
            $numberoffImages = 0;
        }
    }

  @endphp

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Edit Listing') }}</div>
          <a class="btn btn-info btn-sm float-right d-inline-block"
            href="{{ route('admin.listing_management.listing', ['language' => $defaultLang->code]) }}">
            <span class="btn-label">
              <i class="fas fa-backward"></i>
            </span>
            {{ __('Back') }}
          </a>
          @php
            $dContent = App\Models\Listing\ListingContent::where('listing_id', $listing->id)
                ->where('language_id', $defaultLang->id)
                ->first();
            $slug = !empty($dContent) ? $dContent->slug : '';
          @endphp
          @if ($dContent)
            <a class="btn btn-success btn-sm float-right mr-1 d-inline-block"
              href="{{ route('frontend.listing.details', ['slug' => $slug, 'id' => $listing->id]) }}" target="_blank">
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
            <div class="col-lg-10 offset-lg-1">
              <div class="alert alert-danger pb-1 dis-none" id="listingErrors">
                <ul></ul>
              </div>
              <div class="col-lg-12">
                <label for="" class="mb-2"><strong>{{ __('Gallery Images') . '*' }}</strong></label>
                <div class="row">
                  <div class="col-12">
                    <table class="table table-striped" id="imgtable">
                      @foreach ($listing->galleries as $item)
                        <tr class="trdb table-row" id="trdb{{ $item->id }}">
                          <td>
                            <div class="">
                              <img class="thumb-preview wf-150"
                                src="{{ asset('assets/img/listing-gallery/' . $item->image) }}" alt="Ad Image">
                            </div>
                          </td>
                          <td>
                            <i class="fa fa-times rmvbtndb" data-indb="{{ $item->id }}"></i>
                          </td>
                        </tr>
                      @endforeach
                    </table>
                  </div>
                </div>
                <form action="{{ route('admin.listing.imagesstore') }}" id="my-dropzone" enctype="multipart/formdata"
                  class="dropzone create">
                  @csrf
                  <div class="fallback">
                    <input name="file" type="file" multiple />
                  </div>
                  <input type="hidden" value="{{ $listing->id }}" name="listing_id">
                </form>
                <p class="em text-danger mb-0" id="errslider_images"></p>
              </div>

              <form id="listingForm" action="{{ route('admin.listing_management.update_listing', $listing->id) }}"
                method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="listing_id" value="{{ $listing->id }}">
                <div class="row">
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label for="">{{ __('Featured Image') . '*' }}</label>
                      <br>
                      <div class="thumb-preview">
                        <img
                          src="{{ $listing->feature_image ? asset('assets/img/listing/' . $listing->feature_image) : asset('assets/admin/img/noimage.jpg') }}"
                          alt="..." class="uploaded-img">
                      </div>
                      <div class="mt-3">
                        <div role="button" class="btn btn-primary btn-sm upload-btn">
                          {{ __('Choose Image') }}
                          <input type="file" class="img-input" name="thumbnail">
                        </div>
                      </div>
                      <p class="mt-2 mb-0 text-warning">{{ __('Image Size 600x400') }}</p>
                    </div>

                  </div>
                  @if (is_array($permissions) && in_array('Video', $permissions))
                    <div class="col-lg-3">
                      <div class="form-group position-relative">
                        <label for="">{{ __('Video Image') }}</label>
                        <br>
                        <div class="thumb-preview position-relative">
                          @if ($listing->video_background_image)
                            <button class="videoimagermvbtndb btn btn-remove" type="button"
                              data-indb="{{ $item->id }}">
                              <i class="fal fa-times"></i>
                            </button>
                          @endif
                          @php
                            $display = 'none';
                          @endphp
                          <img
                            src="{{ $listing->video_background_image ? asset('assets/img/listing/video/' . $listing->video_background_image) : asset('assets/img/noimage.jpg') }}"
                            alt="..." class="uploaded-img2">
                          <button class="remove-img2 btn btn-remove" type="button"
                            style="display:{{ $display }};">
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
                        <label>{{ __('Video Link') }} *</label>
                        <input type="text" class="form-control" value="{{ $listing->video_url }}" name="video_url"
                          placeholder="Enter Your Video url">
                      </div>
                    </div>
                  @endif
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Mail') }} *</label>
                      <input type="text" class="form-control" value="{{ $listing->mail }}" name="mail"
                        placeholder="Enter Your Mail">
                    </div>
                  </div>
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('phone') }} *</label>
                      <input type="text" class="form-control" value="{{ $listing->phone }}" name="phone"
                        placeholder="Enter Your Phone">
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Approve Status') }} *</label>
                      <select name="status" id="status" class="form-control">
                        <option @if ($listing->status == 1) selected @endif value="1">{{ __('Approved') }}
                        </option>
                        <option @if ($listing->status == 0) selected @endif value="0">{{ __('Pending') }}
                        </option>
                        <option @if ($listing->status == 2) selected @endif value="2">{{ __('Rejected') }}
                        </option>
                      </select>
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Hide/Show') }}</label>
                      <select name="visibility" id="visibility" class="form-control">
                        <option @if ($listing->visibility == 1) selected @endif value="1">{{ __('Show') }}
                        </option>
                        <option @if ($listing->visibility == 0) selected @endif value="0">{{ __('Hide') }}
                        </option>
                      </select>
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Latitude') }} *</label>
                      <input type="text" class="form-control" value="{{ $listing->latitude }}" name="latitude"
                        placeholder="Enter Latitude">
                      <p class="text-warning">
                        {{ __('The Latitude must be between -90 and 90. Ex:49.43453') }}</p>
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Longitude') }} *</label>
                      <input type="text" class="form-control" value="{{ $listing->longitude }}" name="longitude"
                        placeholder="Enter Longitude">
                      <p class="text-warning">
                        {{ __('The Longitude must be between -180 and 180. Ex:149.91553') }}</p>
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Min Price') }}({{ $settings->base_currency_text }})*</label>
                      <input type="text" class="form-control" name="min_price" value="{{ $listing->min_price }}"
                        placeholder="Enter Min Price">
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Max Price') }}({{ $settings->base_currency_text }})*</label>
                      <input type="text" class="form-control" name="max_price" value="{{ $listing->max_price }}"
                        placeholder="Enter Max Price">
                    </div>
                  </div>

                  <input type="hidden" name="vendor_id" id="vendor_id" value="{{ $listing->vendor_id }}">
                </div>

                <div id="accordion" class="mt-3">
                  @foreach ($languages as $language)
                    @php
                      $listingContent = App\Models\Listing\ListingContent::where('listing_id', $listing->id)
                          ->where('language_id', $language->id)
                          ->first();
                    @endphp
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
                                <label>{{ __('Title*') }}</label>
                                <input type="text" class="form-control" name="{{ $language->code }}_title"
                                  placeholder="Enter Title"
                                  value="{{ $listingContent ? $listingContent->title : '' }}">
                              </div>
                            </div>
                            <div class="col-lg-3">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Address') . '*' }} </label>
                                <input type="text" name="{{ $language->code }}_address" placeholder="Enter Address"
                                  value="{{ @$listingContent->address }}" class="form-control">
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
                                    <option @selected(@$listingContent->category_id == $category->id) value="{{ $category->id }}">
                                      {{ $category->name }}</option>
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
                                    <option selected disabled>{{ __('Select a Country') }}</option>

                                    @foreach ($Countries as $Country)
                                      <option @selected(@$listingContent->country_id == $Country->id) value="{{ $Country->id }}">
                                        {{ $Country->name }}</option>
                                    @endforeach
                                  </select>
                                </div>
                              </div>
                            @endif

                            @php
                              $States = App\Models\Location\State::where('language_id', $language->id)->get();
                              $totalState = $States->count();
                              $Stateshave = App\Models\Location\State::where([
                                  ['language_id', $language->id],
                                  ['country_id', $listingContent ? $listingContent->country_id : 0],
                              ])->get();
                              $totalStateshave = $Stateshave->count();
                            @endphp

                            @if ($totalState > 0)
                              <div
                                class="col-lg-3 {{ $language->code }}_hide_state @if ($totalStateshave == 0) d-none @endif ">
                                <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">

                                  <label>{{ __('State*') }} </label>
                                  <select name="{{ $language->code }}_state_id"
                                    class="form-control js-example-basic-single4 {{ $language->code }}_country_state_id"data-code="{{ $language->code }}">
                                    <option selected disabled>{{ __('Select a State') }}</option>

                                    @foreach ($States as $State)
                                      <option @selected(@$listingContent->state_id == $State->id) value="{{ $State->id }}">
                                        {{ $State->name }}</option>
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
                                    <option @selected(@$listingContent->city_id == $City->id) value="{{ $City->id }}">
                                      {{ $City->name }}</option>
                                  @endforeach
                                </select>
                              </div>
                            </div>
                            @if (is_array($permissions) && in_array('Amenities', $permissions))
                              <div class="col-lg-12 ">
                                <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                  @php
                                    $aminities = App\Models\Aminite::where('language_id', $language->id)->get();

                                    $hasaminitie = $listingContent ? json_decode($listingContent->aminities) : [];
                                  @endphp

                                  <label>{{ __('Select Amenities') }} *</label>
                                  <div class="dropdown-content" id="checkboxes">
                                    @if ($hasaminitie)
                                      @foreach ($aminities as $aminitie)
                                        @if (in_array($aminitie->id, $hasaminitie))
                                          <input id="{{ $aminitie->id }}" type="checkbox"
                                            data-code ="{{ $language->code }}"
                                            data-listing_id ="{{ $listing->id }}"
                                            data-language_id ="{{ $language->id }}"
                                            name="{{ $language->code }}_aminities[]" value="{{ $aminitie->id }}"
                                            checked>
                                          <label
                                            class="amenities-label {{ $language->direction == 1 ? 'ml-2 mr-0' : 'mr-2' }}"
                                            for="{{ $aminitie->id }}">{{ $aminitie->title }}</label>
                                        @else
                                          <input type="checkbox" name="{{ $language->code }}_aminities[]"
                                            value="{{ $aminitie->id }}" id="{{ $aminitie->id }}">
                                          <label
                                            class="amenities-label {{ $language->direction == 1 ? 'ml-2 mr-0' : 'mr-2' }}"
                                            for="{{ $aminitie->id }}">{{ $aminitie->title }}</label>
                                        @endif
                                      @endforeach
                                    @else
                                      <div class="dropdown-content" id="checkboxes">
                                        @foreach ($aminities as $aminitie)
                                          <input type="checkbox"id="{{ $aminitie->id }}"
                                            name="{{ $language->code }}_aminities[]" value="{{ $aminitie->id }}">
                                          <label
                                            class="amenities-label {{ $language->direction == 1 ? 'ml-2 mr-0' : 'mr-2' }}"
                                            for="{{ $aminitie->id }}">{{ $aminitie->title }}</label>
                                        @endforeach
                                      </div>
                                    @endif
                                  </div>
                                </div>
                              </div>
                            @endif

                          </div>
                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Description') }} *</label>
                                <textarea class="form-control summernote" id="{{ $language->code }}_description"
                                  name="{{ $language->code }}_description" data-height="300">{{ @$listingContent->description }}</textarea>
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Meta Keywords') }}</label>
                                <input class="form-control" name="{{ $language->code }}_meta_keyword"
                                  placeholder="Enter Meta Keywords" data-role="tagsinput"
                                  value="{{ $listingContent ? @$listingContent->meta_keyword : '' }}">
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Meta Description') }}</label>
                                <textarea class="form-control" name="{{ $language->code }}_meta_description" rows="5"
                                  placeholder="Enter Meta Description">{{ $listingContent ? @$listingContent->meta_description : '' }}</textarea>
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col">
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
              <button type="submit" form="listingForm" class="btn btn-primary">
                {{ __('Update') }}
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
    "use strict";
    var videoId = {{ $listing->id }};
    var videormvdbUrl = "{{ route('admin.listing_management.video_image.delete', ['id' => ':videoId']) }}";
    videormvdbUrl = videormvdbUrl.replace(':videoId', videoId);
    var storeUrl = "{{ route('admin.listing.imagesstore') }}";
    var removeUrl = "{{ route('admin.listing.imagermv') }}";
    var rmvdbUrl = "{{ route('admin.listing.imgdbrmv') }}";
    var getStateUrl = "{{ route('admin.listing_management.get-state') }}";
    var getCityUrl = "{{ route('admin.listing_management.get-city') }}";
    var featureRmvUrl = "{{ route('admin.listing_management.feature_delete') }}"
    var socialRmvUrl = "{{ route('admin.listing_management.social_delete') }}"
    const baseURL = "{{ url('/') }}";
    var galleryImages = {{ $numberoffImages - count($listing->galleries) }};
  </script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-partial.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
  <script src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
@endsection
