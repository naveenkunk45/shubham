@extends('frontend.layout')

@section('pageHeading')
{{ __('Home') }}
@endsection
@section('metaKeywords')
@if (!empty($seoInfo))
{{ $seoInfo->meta_keyword_home }}
@endif
@endsection

@section('metaDescription')
@if (!empty($seoInfo))
{{ $seoInfo->meta_description_home }}
@endif
@endsection

@section('content')
<!-- Home-area start-->

<section class="custom_hero">
  <div class="container">
    <div class="row">
      <div class="col-12 col-md-6 custom_hero_col">
        <h1><span>All the resources you need</span> to effortlessly
          plan and bring your event to life</h1>
        <p>We connect you with the best event service providers for all your occasions. It’s
          our privilege to serve you through our exceptional online platform.</p>


        <form action="{{ route('frontend.listings') }}" id="searchForm2" method="GET">
          <div class="row ">
            <div class="col">
              <div class="input-group">
                <select aria-label="categories" id="category_id" name="category_id" class="form-select">
                  <option value="" selected>{{ __('All') }}</option>
                  @foreach ($categories as $category)
                  <option value="{{ $category->slug }}">{{ $category->name }}
                  </option>
                  @endforeach
                </select>
              </div>
            </div>
            <div class="col">
              <div class="input-group suggesting_input">
                <input type="text" name="city" id="location" class="form-control myclasssearch"
                  placeholder="Search City" autocomplete="off">
              </div>
              <ul id="suggestions" class="input_suggestion"></ul>
            </div>
            <div class="col">
              <button type="submit" id="searchBtn2" class="btn  btn-primary">
                Search Now
              </button>
            </div>
          </div>
        </form>
      </div>
      <div class="col-12 col-md-6"></div>
    </div>
  </div>
</section>


<section class="custom_hero_mobile">
  <div class="container">
    <div class="row">
      <div class="col-12  custom_hero_col">
        <h1><span>All the resources you need</span> to effortlessly
          plan and bring your event to life</h1>
        <p>We connect you with the best event service providers for all your occasions. It’s
          our privilege to serve you through our exceptional online platform.</p>


        <form action="{{ route('frontend.listings') }}" id="searchForm2" method="GET">
          <div class="row ">
            <div class="col-12 col-md">
              <div class="input-group">
                <select aria-label="categories" id="category_id" name="category_id" class="form-select">
                  <option value="" selected>{{ __('All') }}</option>

                  @foreach ($categories as $category)
                  <option value="{{ $category->slug }}">{{ $category->name }}
                  </option>
                  @endforeach

                </select>
              </div>
            </div>
            <div class="col-12 col-md">
              <!-- <div class="input-group">
                <input type="text" name="city" id="location" class="form-control"
                  placeholder="{{ __('Location') }}">
              </div> -->

              <div class="input-group suggesting_input">
                <input type="text" name="city" id="location" class="form-control myclasssearch"
                  placeholder="Search City" autocomplete="off">
              </div>
              <ul id="suggestions" class="input_suggestion"></ul>
            </div>
            <div class="col-12 col-md">
              <button type="button" id="searchBtn2" class="btn  btn-primary">
                Search Now
              </button>
            </div>
          </div>
        </form>
      </div>
      <div class="col-12 custom_hero_col_img">
        <img src="{{ asset('assets/admin/img/h/hh.png') }}" alt="logo">
      </div>
    </div>
  </div>
</section>









<section class="category">
  <div class="container">
    <h2>Explore Our Service Categories</h2>
    <div class="row mt-3">
      <div class="col-12 col-md-12 col-lg-6 category_card">
        <div class="card card_1">
          <div class="row">
            <div class="col-12 col-md-5 category_col">
              <div>
                <h3>Flower Decoration</h3>
                <p>Transforming your events with stunning, tailor-made flower decorations that leave a lasting impression.</p>
                <a href="#" class="btn">View All </a>
              </div>

            </div>
            <div class="col-12 col-md-7 d-flex align-items-center">
              <img src="{{ asset('assets/admin/img/e/fs.png') }}" alt="logo">
            </div>
          </div>
        </div>

      </div>
      <div class="col-12 col-md-12 col-lg-6  category_card">
        <div class="card card_2">
          <div class="row">
            <div class="col-12 col-md-5 category_col">
              <div>
                <h3>Makeup Artist</h3>
                <p>Enhancing your natural beauty with professional makeup artistry for every special occasion.</p>
                <a href="#" class="btn">View All Makeup Artist Services</a>
              </div>

            </div>
            <div class="col-12 col-md-7 d-flex align-items-center">
              <img src="{{ asset('assets/admin/img/e/ma.png') }}" alt="logo">
            </div>
          </div>
        </div>

      </div>

    </div>
    <div class="row ">
      <div class="col-12 col-md-12 col-lg-6 category_card">
        <div class="card card_3">
          <div class="row">
            <div class="col-12 col-md-5 category_col">
              <div>
                <h3>Catering Services</h3>
                <p>
                  Delighting your guests with exceptional catering services featuring diverse and flavorful cuisines.</p>
                <a href="#" class="btn">View All Catering Services</a>
              </div>

            </div>
            <div class="col-12 col-md-7 d-flex align-items-center">
              <img src="{{ asset('assets/admin/img/e/cs.png') }}" alt="logo">
            </div>
          </div>
        </div>

      </div>
      <div class="col-12 col-md-12 col-lg-6  category_card">
        <div class="card card_4">
          <div class="row">
            <div class="col-12 col-md-5 category_col">
              <div>
                <h3>Orchestra Singers</h3>
                <p>Creating unforgettable moments with soulful performances by talented orchestra singers.</p>
                <a href="#" class="btn">View All Orchestra Singer Services</a>
              </div>

            </div>
            <div class="col-12 col-md-7 d-flex align-items-center">
              <img src="{{ asset('assets/admin/img/e/os.png') }}" alt="logo">
            </div>
          </div>
        </div>

      </div>

    </div>
    <div class="row ">
      <div class="col-12 col-md-12 col-lg-6  category_card">
        <div class="card card_5">
          <div class="row">
            <div class="col-12 col-md-5 category_col">
              <div>
                <h3>Mehendi Artists</h3>
                <p>Adding elegance to your celebrations with intricate and personalized mehendi designs by skilled artists.</p>
                <a href="#" class="btn">View All Mehendi Artist Services</a>
              </div>

            </div>
            <div class="col-12 col-md-7 d-flex align-items-center">
              <img src="{{ asset('assets/admin/img/e/mea.png') }}" alt="logo">
            </div>
          </div>
        </div>

      </div>
      <div class="col-12 col-md-12 col-lg-6  category_card">
        <div class="card card_6">
          <div class="row">
            <div class="col-12 col-md-5 category_col">
              <div>
                <h3>Invitation Cards</h3>
                <p>
                  Crafting elegant and personalized invitation cards to make your special moments unforgettable. </p>
                <a href="#" class="btn">View All Invitation Card Services</a>
              </div>

            </div>
            <div class="col-12 col-md-7 d-flex align-items-center">
              <img src="{{ asset('assets/admin/img/e/ic.png') }}" alt="logo">
            </div>
          </div>
        </div>

      </div>

    </div>


    <div class="row">
      <div class="col view_ss">
        <button href="#" class="view_all_cate">View All Service Catrgories</button>
      </div>
    </div>



  </div>


</section>




<section class="vendor_list">
  <div class="container">
    <h2>Featured Vendors</h2>
    <div class="row">

      @foreach ($listing_contents as $listing_content)
      <div class="col-xl-3 col-lg-4 col-sm-6" data-aos="fade-up">
        <div class="product-default border radius-md mb-25">
          <figure class="product-img">
            <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}"
              class="lazy-container ratio ratio-2-3">
              <img class="lazyload" data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
                alt="{{ optional($listing_content)->title }}">
            </a>

          </figure>

          <div class="product-details">
            <div class="product-top mb-10">
              @php
              if ($listing_content->vendor_id == 0) {
              $vendorInfo = App\Models\Admin::first();
              $userName = 'admin';
              } else {
              $vendorInfo = App\Models\Vendor::findorfail($listing_content->vendor_id);
              $userName = $vendorInfo->username;
              }
              @endphp

              <!-- <div class="author">
                <a class="color-medium" href="{{ route('frontend.vendor.details', ['username' => $userName]) }}"
                  target="_self" title={{ $vendorInfo->username }}>

                  @if ($listing_content->vendor_id == 0)
                  <img class="lazyload" src="assets/images/placeholder.png"
                    data-src="{{ asset('assets/img/admins/' . $vendorInfo->image) }}" alt="Vendor">
                  @else
                  @if ($vendorInfo->photo != null)
                  <img class="blur-up lazyload"
                    data-src="{{ asset('assets/admin/img/vendor-photo/' . $vendorInfo->photo) }}" alt="Image">
                  @else
                  <img class="blur-up lazyload" data-src="{{ asset('assets/img/blank-user.jpg') }}" alt="Image">
                  @endif
                  @endif
                  <span>{{ __('By') }}
                    {{ $vendorInfo->username }}
                  </span>
                  </span>
                </a>
              </div> -->
              @php
              $categorySlug = App\Models\ListingCategory::findorfail($listing_content->category_id);
              @endphp
              <a href="{{ route('frontend.listings', ['category_id' => $categorySlug->slug]) }}" title="Link"
                class="product-category font-sm icon-start">
                <i
                  class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}{{ $listing_content->category_id }}
              </a>
            </div>
            <h5 class="product-title mb-10"><a
                href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}">{{ optional($listing_content)->title }}</a>
            </h5>
            <div class="product-ratings mb-10">
              <div class="ratings">
                <div class="rate" style="background-image:url('{{ asset($rateStar) }}')">
                  <div class="rating-icon"
                    style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing_content->average_rating * 20 . '%;' }}">
                  </div>
                </div>
                <span class="ratings-total font-sm">({{ $listing_content->average_rating }})</span>
                <span class="ratings-total color-medium ms-1 font-sm">{{ totalListingReview($listing_content->id) }}
                  {{ __('Reviews') }}</span>
              </div>
            </div>
            @php
            $city = null;
            $State = null;
            $country = null;

            if ($listing_content->city_id) {
            $city = App\Models\Location\City::Where('id', $listing_content->city_id)->first()
            ->name;
            }
            if ($listing_content->state_id) {
            $State = App\Models\Location\State::Where('id', $listing_content->state_id)->first()
            ->name;
            }
            if ($listing_content->country_id) {
            $country = App\Models\Location\Country::Where(
            'id',
            $listing_content->country_id,
            )->first()->name;
            }

            @endphp
            <span class="product-location icon-start font-sm"><i
                class="fal fa-map-marker-alt"></i>{{ @$city }}@if (@$State)
              ,{{ $State }}
              @endif @if (@$country)
              ,{{ @$country }}
              @endif
            </span>
            <!-- @if ($listing_content->max_price && $listing_content->min_price)
            <div class="product-price mt-10 pt-10 border-top">
              <span class="color-medium me-2">{{ __('From') }}</span>
              <h6 class="price mb-0 lh-1">
                {{ symbolPrice($listing_content->min_price) }} -
                {{ symbolPrice($listing_content->max_price) }}
              </h6>
            </div>
            @endif -->
          </div>
        </div>
      </div>
      @endforeach
    </div>
  </div>

</section>


<section class="testimonials">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <ul class="nav nav-tabs testimonials_tabs" id="myTab" role="tablist">
          <li class="nav-item" role="presentation">
            <a class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button"
              role="tab" aria-controls="home-tab-pane" aria-selected="true"> <img
                src="{{ asset('assets/admin/img/t/1.png') }}" alt="logo"></a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button"
              role="tab" aria-controls="profile-tab-pane" aria-selected="false"><img
                src="{{ asset('assets/admin/img/t/2.png') }}" alt="logo"></a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button"
              role="tab" aria-controls="contact-tab-pane" aria-selected="false"><img
                src="{{ asset('assets/admin/img/t/3.png') }}" alt="logo"></a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="disabled-tab" data-bs-toggle="tab" data-bs-target="#disabled-tab-pane" type="button"
              role="tab" aria-controls="disabled-tab-pane" aria-selected="false"><img
                src="{{ asset('assets/admin/img/t/4.png') }}" alt="logo"></a>
          </li>
        </ul>
        <div class="tab-content" id="myTabContent">
          <div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab"
            tabindex="0">
            <div class="card">
              <h3>Priya K
              </h3>
              <h6>Bengaluru
              </h6>
              <p>I was thoroughly impressed with Shubham's expertise and attention to detail. Their solutions were tailored to my business needs, and the results exceeded my expectations. From start to finish, the process was seamless and professional. Highly recommend Shubham for anyone seeking quality and reliability!</p>
            </div>
          </div>
          <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
            <div class="card">
              <h3>Rahul S
              </h3>
              <h6>Mysore
              </h6>
              <p>Shubham has been a game-changer for my project. The team provided creative ideas and implemented them flawlessly. Their commitment to deadlines and exceptional support truly set them apart. Working with Shubham has been an absolute pleasure!</p>
            </div>
          </div>
          <div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">
            <div class="card">
              <h3>Ananya M
              </h3>
              <h6>Dharwad
              </h6>
              <p>If you’re looking for innovative solutions and a team that genuinely cares about your success, Shubham is the way to go! Their professionalism, communication, and technical skills made all the difference. I can’t thank them enough for the excellent service!</p>
            </div>
          </div>
          <div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">
            <div class="card">
              <h3>Karan T
              </h3>
              <h6>Hassan
              </h6>
              <p>Partnering with Shubham has been the best decision for our company. Their deep understanding of our goals and challenges allowed them to deliver outstanding results. The team is friendly, responsive, and highly skilled. We look forward to collaborating again in the future!</p>
            </div>
          </div>

        </div>
      </div>
    </div>
</section>




<!-- Blog-area start -->
@if ($secInfo->blog_section_status == 1)
<section class="blogs">
  <div class="container">
    <h2>
      Read our latest Blogs
    </h2>
    <div class="row">
      @foreach ($blogs as $blog)
      <div class="col-md-6 col-lg-3 col-12 mt-3 mt-md">
        <div class="card">

          <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}"
            class="lazy-container ratio ratio-16-10">
            <img class="lazyload" data-src="{{ asset('assets/img/blogs/' . $blog->image) }}" alt="Blog Image">
          </a>

          <div class="content">
            <h3>
              <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}">
                {{ $blog->title }}
              </a>
            </h3>
            <p>
              {{ strlen(strip_tags(convertUtf8($blog->content))) > 100 ? substr(strip_tags(convertUtf8($blog->content)), 0, 100) . '...' : strip_tags(convertUtf8($blog->content)) }}
            </p>
            <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}" class="card_btn">Read
              More</a>
          </div>
        </div>
      </div>
      @endforeach



    </div>
  </div>
</section>
@endif
<!-- Blog-area end -->
@endsection

@section('script')
<script src="{{ asset('assets/front/js/search-home.js') }}"></script>


@endsection