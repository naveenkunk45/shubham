<!-- 


<header class="header-area header-1 my_header" data-aos="slide-down">

  <div class="mobile-menu">
    <div class="container">
      <div class="mobile-menu-wrapper"></div>
    </div>
  </div>


  <div class="main-responsive-nav">
    <div class="container">

      <div class="logo">
        @if (!empty($websiteInfo->logo))
      <a href="{{ route('index') }}">
        <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo">
      </a>
    @endif
      </div>

      <button class="menu-toggler" type="button">
        <span></span>
        <span></span>
        <span></span>
      </button>
    </div>
  </div>
  <div class="main-navbar">
    <div class="container">
      <nav class="navbar navbar-expand-lg">
     
        <a class="navbar-brand" href="{{ route('index') }}">
          <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo">
        </a>
  
        <div class="collapse navbar-collapse">
          @php $menuDatas = json_decode($menuInfos); @endphp
          <ul id="mainMenu" class="navbar-nav mobile-item ">
            @foreach ($menuDatas as $menuData)
        @php  $href = get_href($menuData); @endphp
        @if (!property_exists($menuData, 'children'))
      <li class="nav-item">
        <a class="nav-link" href="{{ $href }}">{{ $menuData->text }}</a>
      </li>
    @else
    <li class="nav-item">
      <a class="nav-link toggle" href="{{ $href }}">{{ $menuData->text }}<i class="fal fa-plus"></i></a>
      <ul class="menu-dropdown">
      @php    $childMenuDatas = $menuData->children; @endphp
      @foreach ($childMenuDatas as $childMenuData)
      @php      $child_href = get_href($childMenuData); @endphp
      <li class="nav-item">
      <a class="nav-link" href="{{ $child_href }}">{{ $childMenuData->text }}</a>
      </li>
    @endforeach
      </ul>
    </li>
  @endif
      @endforeach
          </ul>
        </div>
        <div class="more-option mobile-item"> -->
<!-- <div class="item item-language">
            <div class="language">
              <form action="{{ route('change_language') }}" method="GET">
                <select class="niceselect" name="lang_code" onchange="this.form.submit()">
                  @foreach ($allLanguageInfos as $languageInfo)
            <option value="{{ $languageInfo->code }}" {{ $languageInfo->code == $currentLanguageInfo->code ? 'selected' : '' }}>
            {{ $languageInfo->name }}
            </option>
          @endforeach
                </select>
              </form>
            </div>
          </div> -->
<!-- <div class="item">
            <i class="fal fa-search"></i>
          </div>
          <div class="item">
            <div class="dropdown">
              <button class="btn btn-outline btn-md radius-sm dropdown-toggle" type="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                @if (!Auth::guard('web')->check())
          {{ __('Customer') }}
        @else
      {{ Auth::guard('web')->user()->username }}
    @endif
              </button>
              <ul class="dropdown-menu radius-sm text-transform-normal">
                @if (!Auth::guard('web')->check())
          <li><a class="dropdown-item" href="{{ route('user.login') }}">{{ __('Login') }}</a></li>
          <li><a class="dropdown-item" href="{{ route('user.signup') }}">{{ __('Signup') }}</a></li>
        @else
      <li><a class="dropdown-item" href="{{ route('user.dashboard') }}">{{ __('Dashboard') }}</a></li>
      <li><a class="dropdown-item" href="{{ route('user.logout') }}">{{ __('Logout') }}</a></li>
    @endif
              </ul>
            </div>
          </div>
          <div class="item">
            <div class="dropdown">
              <button class="btn btn-primary btn-md dropdown-toggle" type="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                @if (!Auth::guard('vendor')->check())
          {{ __('Are you Vendor') }}
        @else
      {{ Auth::guard('vendor')->user()->username }}
    @endif
              </button>
              <ul class="dropdown-menu radius-0">
                @if (!Auth::guard('vendor')->check())
          <li><a class="dropdown-item" href="{{ route('vendor.login') }}">{{ __('Login') }}</a></li>
          <li><a class="dropdown-item" href="{{ route('vendor.signup') }}">{{ __('Signup') }}</a></li>
        @else
      <li><a class="dropdown-item" href="{{ route('vendor.dashboard') }}">{{ __('Dashboard') }}</a></li>

      <li><a class="dropdown-item" href="{{ route('vendor.logout') }}">{{ __('Logout') }}</a></li>
    @endif
              </ul>
            </div>
          </div>

        </div>
      </nav>
    </div>
  </div>
</header> -->

<section class="search_header">
  <div class="container">
    <div class="row">
      <div class="col px-0">
        <form action="{{ route('frontend.listings') }}" id="searchForm2" method="GET">
          <div class="row">
            <div class="col-7 col-md-9 col-lg-10 px-2">
              <input type="text" name="searchquery" id="locations" class="form-control myform_control"
                placeholder="Search Listing">
            </div>
            <div class="col-5 col-md-3 col-lg-2 px-2">
              <button type="submit" id="searchBtn2" class="btn btn-primary">
                Search Now
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

<section class="headers header_in_mob">
  <div class="container">
    <div class="row">
      <div class="col-3 logo_col px-0">
        <a href="{{ route('index') }}">
          <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo">
        </a>

        <div class="dropdown custom_button">
          <a class="btn btn-primary btn-md  dropdown-toggle city_toggle" href="#" role="button" data-bs-toggle="dropdown"
            aria-expanded="false">
            Select City
          </a>

          <!-- <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#" disabled>Select your City</a></li>
            <li><a class="dropdown-item" href="#">Mysore</a></li>
            <li><a class="dropdown-item" href="#">Bangalore</a></li>
          </ul> -->

          <ul class="dropdown-menu" id="cityDropdowns">
            <li><a class="dropdown-item" href="#" disabled>Select your City</a></li>
          </ul>
        </div>
      </div>
      <div class="col-9 logo_col_menu px-0">

        <div class="menus logo_col_menu_col">


          <ul>
            <li>
              <a href="/">Home</a>
            </li>
            <li>
              <a href="/listings">Services</a>
              <div class="dropdowns">
                <ul>
                  <li><a href=""></a></li>
                </ul>
              </div>
            </li>
            <li>
              <a href="/blog">Blogs</a>
            </li>
            <li>
              <a href="/about-us">About us</a>
            </li>
            <li>
              <a href="/contact">Contact us</a>
            </li>
          </ul>
        </div>
        <div class="logo_col_menu_col">
          <div class="icon_background">
            <a href="#"> <i class="fal fa-search"></i></a>
          </div>


        </div>

        <div class="logo_col_menu_col">
          <button class="btn btn-outline btn-md radius-sm dropdown-toggle " type="button" data-bs-toggle="dropdown"
            aria-expanded="false">
            @if (!Auth::guard('web')->check())
            {{ __('Customer') }}
            @else
            {{ Auth::guard('web')->user()->username }}
            @endif
          </button>
          <ul class="dropdown-menu radius-sm text-transform-normal">
            @if (!Auth::guard('web')->check())
            <li><a class="dropdown-item" href="{{ route('user.login') }}">{{ __('Login') }}</a></li>
            <li><a class="dropdown-item" href="{{ route('user.signup') }}">{{ __('Signup') }}</a></li>
            @else
            <li><a class="dropdown-item" href="{{ route('user.dashboard') }}">{{ __('Dashboard') }}</a></li>
            <li><a class="dropdown-item" href="{{ route('user.logout') }}">{{ __('Logout') }}</a></li>
            @endif
          </ul>
        </div>
        <div class="logo_col_menu_col">
          <button class="btn btn-primary btn-md dropdown-toggle " type="button" data-bs-toggle="dropdown"
            aria-expanded="false">
            @if (!Auth::guard('vendor')->check())
            {{ __('Are you Vendor') }}
            @else
            {{ Auth::guard('vendor')->user()->username }}
            @endif
          </button>.
          <ul class="dropdown-menu radius-0">
            @if (!Auth::guard('vendor')->check())
            <li><a class="dropdown-item" href="{{ route('vendor.login') }}">{{ __('Login') }}</a></li>
            <li><a class="dropdown-item" href="{{ route('vendor.signup') }}">{{ __('Signup') }}</a></li>
            @else
            <li><a class="dropdown-item" href="{{ route('vendor.dashboard') }}">{{ __('Dashboard') }}</a></li>

            <li><a class="dropdown-item" href="{{ route('vendor.logout') }}">{{ __('Logout') }}</a></li>
            @endif
          </ul>
        </div>
      </div>






    </div>
  </div>
</section>


<section class="headers header_mobile">
  <div class="container">
    <div class="row">
      <div class="col-4 col-md-3 logo_col px-0">
        <a href="{{ route('index') }}">
          <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo">
        </a>
      </div>
      <div class="col-8 col-md-9 logo_col_menu px-0">


        <div class="logo_col_menu_col">
          <div class="icon_background">
            <a href="#"> <i class="fas fa-search"></i></a>
          </div>
        </div>

        <div class="logo_col_menu_col bars">
          <!-- <div class="icon_background"> -->
          <a href="#" class="ham_bar"> <i class="fas fa-bars"></i></a>
          <!-- </div> -->

          <div class="drop">
            <ul>
              <li>
                <a href="/">Home</a>
              </li>
              <li>
                <a href="/listings">Services</a>

              </li>
              <li>
                <a href="/blog">Blogs</a>
              </li>
              <li>
                <a href="/about-us">About us</a>
              </li>
              <li>
                <a href="/contact">Contact us</a>
              </li>
              <li>
                <a href="#" class="sub_dropdown">
                  @if (!Auth::guard('web')->check())
                  {{ __('Customer') }}
                  @else
                  {{ Auth::guard('web')->user()->username }}
                  @endif
                  <i class="fa fa-angle-down"></i>
                </a>
                <!-- <ul class="dropdown-menu radius-sm text-transform-normal"> -->
                <ul class="dropiconlist radius-sm text-transform-normal">
                  @if (!Auth::guard('web')->check())
                  <li><a href="{{ route('user.login') }}">{{ __('Login') }}</a></li>
                  <li><a href="{{ route('user.signup') }}">{{ __('Signup') }}</a></li>
                  @else
                  <li><a href="{{ route('user.dashboard') }}">{{ __('Dashboard') }}</a></li>
                  <li><a href="{{ route('user.logout') }}">{{ __('Logout') }}</a></li>
                  @endif
                </ul>
              </li>

              <li>
                <a href="#" class="sub_dropdown_1"> @if (!Auth::guard('vendor')->check())
                  {{ __('Are you Vendor') }}
                  @else
                  {{ Auth::guard('vendor')->user()->username }}
                  @endif <i class="fa fa-angle-down"></i></a>

                <!-- <ul class="dropdown-menu radius-0"> -->
                <ul class="dropiconlist_1 radius-0">
                  @if (!Auth::guard('vendor')->check())
                  <li><a href="{{ route('vendor.login') }}">{{ __('Login') }}</a></li>
                  <li><a href="{{ route('vendor.signup') }}">{{ __('Signup') }}</a></li>
                  @else
                  <li><a href="{{ route('vendor.dashboard') }}">{{ __('Dashboard') }}</a></li>

                  <li><a href="{{ route('vendor.logout') }}">{{ __('Logout') }}</a></li>
                  @endif
                </ul>
              </li>

            </ul>

          </div>


        </div>



      </div>






    </div>
  </div>
</section>