# Phone number mask
☎️ The package provides a simple parsing of phone numbers and various masking options.\
The used masks must be formatted with "#" symbol, for example: "+## (##) ####".

<div align="center">

  <a href="">![Pub Likes](https://img.shields.io/pub/likes/phone_number_mask?color=success)</a>
  <a href="">![Pub Version](https://img.shields.io/pub/v/phone_number_mask?color=important)</a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>

</div>

<div align="center">
  <a href="https://www.buymeacoffee.com/ivangalkin" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="32px" width= "128px"></a>
</div>

## Motivation
Some server APIs provide unformatted phone numbers, while the application client must figure out what mask to apply to a given phone number and use it for display.

## Benefits
Some packages only provide the ability to either parse phone numbers, without the ability to apply a custom mask, or are formatters for fields from which logic cannot be extracted for use on non-field strings.\
This package can use for self phone field formatters.\
In the list of constant countries, such data is collected to ensure the maximum match for parsing phone numbers.

## Usage
### Main Class
The package has the only main class to use - [PhoneNumberMask](https://github.com/ivangalkindeveloper/phone_number_mask/blob/master/lib/src/phone_number_mask.dart#L11):

| Data type | Name | Description | Default value |
|-----------|------|-------------|---------------|
| **String?** | **targetMask** | The mask that will be used to bypass phone number parsing to overlay all phone numbers. Use this field to use only one mask for all phone numbers. | **null** |
| **String?** | **defaultMask** | The mask that will be used in case the phone number is not recognized. If this field is not specified, the class will use the default mask "+### ### #### ####". | **"+### ### #### ####"** |
| **bool** | **isPlus** | The flag responsible for the plus sign at the very beginning. | **true** |
| **bool** | **isEndlessPhoneNumber** | the flag that doesn't cut the last part of the phone number if it exceeds the length of the mask. | **false** |

```dart
final PhoneNumberMask _phoneNumberMask = PhoneNumberMask(
    targetMask: "+## #### ######",
    defaultMask: "+### (###) ### ####",
    isPlus: false,
    isEndlessPhoneNumber: true,
);
```

### Main Method
The main method [apply](https://github.com/ivangalkindeveloper/phone_number_mask/blob/master/lib/src/phone_number_mask.dart#L41) does all the parsing work.

```dart
  final PhoneNumberMask _phoneNumberMask = PhoneNumberMask();
  final PhoneNumberMaskResult _result = _phoneNumberMask.apply(phoneNumber: "4492330323912034");
  print(_result.phoneNumberMasked); // +44 9233 032391
  print(_result.countryTitle); // United Kingdom
  print(_result.phoneCode); // 44
  print(_result.iso2Code); // GB
  print(_result.mask); // +## #### ######
```

### Result
The result is a separate class [PhoneNumberMaskResult](https://github.com/ivangalkindeveloper/phone_number_mask/blob/master/lib/src/data.dart#L15) that provides the following fields:

| Data type | Name | Description |
|-----------|------|-------------|
| **String** | **phoneNumberMasked** | Formatted phone number. |
| **String?** | **countryTitle** | Name of the country of the phone. |
| **String?** | **phoneCode** | Phone country code. |
| **String?** | **iso2Code** | Country code according to ISO 3166 standard. |
| **String?** | **mask** | The mask of this number in its pure form. |


## Additional Objects
Additionally, the package provides a constant list of country objects for its own use - [PhoneNumberMask.countries](https://github.com/ivangalkindeveloper/phone_number_mask/blob/master/lib/src/constant.dart#L4).


## Additional Information
For more details see example project.\
And feel free to open an issue if you find any bugs or errors or suggestions for adding to phone number parsing or phone countries data.
