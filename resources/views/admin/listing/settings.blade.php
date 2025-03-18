@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Settings') }}</h4>
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
        <a href="#">{{ __('Settings') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <form action="{{ route('admin.listing_management.update_settings') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-10">
                <div class="card-title">{{ __('Update Settings') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-6 offset-lg-3">
                <div class="form-group">
                  <label>{{ __('Listing View') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="listing_view" value="1" class="selectgroup-input"
                        {{ $info->listing_view == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Gird') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="listing_view" value="0" class="selectgroup-input"
                        {{ $info->listing_view == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Map') }}</span>
                    </label>
                  </div>
                  @error('listing_view')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>
                <div class="form-group">
                  <label>{{ __('Listing Auto Approval') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="admin_approve_status" value="1" class="selectgroup-input"
                        {{ $info->admin_approve_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="admin_approve_status" value="0" class="selectgroup-input"
                        {{ $info->admin_approve_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('admin_approve_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
@endsection
