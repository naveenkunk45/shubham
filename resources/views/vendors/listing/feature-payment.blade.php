<div class="modal fade" class="featurePaymentModal" id="featurePaymentModal_{{ $listing->id }}" tabindex="-1"
  role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Send Request') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="payment-form_{{ $listing->id }}" class="modal-form"
          action="{{ route('vendor.listing_management.listing.purchase_feature') }}" method="post"
          enctype="multipart/form-data">
          @csrf
          <input type="hidden" class="form-control" name="listing_id" id="{{ $listing->id }}"
            value="{{ $listing->id }}">

          <div class="form-group p-0 mt-2">
            <label for="form-check">{{ __('Promotion List') }}*</label>
            @foreach ($charges as $index => $charge)
              <ul class="list-group list-group-bordered mb-2">
                <li class="list-group-item">
                  <div class="form-check p-0">
                    <label class="form-check-label mb-0" for="radio_{{ $charge->id }}_{{ $listing->id }}">
                      <input class="form-check-input ml-0" type="radio" name="charge"
                        id="radio_{{ $charge->id }}_{{ $listing->id }}" value="{{ $charge->id }}"
                        {{ $index === 0 ? 'checked' : '' }}>
                      {{ $charge->days }} {{ __('Days For') }}
                      {{ symbolPrice($charge->price) }}
                    </label>
                  </div>
                </li>
              </ul>
            @endforeach

            @if (Session::has('select_days_' . $listing->id))
              <p class="mt-2 text-danger">{{ Session::get('select_days_' . $listing->id) }}</p>
            @endif

            <p id="err_charge_{{ $listing->id }}" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div class="form-group p-0 mt-2">
            <label>{{ __('Payment Method') }}*</label>
            <div class="mb-30">

              <select name="gateway" id="gateway_{{ $listing->id }}"
                class="nice-select form-control payment-gateway"data-listing_id="{{ $listing->id }}">
                <option value="" selected="" disabled>{{ __('Choose a Payment Method') }}</option>
                @foreach ($onlineGateways as $onlineGateway)
                  <option @selected(old('gateway') == $onlineGateway->keyword) value="{{ $onlineGateway->keyword }}">
                    {{ __($onlineGateway->name) }}</option>
                @endforeach

                @if (count($offline_gateways) > 0)
                  @foreach ($offline_gateways as $offlineGateway)
                    <option @selected(old('gateway') == $offlineGateway->id) value="{{ $offlineGateway->id }}">
                      {{ __($offlineGateway->name) }}</option>
                  @endforeach
                @endif

              </select>

              @if (Session::has('select_payment_' . $listing->id))
                <p class="mt-2 text-danger">{{ Session::get('select_payment_' . $listing->id) }}</p>
              @endif

              <p id="err_gateway_{{ $listing->id }}" class="mt-2 mb-0 text-danger em"></p>
            </div>

            <div id="stripe-element_{{ $listing->id }}" class="mb-2">
              <!-- A Stripe Element will be inserted here. -->
            </div>
            <!-- Used to display form errors -->
            <div id="stripe-errors" class="pb-2" role="alert"></div>
            @php
              $display = 'none';
            @endphp
            {{-- START: Authorize.net Card Details Form --}}
            <div class="row gateway-details pt-3" id="tab-anet_{{ $listing->id }}"
              style="display: {{ $display }};">
              <div class="col-lg-6">
                <div class="form-group mb-3">
                  <input class="form-control" type="text" id="anetCardNumber_{{ $listing->id }}"
                    placeholder="Card Number" disabled />
                </div>
              </div>
              <div class="col-lg-6 mb-3">
                <div class="form-group">
                  <input class="form-control" type="text" id="anetExpMonth_{{ $listing->id }}"
                    placeholder="Expire Month" disabled />
                </div>
              </div>
              <div class="col-lg-6 ">
                <div class="form-group">
                  <input class="form-control" type="text" id="anetExpYear_{{ $listing->id }}"
                    placeholder="Expire Year" disabled />
                </div>
              </div>
              <div class="col-lg-6 ">
                <div class="form-group">
                  <input class="form-control" type="text" id="anetCardCode_{{ $listing->id }}"
                    placeholder="Card Code" disabled />
                </div>
              </div>
              <input type="hidden" name="opaqueDataValue" id="opaqueDataValue" disabled />
              <input type="hidden" name="opaqueDataDescriptor" id="opaqueDataDescriptor" disabled />
              <ul id="anetErrors_{{ $listing->id }}" style="display:{{ $display }};"></ul>
            </div>
            {{-- END: Authorize.net Card Details Form --}}

            @foreach ($offline_gateways as $offlineGateway)
              <div
                class="@if ($errors->has('attachment_' . $listing->id) && request()->session()->get('gatewayId') == $offlineGateway->id) d-block @else d-none @endif offline-gateway-info_{{ $listing->id }}"
                id="{{ 'offline-gateway-' . $offlineGateway->id }}">
                @if (!is_null($offlineGateway->short_description))
                  <div class="form-group">
                    <label>{{ __('Description') }}</label>
                    <p>{{ $offlineGateway->short_description }}</p>
                  </div>
                @endif

                @if (!is_null($offlineGateway->instructions))
                  <div class="form-group">
                    <label>{{ __('Instructions') }}</label>
                    {!! replaceBaseUrl($offlineGateway->instructions, 'summernote') !!}
                  </div>
                @endif

                @if ($offlineGateway->has_attachment == 1)
                  <div class="form-group mb-4">
                    <label>{{ __('Attachment') . '*' }}</label>
                    <br>
                    <input type="file" name="attachment_{{ $listing->id }}">
                    @error('attachment_' . $listing->id)
                      <p class="text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif

              </div>
            @endforeach
            <button class="btn btn-lg btn-primary radius-md w-100 featured" type="submit">{{ __('Submit') }}
            </button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        </button>
      </div>
    </div>
  </div>
</div>
