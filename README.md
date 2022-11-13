# Phone number mask
The package provides a simple parsing of phone numbers and various masking options.\
The used masks must be formatted with "#" symbol, for example: "+## (##) ####".

## Motivation
Some server APIs provide unformatted phone numbers, while the application client must figure out what mask to apply to a given phone number and use it for display.

## Usage
### Main class
The package has the only main class to use - [PhoneNumberMask](https://github.com/ivangalkindeveloper/phone_number_mask/blob/master/lib/src/phone_number_mask.dart#L8):
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

### Main method and result
The main method [apply](https://github.com/ivangalkindeveloper/phone_number_mask/blob/master/lib/src/phone_number_mask.dart#L32) does all the parsing work.\
The result is a separate class [PhoneNumberMaskResult](https://github.com/ivangalkindeveloper/phone_number_mask/blob/master/lib/src/data.dart#L15) that provides the following fields:
| Data type | Name | Description |
|-----------|------|-------------|
| **String** | **phoneNumberMasked** | Formatted phone number. |
| **String?** | **countryTitle** | Name of the country of the phone. |
| **String?** | **phoneCode** | Phone country code. |
| **String?** | **iso2Code** | Country code according to ISO 3166 standard. |
| **String?** | **mask** | The mask of this number in its pure form. |

### Example:
```dart
  final PhoneNumberMask _phoneNumberMask = PhoneNumberMask();
  final PhoneNumberMaskResult _result = _phoneNumberMask.apply(phoneNumber: "4492330323912034");
  print(_result.phoneNumberMasked); // +44 9233 032391
  print(_result.countryTitle); // United Kingdom
  print(_result.phoneCode); // 44
  print(_result.iso2Code); // GB
  print(_result.mask); // +## #### ######
```

## Additional objects
Additionally, the package provides a constant list of country objects for its own use - [PhoneNumberMask.countries](https://github.com/ivangalkindeveloper/phone_number_mask/blob/master/lib/src/constant.dart#L4).


## Additional information
For more details see example project.\
And feel free to open an issue if you find any bugs or errors or suggestions.
