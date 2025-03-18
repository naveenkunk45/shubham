"use strict";
$.ajaxSetup({
  headers: {
    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
  }
});
$("#searchBtn2").on('click', function (e) {
  e.preventDefault();

  var formData = $('#searchForm2').serializeArray();
  var queryParams = [];

  $.each(formData, function (index, input) {
    if (input.value !== '') {
      queryParams.push(encodeURIComponent(input.name) + '=' + encodeURIComponent(input.value));
    }
  });

  var queryString = queryParams.join('&');
  var newUrl = baseURL + '/listings';

  if (queryString !== '') {
    newUrl += '?' + queryString;
  }

  // Update the browser URL without reloading the page
  window.location.href = newUrl;
}); // <-- Added closing parenthesis and semicolon
