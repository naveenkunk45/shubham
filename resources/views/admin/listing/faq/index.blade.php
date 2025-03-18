@extends('admin.layout')

{{-- this style will be applied when the direction of language is right-to-left --}}
@includeIf('admin.partials.rtl-style')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('FAQ Management') }}</h4>
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
        <a href="{{ route('admin.listing_management.listing') }}">{{ __('Listing Mangement') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a
          href="#">{{ strlen(@$title->title) > 30 ? mb_substr(@$title->title, 0, 30, 'utf-8') . '...' : @$title->title }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('FAQ Management') }}</a>
      </li>
    </ul>
  </div>
  @php

    $vendor_id = App\Models\Listing\Listing::where('id', $listing_id)->pluck('vendor_id')->first();

    if ($vendor_id != 0) {
        $dowgraded = App\Http\Helpers\VendorPermissionHelper::packagesDowngraded($vendor_id);
        $listingCanAdd = packageTotalListing($vendor_id) - vendorTotalListing($vendor_id);
    }

  @endphp

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row">
            <div class="col-lg-3">
              <div class="card-title d-inline-block">{{ __('FAQs') }}</div>
            </div>

            <div class="col-lg-3">
              @includeIf('admin.partials.languages')
            </div>

            <div class="col-lg-6 mt-2 mt-lg-0">
              <div class="row justify-content-end gutters-2">
                <div class="col-6 col-sm-3 col-lg-4 col-xl-2 mb-2">
                  <button class="btn btn-danger btn-sm w-100 d-none bulk-delete"
                    data-href="{{ route('admin.listing_management.listing.bulk_delete_faq') }}">
                    <i class="fas fa-trash-alt"></i> </i> {{ __('Delete') }}
                  </button>
                </div>
                @if ($vendor_id != 0)
                  <div class="col-6 col-sm-3 col-lg-4 col-xl-2 mb-2">
                    <button type="button" class="btn btn-primary btn-sm w-100" id="aa" data-toggle="modal"
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
                  </div>
                @endif
                <div class="col-6 col-sm-3 col-lg-4 col-xl-2 mb-2">
                  <a href="#" data-toggle="modal" data-target="#createModal" class="btn btn-primary btn-sm w-100"><i
                      class="fas fa-plus"></i>
                    {{ __('Add') }}</a>
                </div>
                @if ($slug)
                  <div class="col-6 col-sm-3 col-lg-4 col-xl-2 mb-2">
                    <a href="{{ route('frontend.listing.details', ['slug' => $slug, 'id' => $listing_id]) }}"target="_blank"
                      class="btn btn-success btn-sm w-100"><i class="fas fa-eye"></i>
                      {{ __('Preview') }}</a>
                  </div>
                @endif
                <div class="col-6 col-sm-3 col-lg-4 col-xl-2 mb-2">
                  <a href="{{ route('admin.listing_management.listing') }}" class="btn btn-info btn-sm w-100"><i
                      class="fas fa-backward"></i>
                    {{ __('Back') }}</a>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-12">
              @if (count($faqs) == 0)
                <h3 class="text-center">{{ __('NO FAQ FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3" id="basic-datatables">
                    <thead>
                      <tr>
                        <th scope="col">
                          <input type="checkbox" class="bulk-check" data-val="all">
                        </th>
                        <th scope="col">{{ __('Question') }}</th>
                        <th scope="col">{{ __('Serial Number') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($faqs as $faq)
                        <tr>
                          <td>
                            <input type="checkbox" class="bulk-check" data-val="{{ $faq->id }}">
                          </td>
                          <td>
                            {{ strlen($faq->question) > 50 ? mb_substr($faq->question, 0, 50, 'UTF-8') . '...' : $faq->question }}
                          </td>
                          <td>{{ $faq->serial_number }}</td>
                          <td>
                            <a class="btn btn-secondary  mt-1 btn-sm mr-1 editBtn" href="#" data-toggle="modal"
                              data-target="#editModal" data-id="{{ $faq->id }}"
                              data-question="{{ $faq->question }}" data-answer="{{ $faq->answer }}"
                              data-serial_number="{{ $faq->serial_number }}">
                              <span class="btn-label">
                                <i class="fas fa-edit"></i>
                              </span>
                            </a>

                            <form class="deleteForm d-inline-block"
                              action="{{ route('admin.listing_management.listing.delete_faq', ['id' => $faq->id]) }}"
                              method="post">
                              @csrf
                              <button type="submit" class="btn btn-danger mt-1 btn-sm deleteBtn">
                                <span class="btn-label">
                                  <i class="fas fa-trash"></i>
                                </span>
                              </button>
                            </form>
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
        <div class="card-footer"></div>
      </div>
    </div>
  </div>

  {{-- create modal --}}
  @include('admin.listing.faq.create')

  {{-- edit modal --}}
  @include('admin.listing.faq.edit')
  {{-- Check Limit modal --}}
  @includeIf('admin.listing.check-limit')
@endsection
