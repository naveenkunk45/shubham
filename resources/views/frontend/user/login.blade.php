@extends('frontend.layout')

@section('pageHeading')
{{ !empty($pageHeading) ? $pageHeading->login_page_title : __('Login') }}
@endsection
@section('metaKeywords')
@if (!empty($seoInfo))
{{ $seoInfo->meta_keyword_login }}
@endif
@endsection

@section('metaDescription')
@if (!empty($seoInfo))
{{ $seoInfo->meta_description_login }}
@endif
@endsection

@section('content')
@includeIf('frontend.partials.breadcrumb', [
'breadcrumb' => $bgImg->breadcrumb,
'title' => !empty($pageHeading) ? $pageHeading->login_page_title : __('Login'),
])
<!-- Authentication-area start -->
<div class="authentication-area ptb-100">
  <div class="container">

    <div class="auth-form border radius-md">

      <div class="form-group overflow-hidden mb-0">
        <div class="row justify-content-between">

          @if ($bs->facebook_login_status == 1)
          <a class="text-center {{ $bs->google_login_status == 0 ? 'w-100' : 'w-50' }} pt-2 py-2 bg-facebook"
            href="{{ route('user.login.facebook') }}"><i class="fas fa-facebook-f"></i>
            {{ __('Login with Facebook') }}</a>
          @endif

          @if ($bs->google_login_status == 1)
          <!-- <a class="text-center {{ $bs->facebook_login_status == 0 ? 'w-100' : 'w-50' }}  pt-2 py-2 bg-google"
            href="{{ route('user.login.google') }}"> <i class="fas fa-google"></i>
            {{ __('Login with Google') }}</a> -->

          <a class="text-center {{ $bs->facebook_login_status == 0 ? 'w-100' : 'w-50' }}  pt-2 py-2 bg-google"
            href="{{ route('user.login.google') }}"> <img src="{{ asset('assets/img/gmail.png') }}" alt="logo" class="gmail">
          </a>
          @endif
        </div>
      </div>
      <div class="google_text py-3">
        <p class="text-center">Fill a Form or Login with Google</p>
      </div>

      @if (Session::has('success'))
      <div class="alert alert-success">{{ __(Session::get('success')) }}</div>
      @endif
      @if (Session::has('error'))
      <div class="alert alert-danger">{{ __(Session::get('error')) }}</div>
      @endif
      <form action="{{ route('user.login_submit') }}" method="POST">
        @csrf
        <div class="title">
          <h4 class="mb-20 text-center">{{ __('Login') }}</h4>
        </div>
        <div class="form-group mb-30">
          <input type="text" class="form-control" value="{{ old('username') }}" name="username" placeholder="{{ __('Username') }}" required>
          @error('username')
          <p class="text-danger mt-2">{{ $message }}</p>
          @enderror
        </div>

        <div class="form-group mb-30">
          <input type="password" class="form-control" value="{{ old('password') }}" name="password" placeholder="{{ __('Password') }}" required>
          @error('password')
          <p class="text-danger mt-2">{{ $message }}</p>
          @enderror
        </div>

        @if ($bs->google_recaptcha_status == 1)
        <div class="form-group mb-30">
          {!! NoCaptcha::renderJs() !!}
          {!! NoCaptcha::display() !!}

          @error('g-recaptcha-response')
          <p class="mt-1 text-danger">{{ $message }}</p>
          @enderror
        </div>
        @endif

        <div class="row align-items-center mb-20">
          <div class="col-4 col-xs-12">
            <div class="link">
              <a href="{{ route('user.forget_password') }}">{{ __('Forgot password') . '?' }}</a>
            </div>
          </div>
          <div class="col-8 col-xs-12">
            <div class="link go-signup">
              {{ __("don't have an account") . '?' }} <a href="{{ route('user.signup') }}">{{ __('Click Here') }}</a>
              {{ __('to Signup') }}
            </div>
          </div>
        </div>
        <button type="submit" class="btn btn-lg btn-primary radius-md w-100"> {{ __('Login') }} </button>
      </form>
    </div>
  </div>
</div>
<!-- Authentication-area end -->
@endsection