@extends('frontend.layout')

@section('pageHeading')
  {{ __('Product Details') }}
@endsection

@section('metaKeywords')
  @if (!empty($details))
    {{ $details->meta_keywords }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($details))
    {{ $details->meta_description }}
  @endif
@endsection
@section('style')
  <link rel="stylesheet" href="{{ asset('assets/front/css/shop.css') }}">
@endsection

@section('content')

  {{-- breadcrub start --}}

  @includeIf('frontend.partials.details-breadcrumb', [
      'breadcrumb' => $bgImg->breadcrumb,
      'heading' => @$details->title,
      'title' => !empty($pageHeading) ? $pageHeading->products_page_title : 'product',
  ])
  {{-- breadcrub end --}}

  <!-- Shop-single-area start -->
  <div class="shop-single-area pt-100 pb-60">
    <div class="container">
      <div class="row gx-xl-5 align-items-center">
        <div class="col-lg-6">
          <div class="shop-single-gallery mb-40" data-aos="fade-up">
            <div class="swiper shop-single-slider">
              <div class="swiper-wrapper">
                @php $sliderImages = json_decode($details->slider_images); @endphp
                @foreach ($sliderImages as $sliderImage)
                  <div class="swiper-slide">
                    <figure class="lazy-container ratio ratio-1-1">
                      <a href="{{ asset('assets/img/products/slider-images/' . $sliderImage) }}" class="lightbox-single">
                        <img class="lazyload" src="assets/images/placeholder.png"
                          data-src="{{ asset('assets/img/products/slider-images/' . $sliderImage) }}"
                          alt="product image" />
                      </a>
                    </figure>
                  </div>
                @endforeach

              </div>
              <!-- Slider navigation buttons -->
              <div class="slider-navigation">
                <button type="button" title="Slide prev" class="slider-btn slider-btn-prev radius-0">
                  <i class="fal fa-angle-left"></i>
                </button>
                <button type="button" title="Slide next" class="slider-btn slider-btn-next radius-0">
                  <i class="fal fa-angle-right"></i>
                </button>
              </div>
            </div>
            <div class="shop-thumb">
              <div class="swiper shop-thumbnails">
                <div class="swiper-wrapper">
                  @foreach ($sliderImages as $sliderImage)
                    <div class="swiper-slide">
                      <div class="thumbnail-img lazy-container ratio ratio-1-1">
                        <img class="lazyload" src="assets/images/placeholder.png"
                          data-src="{{ asset('assets/img/products/slider-images/' . $sliderImage) }}"
                          alt="product image" />
                      </div>
                    </div>
                  @endforeach

                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="product-single-details mb-40" data-aos="fade-up">
            <h3 class="product-title mb-3 mb-xl-4">{{ $details->title }}</h3>
            <div class="ratings mb-10">
              @if (!empty($details->average_rating))
                <div class="rate" style="background-image:url('{{ asset($rateStar) }}')">
                  <div class="rating-icon"
                    style="background-image: url('{{ asset($rateStar) }}'); width: {{ $details->average_rating * 20 . '%;' }}">
                  </div>
                </div>
              @endif
              <span class="ratings-total">({{ $details->average_rating }})</span>
              @php
                $totalReview = App\Models\Shop\ProductReview::Where('product_id', $details->id)->count();
              @endphp
              <span class="ratings-total">{{ $totalReview }} {{ __('Reviews') }}</span>
            </div>
            <div class="product-price mb-3 mb-xl-4">
              <h4 class="new-price color-primary mb-0">{{ symbolPrice($details->current_price) }}</h4>
              @if (!empty($details->previous_price))
                <span class="old-price h5 color-medium mb-0">{{ symbolPrice($details->previous_price) }}</span>
              @endif
            </div>
            <div class="product-desc">
              {!! $details->summary !!}
            </div>
            <div class="btn-groups mt-3 mt-xl-3">
              <div class="quantity-input">
                <div class="quantity-down">
                  <i class="fal fa-minus"></i>
                </div>
                <input type="text" value="1" name="quantity" id="product-quantity" spellcheck="false"
                  data-ms-editor="true">
                <div class="quantity-up">
                  <i class="fal fa-plus"></i>
                </div>
              </div>
              <a href="{{ route('shop.product.add_to_cart', ['id' => $details->id, 'quantity' => 'qty']) }}"
                class="btn btn-md btn-primary add-to-cart-btn" title="{{ __('Add to Cart') }}"
                target="_self">{{ __('Add to Cart') }}</a>
            </div>
            <div class="social-link style-2 mt-3 mt-xl-3">
              <a href="//www.facebook.com/sharer/sharer.php?u={{ urlencode(url()->current()) }}" target="_blank"
                title="{{ __('Facebook') }}"><i class="fab fa-facebook-f"></i></a>

              <a href="//twitter.com/intent/tweet?text=my share text&amp;url={{ urlencode(url()->current()) }}"
                target="_blank" title="{{ __('Twitter') }}"><i class="fab fa-twitter"></i></a>

              <a href="//www.linkedin.com/shareArticle?mini=true&amp;url={{ urlencode(url()->current()) }}&amp;title={{ $details->title }}"
                target="_blank" title="{{ __('Linkedin') }}"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <div class="product-category mt-3 mt-xl-3">
              {{ __('Category') . ':' }}
              <a
                href="{{ route('shop.products', ['category' => $details->categorySlug]) }}">{{ $details->categoryName }}</a>
            </div>
          </div>
        </div>
      </div>
      <div class="description mb-40" data-aos="fade-up">
        <div class="tabs-navigation tabs-navigation-2 mb-30">
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <button class="nav-link active btn-md" data-bs-toggle="tab" data-bs-target="#tab1"
                type="button">{{ __('Description') }}</button>
            </li>
            <li class="nav-item">
              <button class="nav-link btn-md" data-bs-toggle="tab" data-bs-target="#tab2"
                type="button">{{ __('Reviews') }}</button>
            </li>
          </ul>
        </div>
        <div class="tab-content">
          <div class="tab-pane fade show active" id="tab1">
            <!-- Product description -->
            <div class="product-desc">
              {!! replaceBaseUrl($details->content, 'summernote') !!}
            </div>
          </div>
          <div class="tab-pane fade" id="tab2">
            @if (count($reviews) == 0)
              <h5>{{ __('This product has no review yet') . '!' }}</h5>
            @else
              <h5 class="title mb-15">
                {{ __('All Reviews') }}
              </h5>
              <div class="reviews">
                @foreach ($reviews as $review)
                  <div class="author">
                    <div class="image">
                      @if (empty($review->user->image))
                        <img class="lazyload blur-up" src="assets/images/placeholder.png"
                          data-src="{{ asset('assets/img/user.png') }}" alt="Person Image">
                      @else
                        <img class="lazyload blur-up" src="assets/images/placeholder.png"
                          data-src="{{ asset('assets/img/users/' . $review->user->image) }}" alt="Person Image">
                      @endif
                    </div>
                    <div class="author-info">
                      <h6 class="mb-2 lh-1">{{ $review->user->username }}</h6>
                      <span class="font-sm">{{ date_format($review->created_at, 'F d, Y') }}</span>
                      <div class="ratings mb-2">
                        <div class="rate" style="background-image:url('{{ asset($rateStar) }}')">
                          <div class="rating-icon"
                            style="background-image:url('{{ asset($rateStar) }}'); width: {{ $review->rating * 20 . '%;' }}">
                          </div>
                        </div>
                      </div>
                    </div>
                @endforeach
              </div>
            @endif

            @auth('web')
              <div class="shop-review-form mt-30">
                <h5 class="title mb-10">
                  Add Review
                </h5>
                <form action="{{ route('shop.product_details.store_review', ['id' => $details->id]) }}" method="POST"
                  id="reviewSubmitForm">
                  @csrf
                  <div class="form-group mb-20">
                    <label class="mb-1">{{ __('Comment') }}</label>
                    <textarea class="form-control" placeholder="{{ __('Comment') }}" name="comment">{{ old('comment') }}</textarea>
                  </div>
                  <div class="form-group">
                    <label class="mb-1">{{ __('Rating') . '*' }}</label>
                    <ul class="rating list-unstyled mb-20">
                      <li class="review-value review-1">
                        <span class="fas fa-star" data-ratingVal="1"></span>
                      </li>
                      <li class="review-value review-2">
                        <span class="fas fa-star" data-ratingVal="2"></span>
                        <span class="fas fa-star" data-ratingVal="2"></span>
                      </li>
                      <li class="review-value review-3">
                        <span class="fas fa-star" data-ratingVal="3"></span>
                        <span class="fas fa-star" data-ratingVal="3"></span>
                        <span class="fas fa-star" data-ratingVal="3"></span>
                      </li>
                      <li class="review-value review-4">
                        <span class="fas fa-star" data-ratingVal="4"></span>
                        <span class="fas fa-star" data-ratingVal="4"></span>
                        <span class="fas fa-star" data-ratingVal="4"></span>
                        <span class="fas fa-star" data-ratingVal="4"></span>
                      </li>
                      <li class="review-value review-5">
                        <span class="fas fa-star" data-ratingVal="5"></span>
                        <span class="fas fa-star" data-ratingVal="5"></span>
                        <span class="fas fa-star" data-ratingVal="5"></span>
                        <span class="fas fa-star" data-ratingVal="5"></span>
                        <span class="fas fa-star" data-ratingVal="5"></span>
                      </li>
                    </ul>
                  </div>
                  <input type="hidden" id="rating-id" name="rating">
                  <div class="form-group">
                    <input type="submit" class="btn btn-lg btn-primary" value="{{ __('Submit') }}">
                  </div>
                </form>
              </div>
            @endauth
          </div>
        </div>

      </div>
    </div>
    @if (!empty(showAd(3)))
      <div class="text-center mt-40">
        {!! showAd(3) !!}
      </div>
    @endif

  </div>
  <!-- Shop-single-area end -->

  <!-- Related Product-area start -->
  @if (count($related_products) > 0)
    <div class="shop-area pb-75" data-aos="fade-up">
      <div class="container">
        <div class="section-title title-inline mb-30">
          <h3 class="title mb-20">{{ __('Related Products') }}</h3>
          <!-- Slider navigation buttons -->
          <div class="slider-navigation mb-20">
            <button type="button" title="Slide prev" class="slider-btn slider-btn-prev btn-outline radius-0"
              id="shop-slider-prev">
              <i class="fal fa-angle-left"></i>
            </button>
            <button type="button" title="Slide next" class="slider-btn slider-btn-next btn-outline radius-0"
              id="shop-slider-next">
              <i class="fal fa-angle-right"></i>
            </button>
          </div>
        </div>
        <div class="swiper shop-slider mb-40">
          <div class="swiper-wrapper">
            @foreach ($related_products as $product)
              <div class="swiper-slide">
                <div class="product-default shadow-none text-center mb-25">
                  <figure class="product-img mb-15">
                    <a href="{{ route('shop.product_details', ['slug' => $product->slug]) }}"
                      class="lazy-container ratio ratio-1-1">
                      <img class="lazyload" src="{{ asset('assets/front/images/placeholder.png') }}"
                        data-src="{{ asset('assets/img/products/featured-images/' . $product->featured_image) }}"
                        alt="Product">
                    </a>
                    @if ($product->product_type == 'digital')
                      <span class="badge">{{ $product->product_type }}</span>
                    @endif

                    @if ($product->product_type == 'physical')
                      @if ($product->stock == 0)
                        <div class="stock-overlay">
                          <span>{{ __('Stock Out') }}</span>
                        </div>
                      @endif
                    @endif

                    @if ($product->product_type == 'physical')
                      @if ($product->stock != 0)
                        <div class="product-overlay">
                          <a href="{{ route('shop.product_details', ['slug' => $product->slug]) }}" target="_self"
                            title="{{ __('View Details') }}" class="icon">
                            <i class="fas fa-eye"></i>
                          </a>
                          <a href="{{ route('shop.product.add_to_cart', ['id' => $product->id, 'quantity' => 1]) }}"
                            target="_self" title="{{ __('Add to Cart') }}" class="icon cart-btn add-to-cart-btn">
                            <i class="fas fa-shopping-cart"></i>
                          </a>
                        </div>
                      @endif
                    @endif

                    @if ($product->product_type == 'digital')
                      <div class="product-overlay">
                        <a href="{{ route('shop.product_details', ['slug' => $product->slug]) }}" target="_self"
                          title="{{ __('View Details') }}" class="icon">
                          <i class="fas fa-eye"></i>
                        </a>
                        <a href="{{ route('shop.product.add_to_cart', ['id' => $product->id, 'quantity' => 1]) }}"
                          target="_self" title="{{ __('Add to Cart') }}" class="icon cart-btn add-to-cart-btn">
                          <i class="fas fa-shopping-cart"></i>
                        </a>
                      </div>
                    @endif
                  </figure>
                  <div class="product-details p-0">
                    <div class="ratings ratings justify-content-center mb-10">
                      <div class="rate" style="background-image: url('{{ asset($rateStar) }}')">
                        <div class="rating-icon"
                          style="background-image: url('{{ asset($rateStar) }}'); width: {{ $product->average_rating * 20 . '%;' }}">
                        </div>
                      </div>
                    </div>
                    <h5 class="product-title mb-2">
                      <a
                        href="{{ route('shop.product_details', ['slug' => $product->slug]) }}">{{ strlen($product->title) > 15 ? mb_substr($product->title, 0, 15, 'UTF-8') . '...' : $product->title }}</a>
                    </h5>
                    <div class="product-price justify-content-center">
                      <h6 class="new-price">{{ symbolPrice($product->current_price) }}</h6>
                      @if (!empty($product->previous_price))
                        <span class="old-price font-sm">{{ symbolPrice($product->previous_price) }}</span>
                      @endif
                    </div>
                  </div>
                </div><!-- product-default -->
              </div>
            @endforeach

          </div>
        </div>


      </div>
      @if (!empty(showAd(3)))
        <div class="text-center mt-40">
          {!! showAd(3) !!}
        </div>
      @endif
    </div>
  @endif

  </div>
  <!-- Shop-single-area end -->

  <!-- Related Product-area start -->
  @if (count($related_products) > 0)
    <div class="shop-area pb-75" data-aos="fade-up">
      <div class="container">
        <div class="section-title title-inline mb-30">
          <h3 class="title mb-20">{{ __('Related Products') }}</h3>
          <!-- Slider navigation buttons -->
          <div class="slider-navigation mb-20">
            <button type="button" title="Slide prev" class="slider-btn slider-btn-prev btn-outline radius-0"
              id="shop-slider-prev">
              <i class="fal fa-angle-left"></i>
            </button>
            <button type="button" title="Slide next" class="slider-btn slider-btn-next btn-outline radius-0"
              id="shop-slider-next">
              <i class="fal fa-angle-right"></i>
            </button>
          </div>
        </div>
        <div class="swiper shop-slider mb-40">
          <div class="swiper-wrapper">
            @foreach ($related_products as $product)
              <div class="swiper-slide">
                <div class="product-default shadow-none text-center mb-25">
                  <figure class="product-img mb-15">
                    <a href="{{ route('shop.product_details', ['slug' => $product->slug]) }}"
                      class="lazy-container ratio ratio-1-1">
                      <img class="lazyload" src="{{ asset('assets/front/images/placeholder.png') }}"
                        data-src="{{ asset('assets/img/products/featured-images/' . $product->featured_image) }}"
                        alt="Product">
                    </a>
                    @if ($product->product_type == 'digital')
                      <span class="badge">{{ $product->product_type }}</span>
                    @endif
                    <div class="product-overlay">
                      <a href="{{ route('shop.product_details', ['slug' => $product->slug]) }}" target="_self"
                        title="{{ __('View Details') }}" class="icon"><i class="fas fa-eye"></i></a>
                      <a href="{{ route('shop.product.add_to_cart', ['id' => $product->id, 'quantity' => 1]) }}"
                        target="_self" title="{{ __('Add to Cart') }}" class="icon cart-btn add-to-cart-btn">
                        <i class="fas fa-shopping-cart"></i>
                      </a>
                    </div>
                  </figure>
                  <div class="product-details p-0">
                    <div class="ratings ratings justify-content-center mb-10">
                      <div class="rate" style="background-image:url('{{ asset($rateStar) }}')">
                        <div class="rating-icon"
                          style="background-image:url('{{ asset($rateStar) }}'); width: {{ $product->average_rating * 20 . '%;' }}">
                        </div>
                      </div>
                    </div>
                    <h5 class="product-title mb-2">
                      <a
                        href="{{ route('shop.product_details', ['slug' => $product->slug]) }}">{{ strlen($product->title) > 15 ? mb_substr($product->title, 0, 15, 'UTF-8') . '...' : $product->title }}</a>
                    </h5>
                    <div class="product-price justify-content-center">
                      <h6 class="new-price">{{ symbolPrice($product->current_price) }}</h6>
                      @if (!empty($product->previous_price))
                        <span class="old-price font-sm">{{ symbolPrice($product->previous_price) }}</span>
                      @endif
                    </div>
                  </div>
                </div><!-- product-default -->
              </div>
            @endforeach

          </div>
        </div>


      </div>
      @if (!empty(showAd(3)))
        <div class="text-center mt-40">
          {!! showAd(3) !!}
        </div>
      @endif
    </div>
  @endif
  <!-- Related Product-area end -->
@endsection

@section('script')
  <script src="{{ asset('assets/front/js/shop.js') }}"></script>
@endsection
