@extends('vendors.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Edit Product') }}</h4>
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
        <a
          href="{{ route('vendor.listing_management.listing', ['language' => $defaultLang->code]) }}">{{ __('Manage Listings') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Products') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Edit Product') }}</a>
      </li>
    </ul>
  </div>

  @php
    $vendor_id = Auth::guard('vendor')->user()->id;

    if ($vendor_id) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendor_id);

        if ($current_package != '[]') {
            $numberoffImages = $current_package->number_of_images_per_products;
        } else {
            $numberoffImages = 0;
        }
    }
  @endphp

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Edit Product') }}</div>
          <a class="btn btn-info btn-sm float-right d-inline-block"
            href="{{ route('vendor.listing_management.listing.products', ['id' => $product->listing_id, 'language' => $defaultLang->code]) }}">
            <span class="btn-label">
              <i class="fas fa-backward"></i>
            </span>
            {{ __('Back') }}
          </a>
          @php
            $dContent = App\Models\Listing\ListingContent::where('listing_id', $product->listing_id)
                ->where('language_id', $defaultLang->id)
                ->first();
            $slug = !empty($dContent) ? $dContent->slug : '';
          @endphp
          @if ($dContent)
            <a class="btn btn-success btn-sm float-right mr-1 d-inline-block"
              href="{{ route('frontend.listing.details', ['slug' => $slug, 'id' => $product->listing_id]) }}"
              target="_blank">
              <span class="btn-label">
                <i class="fas fa-eye"></i>
              </span>
              {{ __('Preview') }}
            </a>
          @endif
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-10 offset-lg-1">
              <div class="alert alert-danger pb-1 dis-none" id="productErrors">
                <ul></ul>
              </div>
              <div class="col-lg-12">
                <label for="" class="mb-2"><strong>{{ __('Gallery Images') . '*' }}</strong></label>
                <div class="row">
                  <div class="col-12">
                    <table class="table table-striped" id="imgtable">
                      @foreach ($product->galleries as $item)
                        <tr class="trdb table-row" id="trdb{{ $item->id }}">
                          <td>
                            <div class="">
                              <img class="thumb-preview wf-150"
                                src="{{ asset('assets/img/listing/product-gallery/' . $item->image) }}" alt="Ad Image">
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
                <form action="{{ route('vendor.listing.product.imagesstore') }}" id="my-dropzone"
                  enctype="multipart/formdata" class="dropzone create">
                  @csrf
                  <div class="fallback">
                    <input name="file" type="file" multiple />
                  </div>
                  <input type="hidden" value="{{ $product->id }}" name="product_id">
                  <input type="hidden" value="{{ $product->listing_id }}" name="listing_id">
                </form>
                <p class="em text-danger mb-0" id="errslider_images"></p>
                <p class="text-warning">
                  {{ __('You can upload maximum ' . $current_package->number_of_images_per_products . ' images under one product') }}
              </div>

              <form id="productForm" action="{{ route('vendor.listing_management.update_product', $product->id) }}"
                method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="product_id" value="{{ $product->id }}">
                <input type="hidden" name="listing_id" value="{{ $product->listing_id }}">
                <input type="hidden"name="vendor_id" value="{{ $vendor_id }}">
                <div class="row">
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label for="">{{ __('Featured Image') . '*' }}</label>
                      <br>
                      <div class="thumb-preview">
                        <img
                          src="{{ $product->feature_image ? asset('assets/img/listing/product/' . $product->feature_image) : asset('assets/admin/img/noimage.jpg') }}"
                          alt="..." class="uploaded-img">
                      </div>
                      <div class="mt-3">
                        <div role="button" class="btn btn-primary btn-sm upload-btn">
                          {{ __('Choose Image') }}
                          <input type="file" class="img-input" name="thumbnail">
                        </div>
                      </div>
                    </div>
                  </div>

                </div>
                <div class="row">
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Status') }} *</label>
                      <select name="status" id="" class="form-control">
                        <option {{ $product->status == 1 ? 'selected' : '' }} value="1">{{ __('Active') }}
                        </option>
                        <option {{ $product->status == 0 ? 'selected' : '' }} value="0">{{ __('Inactive') }}
                        </option>
                      </select>
                    </div>
                  </div>

                  @php $currencyText = $currencyInfo->base_currency_text; @endphp

                  <div class="col-lg-6">
                    <div class="form-group">
                      <label>{{ __('Current Price') . '* (' . $currencyText . ')' }}</label>
                      <input type="number" step="0.01" class="form-control" name="current_price"
                        placeholder="Enter Product Current Price"value="{{ $product->current_price }}">
                    </div>
                  </div>

                  <div class="col-lg-6">
                    <div class="form-group">
                      <label>{{ __('Previous Price') . ' (' . $currencyText . ')' }}</label>
                      <input type="number" step="0.01" class="form-control" name="previous_price"
                        placeholder="Enter Product Previous Price"value="{{ $product->previous_price }}">
                    </div>
                  </div>
                </div>

                <div id="accordion" class="mt-3">
                  @foreach ($languages as $language)
                    @php
                      $listingContent = App\Models\Listing\ListingProductContent::where(
                          'listing_product_id',
                          $product->id,
                      )
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
                        <div class="version-body">
                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Title*') }}</label>
                                <input type="text" class="form-control" name="{{ $language->code }}_title"
                                  placeholder="Enter Title"
                                  value="{{ $listingContent ? $listingContent->title : '' }}">
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Description') }} *</label>
                                <textarea class="form-control summernote" id="{{ $language->code }}_content" name="{{ $language->code }}_content"
                                  data-height="300">{{ @$listingContent->content }}</textarea>
                              </div>
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
              <button type="submit" form="productForm" class="btn btn-success">
                {{ __('Update') }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection

@section('script')
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
  <script src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
@endsection

@section('variables')
  <script>
    "use strict";

    var storeUrl = "{{ route('vendor.listing.product.imagesstore') }}";
    var removeUrl = "{{ route('vendor.listing.product.imagermv') }}";
    var rmvdbUrl = "{{ route('vendor.listing.product.imgdbrmv') }}";
    var galleryImages = {{ $current_package->number_of_images_per_products - count($product->galleries) }};
  </script>
@endsection
