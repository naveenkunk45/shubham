<?php

namespace App\Http\Requests\Shop;

use App\Models\Language;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Foundation\Http\FormRequest;

class ProductStoreRequest extends FormRequest
{
  /**
   * Determine if the user is authorized to make this request.
   *
   * @return bool
   */
  public function authorize()
  {
    return true;
  }

  /**
   * Get the validation rules that apply to the request.
   *
   * @return array
   */
  public function rules()
  {
    $ruleArray = [
      'slider_images' => 'required',
      'featured_image' => [
        'required',
        new ImageMimeTypeRule()
      ],
      'status' => 'required'
    ];

    $productType = $this->product_type;

    if ($productType == 'digital') {
      $ruleArray['input_type'] = 'required';
      $ruleArray['file'] = 'required_if:input_type,upload|mimes:zip';
      $ruleArray['link'] = 'required_if:input_type,link';
    } elseif ($productType == 'physical') {
      $ruleArray['stock'] = 'required|numeric';
    }

    $ruleArray['current_price'] = 'required|numeric';

    $languages = Language::all();

    foreach ($languages as $language) {
      $ruleArray[$language->code . '_title'] = 'required|max:255|unique:product_contents,title';
      $ruleArray[$language->code . '_category_id'] = 'required';
      $ruleArray[$language->code . '_summary'] = 'required';
      $ruleArray[$language->code . '_content'] = 'min:30';
    }

    return $ruleArray;
  }

  /**
   * Get the validation messages that apply to the request.
   *
   * @return array
   */
  public function messages()
  {
    $messageArray = [];

    $productType = $this->product_type;

    if ($productType == 'digital') {
      $messageArray['file.required_if'] = 'The downloadable file is required when input type is upload.';
      $messageArray['file.mimes'] = 'Only .zip file is allowed for product\'s file.';
      $messageArray['link.required_if'] = 'The file download link is required when input type is link.';
    }

    $languages = Language::all();

    foreach ($languages as $language) {
      $messageArray[$language->code . '_title.required'] = 'The title field is required for ' . $language->name . ' language.';

      $messageArray[$language->code . '_title.max'] = 'The title field cannot contain more than 255 characters for ' . $language->name . ' language.';

      $messageArray[$language->code . '_title.unique'] = 'The title field must be unique for ' . $language->name . ' language.';

      $messageArray[$language->code . '_category_id.required'] = 'The category field is required for ' . $language->name . ' language.';

      $messageArray[$language->code . '_summary.required'] = 'The summary field is required for ' . $language->name . ' language.';

      $messageArray[$language->code . '_content.min'] = 'The content must be at least 30 characters for ' . $language->name . ' language.';
    }

    return $messageArray;
  }
}
