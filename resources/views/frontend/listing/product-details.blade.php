<!-- Products Modal -->
@foreach ($product_contents as $product)
  <div class="modal fade products-modal" id="productsModal_{{ $product->id }}"
    aria-labelledby="productsModal_{{ $product->id }}Label">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="productsModal_{{ $product->id }}Label">{{ $product->title }}
          </h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-lg-6">
              <div class="product-modal-gallery gallery-popup mb-40">
                <div class="swiper product-modal-single-slider">
                  <div class="swiper-wrapper">
                    @foreach ($product->galleries as $gallery)
                      <div class="swiper-slide">
                        <figure class="lazy-container ratio ratio-2-3 radius-sm">
                          <a href="{{ asset('assets/img/listing/product-gallery/' . $gallery->image) }}">
                            <img class="lazyload"
                              data-src="{{ asset('assets/img/listing/product-gallery/' . $gallery->image) }}"
                              alt="product image" />
                          </a>
                        </figure>
                      </div>
                    @endforeach

                  </div>
                  <!-- Slider navigation buttons -->
                  <div class="slider-navigation">
                    <button type="button" title="Slide prev" class="slider-btn slider-btn-prev rounded-pill"
                      id="slider-btn-prev">
                      <i class="fal fa-angle-left"></i>
                    </button>
                    <button type="button" title="Slide next" class="slider-btn slider-btn-next rounded-pill"
                      id="slider-btn-next">
                      <i class="fal fa-angle-right"></i>
                    </button>
                  </div>
                  <!-- Slider Pagination -->
                  <div class="swiper-pagination position-static mt-20" id="product-modal-single-slider-pagination">
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="product-single-details mb-40">
                <div class="product-desc">
                  <div class="tinymce-content">
                    {!! optional($product)->content !!}
                  </div>
                  <div class="product-price mt-15">
                    <span class="h5 mb-0 color-primary">{{ __('Price') }}: </span>
                    <div class="price">
                      <span class="h5 mb-0">${{ $product->current_price }}</span>
                      <span class="h6 mb-0">${{ $product->previous_price }}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          @if (is_array($permissions) && in_array('Product Enquiry Form', $permissions))
            <div class="query-form">
              <h3 class="mb-10">{{ __('Make Query') }}</h3>
              <form id="contactForm" action="{{ route('frontend.product.contact_message') }}" method="POST">
                @csrf
                <div class="row gx-xl-3">
                  <div class="col-lg-6">
                    <div class="form-group mb-15">
                      <input type="text" name="name" class="form-control" required
                        placeholder="{{ __('Name') }}*">
                    </div>
                  </div>
                  <div class="col-lg-6">
                    <div class="form-group mb-15">
                      <input type="email" name="email" class="form-control" required
                        placeholder="{{ __('Email Address') }}*">
                    </div>
                  </div>


                  <div class="col-12">
                    <div class="form-group mb-15">
                      <textarea name="message" id="message" class="form-control" cols="25" rows="6" required
                        data-error="Please enter your message" placeholder="{{ __('Message') }}*..."></textarea>
                      <div class="help-block with-errors"></div>
                    </div>
                  </div>
                  <input type="hidden" id="vendor_id" value="{{ $listing->vendor_id }}" name="vendor_id">
                  <input type="hidden" id="product_id" value="{{ $product->id }}" name="product_id">
                  <div class="col-12">
                    <div class="form-group">
                      <button type="submit"
                        class="btn btn-md btn-primary w-100 showLoader">{{ __('Submit Message') }}</button>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          @endif
        </div>
      </div>
    </div>
  </div>
@endforeach
