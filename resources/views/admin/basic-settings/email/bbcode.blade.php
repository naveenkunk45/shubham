<div class="col-lg-5">
  <table class="table table-striped border">
    <thead>
      <tr>
        <th scope="col">{{ __('BB Code') }}</th>
        <th scope="col">{{ __('Meaning') }}</th>
      </tr>
    </thead>
    <tbody>
      @if ($templateInfo->mail_type == 'verify_email')
        <tr>
          <td>{username}</td>
          <td scope="row">{{ __('Username of User') }}</td>
        </tr>
      @endif

      @if ($templateInfo->mail_type == 'verify_email')
        <tr>
          <td>{verification_link}</td>
          <td scope="row">{{ __('Email Verification Link') }}</td>
        </tr>
      @endif

      @if ($templateInfo->mail_type == 'reset_password' || $templateInfo->mail_type == 'product_order')
        <tr>
          <td>{customer_name}</td>
          <td scope="row">{{ __('Name of The Customer') }}</td>
        </tr>
      @endif

      @if (
          $templateInfo->mail_type == 'payment_accepted_for_featured_offline_gateway' ||
              $templateInfo->mail_type == 'payment_rejected_for_buy_feature_offline_gateway')
        <tr>
          <td>{payment_via}</td>
          <td scope="row">{{ __('Payment Method Name') }}</td>
        </tr>
        <tr>
          <td>{package_price}</td>
          <td scope="row">{{ __('Pament Amount ') }}</td>
        </tr>
      @endif
      @if ($templateInfo->mail_type == 'payment_accepted_for_featured_online_gateway')
        <tr>
          <td>{payment_via}</td>
          <td scope="row">{{ __('Payment Method Name') }}</td>
        </tr>
        <tr>
          <td>{package_price}</td>
          <td scope="row">{{ __('Pament Amount ') }}</td>
        </tr>
      @endif


      @if ($templateInfo->mail_type == 'listing_feature_active')
        <tr>
          <td>{days}</td>
          <td scope="row">{{ __('How Many Days Active') }}</td>
        </tr>
        <tr>
          <td>{listing_name}</td>
          <td scope="row">{{ __('Listing Title') }}</td>
        </tr>
        <tr>
          <td>{activation_date}</td>
          <td scope="row">{{ __('Feature Active Date ') }}</td>
        </tr>
        <tr>
          <td>{end_date}</td>
          <td scope="row">{{ __('Feature Expiry Date ') }}</td>
        </tr>
      @endif
      @if ($templateInfo->mail_type == 'listing_feature_reject')
        <tr>
          <td>{listing_name}</td>
          <td scope="row">{{ __('Listing Title') }}</td>
        </tr>
      @endif

      @if ($templateInfo->mail_type == 'balance_add' || $templateInfo->mail_type == 'balance_subtract')
        <tr>
          <td>{amount}</td>
          <td scope="row">{{ __('Balance add/substract  amount') }}</td>
        </tr>
      @endif

      @if ($templateInfo->mail_type == 'reset_password')
        <tr>
          <td>{password_reset_link}</td>
          <td scope="row">{{ __('Password Reset Link') }}</td>
        </tr>
      @endif

      @if ($templateInfo->mail_type == 'product_order')
        <tr>
          <td>{order_number}</td>
          <td scope="row">{{ __('Order Number') }}</td>
        </tr>
      @endif

      @if ($templateInfo->mail_type == 'product_order')
        <tr>
          <td>{order_link}</td>
          <td scope="row">{{ __('Link to View Order Details') }}</td>
        </tr>
      @endif

      @if (
          $templateInfo->mail_type != 'verify_email' ||
              $templateInfo->mail_type != 'reset_password' ||
              $templateInfo->mail_type != 'product_order')
        <tr>
          <td>{username}</td>
          <td scope="row">{{ __('Username of Vendor') }}</td>
        </tr>
      @endif

      @if (
          $templateInfo->mail_type == 'admin_changed_current_package' ||
              $templateInfo->mail_type == 'admin_changed_next_package' ||
              $templateInfo->mail_type == 'admin_removed_current_package')
        <tr>
          <td>{replaced_package}</td>
          <td scope="row">{{ __('Replace Package Name') }}</td>
        </tr>
      @endif

      @if (
          $templateInfo->mail_type == 'admin_changed_current_package' ||
              $templateInfo->mail_type == 'admin_added_current_package' ||
              $templateInfo->mail_type == 'admin_changed_next_package' ||
              $templateInfo->mail_type == 'admin_added_next_package' ||
              $templateInfo->mail_type == 'admin_removed_current_package' ||
              $templateInfo->mail_type == 'admin_removed_next_package' ||
              $templateInfo->mail_type == 'package_purchase' ||
              $templateInfo->mail_type == 'payment_accepted_for_membership_offline_gateway' ||
              $templateInfo->mail_type == 'payment_rejected_for_membership_offline_gateway')
        <tr>
          <td>{package_title}</td>
          <td scope="row">{{ __('Package Name') }}</td>
        </tr>
      @endif

      @if (
          $templateInfo->mail_type == 'admin_changed_current_package' ||
              $templateInfo->mail_type == 'admin_added_current_package' ||
              $templateInfo->mail_type == 'admin_added_next_package' ||
              $templateInfo->mail_type == 'package_purchase' ||
              $templateInfo->mail_type == 'payment_accepted_for_membership_offline_gateway' ||
              $templateInfo->mail_type == 'payment_rejected_for_membership_offline_gateway')
        <tr>
          <td>{package_price}</td>
          <td scope="row">{{ __('Price of Package') }}</td>
        </tr>
      @endif

      @if (
          $templateInfo->mail_type == 'admin_changed_current_package' ||
              $templateInfo->mail_type == 'admin_added_current_package' ||
              $templateInfo->mail_type == 'admin_changed_next_package' ||
              $templateInfo->mail_type == 'admin_added_next_package' ||
              $templateInfo->mail_type == 'package_purchase' ||
              $templateInfo->mail_type == 'payment_accepted_for_membership_offline_gateway')
        <tr>
          <td>{activation_date}</td>
          <td scope="row">{{ __('Package activation date') }}</td>
        </tr>
      @endif
      @if (
          $templateInfo->mail_type == 'admin_changed_current_package' ||
              $templateInfo->mail_type == 'admin_added_current_package' ||
              $templateInfo->mail_type == 'admin_changed_next_package' ||
              $templateInfo->mail_type == 'admin_added_next_package' ||
              $templateInfo->mail_type == 'package_purchase' ||
              $templateInfo->mail_type == 'payment_accepted_for_membership_offline_gateway')
        <tr>
          <td>{expire_date}</td>
          <td scope="row">{{ __('Package expire date') }}</td>
        </tr>
      @endif

      @if ($templateInfo->mail_type == 'membership_expiry_reminder')
        <tr>
          <td>{last_day_of_membership}</td>
          <td scope="row">{{ __('Package expire last date') }}</td>
        </tr>
      @endif
      @if ($templateInfo->mail_type == 'membership_expiry_reminder' || $templateInfo->mail_type == 'membership_expired')
        <tr>
          <td>{login_link}</td>
          <td scope="row">{{ __('Login Url') }}</td>
        </tr>
      @endif

      @if ($templateInfo->mail_type == 'inquiry_about_listing')
        <tr>
          <td>{listing_name}</td>
          <td scope="row">{{ __('Name of Listing') }}</td>
        </tr>
        <tr>
          <td>{enquirer_name}</td>
          <td scope="row">{{ __('Name of enquirer') }}</td>
        </tr>
        <tr>
          <td>{enquirer_email}</td>
          <td scope="row">{{ __('Email address of enquirer') }}</td>
        </tr>
        <tr>
          <td>{enquirer_phone}</td>
          <td scope="row">{{ __('Phone number of enquirer') }}</td>
        </tr>
        <tr>
          <td>{enquirer_message}</td>
          <td scope="row">{{ __('Message of enquirer') }}</td>
        </tr>
      @endif
      @if ($templateInfo->mail_type == 'inquiry_about_product')
        <tr>
          <td>{listing_name}</td>
          <td scope="row">{{ __('Listing Title') }}</td>
        </tr>
        <tr>
          <td>{product_name}</td>
          <td scope="row">{{ __('Name of Product') }}</td>
        </tr>
        <tr>
          <td>{enquirer_name}</td>
          <td scope="row">{{ __('Name of enquirer') }}</td>
        </tr>
        <tr>
          <td>{enquirer_email}</td>
          <td scope="row">{{ __('Email address of enquirer') }}</td>
        </tr>
        <tr>
          <td>{enquirer_message}</td>
          <td scope="row">{{ __('Message of enquirer') }}</td>
        </tr>
      @endif

      <tr>
        <td>{website_title}</td>
        <td scope="row">{{ __('Website Title') }}</td>
      </tr>
    </tbody>
  </table>
</div>
