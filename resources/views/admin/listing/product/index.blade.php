@extends('admin.layout')

@includeIf('admin.partials.rtl_style')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Products') }}</h4>
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
        <a href="#">
          @if (!empty($dd))
            {{ strlen(@$dd->title) > 30 ? mb_substr(@$dd->title, 0, 30, 'utf-8') . '...' : @$dd->title }}
          @endif
        </a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Products') }}</a>
      </li>
    </ul>
  </div>

  @php

    $vendor_id = App\Models\Listing\Listing::where('id', $listing_id)->pluck('vendor_id')->first();

    if ($vendor_id != 0) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendor_id);

        $dowgraded = App\Http\Helpers\VendorPermissionHelper::packagesDowngraded($vendor_id);
        $listingCanAdd = packageTotalListing($vendor_id) - vendorTotalListing($vendor_id);
    }

  @endphp

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row">
            <div class="col-lg-4">
              <div class="card-title d-inline-block"> {{ __('Products') }}
              </div>
            </div>
            <div class="col-lg-2">
              @includeIf('admin.partials.languages')
            </div>

            <div class="col-lg-6 mt-2 mt-lg-0">
              <div class="btn-groups gap-10 justify-content-lg-end">
                @if ($title)
                  <a class="btn btn-success btn-sm d-inline-block"
                    href="{{ route('frontend.listing.details', ['slug' => @$title->slug, 'id' => @$title->listing_id]) }}"
                    target="_blank">
                    <span class="btn-label">
                      <i class="fas fa-eye"></i>
                    </span>
                    {{ __('Preview') }}
                  </a>
                @endif

                <a class="btn btn-info btn-sm" href="{{ route('admin.listing_management.listing') }}">
                  <span class="btn-label">
                    <i class="fas fa-backward"></i>
                  </span>
                  {{ __('Back') }}
                </a>

                @if ($vendor_id != 0)
                  <button type="button" class="btn btn-primary btn-sm" id="aa" data-toggle="modal"
                    data-target="#adminCheckLimitModal">

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

                <a href="{{ route('admin.listing_management.create_Product', ['id' => $listing_id]) }}"
                  class="btn btn-primary btn-sm"><i class="fas fa-plus">
                  </i> {{ __('Add Product') }}
                </a>

                <button class="btn btn-danger btn-sm d-none bulk-delete"
                  data-href="{{ route('admin.listing_management.listing.product.bulk_delete_product') }}"><i
                    class="flaticon-interface-5"></i>
                  {{ __('Delete') }}
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-12">
              @if (count($listing_products) == 0)
                <h3 class="text-center">{{ __('NO PRODUCT FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3">
                    <thead>
                      <tr>
                        <th scope="col">
                          <input type="checkbox" class="bulk-check" data-val="all">
                        </th>
                        <th scope="col">{{ __('Title') }}</th>
                        <th scope="col">{{ __('Status') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($listing_products as $product)
                        <tr>
                          <td>
                            <input type="checkbox" class="bulk-check" data-val="{{ $product->id }}">
                          </td>
                          <td>
                            @php
                              $listing_product_content = App\Models\Listing\ListingProductContent::where(
                                  'listing_product_id',
                                  $product->id,
                              )
                                  ->where('language_id', $language->id)
                                  ->first();
                            @endphp
                            @if (!empty($listing_product_content))
                              {{ strlen(@$listing_product_content->title) > 50 ? mb_substr(@$listing_product_content->title, 0, 50, 'utf-8') . '...' : @$listing_product_content->title }}
                            @else
                              --
                            @endif
                          </td>

                          <td>
                            <form id="statusForm{{ $product->id }}" class="d-inline-block"
                              action="{{ route('admin.listing_management.listing.update_product_status') }}"
                              method="post">
                              @csrf
                              <input type="hidden" name="productId" value="{{ $product->id }}">

                              <select
                                class="form-control {{ $product->status == 1 ? 'bg-success' : 'bg-danger' }} form-control-sm"
                                name="status"
                                onchange="document.getElementById('statusForm{{ $product->id }}').submit();">
                                <option value="1" {{ $product->status == 1 ? 'selected' : '' }}>
                                  {{ __('Active') }}
                                </option>
                                <option value="0" {{ $product->status == 0 ? 'selected' : '' }}>
                                  {{ __('Inactive') }}
                                </option>
                              </select>
                            </form>
                          </td>

                          <td>
                            <div class="dropdown">
                              <button class="btn btn-secondary btn-sm dropdown-toggle" type="button"
                                id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                {{ __('Select') }}
                              </button>

                              <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">

                                <a href="{{ route('admin.listing_management.edit_product', ['id' => $product->id]) }}"
                                  class="dropdown-item">
                                  {{ __('Edit') }}
                                </a>

                                <form class="deleteForm d-block"
                                  action="{{ route('admin.listing_management.product.delete_product', ['id' => $product->id]) }}"
                                  method="post">
                                  @csrf
                                  <button type="submit" class="deleteBtn">
                                    {{ __('Delete') }}
                                  </button>
                                </form>
                              </div>
                            </div>
                          </td>
                        </tr>
                      @endforeach
                    </tbody>
                  </table>
                </div>
              @endif
            </div>
          </div>
        </div>

        <div class="card-footer">
          <div class="center">
            {{ $listing_products->appends([
                    'language' => request()->input('language'),
                ])->links() }}
          </div>
        </div>
      </div>
    </div>
  </div>
  @includeIf('admin.listing.check-limit')
@endsection
