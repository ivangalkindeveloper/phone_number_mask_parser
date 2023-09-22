# Phone number mask parser
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
The package has the only main class to use - [PhoneNumberMaskParser](https://github.com/ivangalkindeveloper/phone_number_mask_parser/blob/master/lib/src/phone_number_mask_parser.dart#L9):

| Data type | Name | Description | Default value |
|-----------|------|-------------|---------------|
| **String?** | **targetMask** | The mask that will be used to bypass phone number parsing to overlay all phone numbers. Use this field to use only one mask for all phone numbers. | **null** |
| **String?** | **defaultMask** | The mask that will be used in case the phone number is not recognized. If this field is not specified, the class will use the default mask "+### ### #### ####". | **"+### ### #### ####"** |
| **bool** | **isPlus** | The flag responsible for the plus sign at the very beginning. | **true** |
| **bool** | **isEndless** | the flag that doesn't cut the last part of the phone number if it exceeds the length of the mask. | **false** |

```dart
const PhoneNumberMaskParser maskParser = PhoneNumberMaskParser(
    targetMask: "+## #### ######",
    defaultMask: "+### (###) ### ####",
    isPlus: false,
    isEndless: true,
);
```

### Main Method
The main method [apply](https://github.com/ivangalkindeveloper/phone_number_mask_parser/blob/master/lib/src/phone_number_mask_parser.dart#L34) does all the parsing work.

```dart
  const PhoneNumberMaskParser maskParser = PhoneNumberMaskParser();
  final PhoneNumberMaskParserResult result = maskParser.apply(phoneNumber: "4492330323912034");
  print(result.PhoneNumberMaskParsered); // +44 9233 032391
  print(result.country?.title); // United Kingdom
  print(result.country?.iso2Code); // GB
  print(result.country?.phoneCode); // 44
  print(result.country?.alternativePhoneCodes); // [+447]
  print(result.country?.mask); // +## #### ######
```

### Result
The result is a separate class [PhoneNumberMaskParserResult](https://github.com/ivangalkindeveloper/phone_number_mask_parser/blob/master/lib/src/data.dart#L15) that provides the following fields:

| Data type | Name | Description |
|-----------|------|-------------|
| **String** | **phoneNumberMasked** | Formatted phone number in mask. |
| **PhoneNumberMaskParserCountry?** | **country** | Country of parsered phone number. |

Country of parsered phone number [PhoneNumberMaskParserCountry](https://github.com/ivangalkindeveloper/phone_number_mask_parser/blob/master/lib/src/domain/entity/phone_number_mask_parser_result.dart#L15):
| Data type | Name | Description |
|-----------|------|-------------|
| **String** | **title** | Name of the country of the phone. |
| **String** | **iso2Code** | Country code according to ISO 3166 standard. |
| **String** | **phoneCode** | Phone country code. |
| **List<String>** | **alternativePhoneCodes** | Alternative phone country code. |
| **String** | **mask** | The mask of this number in its pure form. |

### Efficiency
Determining the country by the potential telephone code using hash table - O(1).
Overlaying a target or recognized country mask - O(N).
(N - length of the recognized phone number string)

## Additional Objects
Additionally, the package provides a constant list of country objects for its own use - [PhoneNumberMaskParser.countries](https://github.com/ivangalkindeveloper/phone_number_mask_parser/blob/master/lib/src/domain/entity/phone_number_mask_parser_constant.dart#L7).


## Additional Information
For more details see example project.\
And feel free to open an issue if you find any bugs or errors or suggestions for adding to phone number parsing or phone countries data.
