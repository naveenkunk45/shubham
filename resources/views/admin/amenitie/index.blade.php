@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Amenities') }}</h4>
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
        <a href="#">{{ __('Listing Specifications') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Amenities') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">

    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row align-items-center">
            <div class="col-lg-4">
              <div class="card-title">{{ __('Amenities') }}</div>
            </div>

            <div class="col-sm-6 col-lg-3">
              @includeIf('admin.partials.languages')
            </div>

            <div class="col-sm-6 col-lg-4 offset-lg-1 mt-2 mt-lg-0">
              <div class="text-right">
                <a href="#" data-toggle="modal" data-target="#createModal" class="btn btn-primary btn-sm"><i
                    class="fas fa-plus"></i>
                  {{ __('Add') }}</a>

                <button class="btn btn-danger btn-sm ml-2 d-none bulk-delete"
                  data-href="{{ route('admin.listing_specification.bulk_delete_aminite') }}">
                  <i class="flaticon-interface-5"></i> {{ __('Delete') }}
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col">
              @if (count($aminites) == 0)
                <h3 class="text-center mt-2">{{ __('NO AMENITIE FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3" id="basic-datatables">
                    <thead>
                      <tr>
                        <th scope="col">
                          <input type="checkbox" class="bulk-check" data-val="all">
                        </th>
                        <th scope="col">{{ __('Title') }}</th>
                        <th scope="col">{{ __('Icon') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($aminites as $amenitie)
                        <tr>
                          <td>
                            <input type="checkbox" class="bulk-check" data-val="{{ $amenitie->id }}">
                          </td>
                          <td>
                            {{ strlen($amenitie->title) > 20 ? mb_substr($amenitie->title, 0, 20, 'UTF-8') . '...' : $amenitie->title }}
                          </td>
                          <td><i class="{{ $amenitie->icon }}"></i></td>
                          <td>
                            <a class="btn btn-secondary btn-sm mr-1  mt-1 editBtn" href="#" data-toggle="modal"
                              data-target="#editModal" data-id="{{ $amenitie->id }}"
                              data-icon="{{ $amenitie->icon }}"data-language_id="{{ $amenitie->language_id }}"
                              data-amount="{{ $amenitie->amount }}" data-title="{{ $amenitie->title }}">
                              <span class="btn-label">
                                <i class="fas fa-edit"></i>
                              </span>
                            </a>

                            <form class="deleteForm d-inline-block"
                              action="{{ route('admin.listing_specification.delete_aminite', ['id' => $amenitie->id]) }}"
                              method="post">
                              @csrf
                              <button type="submit" class="btn btn-danger btn-sm  mt-1 deleteBtn">
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
  @include('admin.amenitie.create')

  {{-- edit modal --}}
  @include('admin.amenitie.edit')
@endsection
