# phone_number_mask
The package provides simple parsing of phone numbers and various masking options.
The masks used must be formatted with #: "+## (##) ####"

## Motivation
Some APIs provide phone numbers in a format without masks, while the application client must figure out what mask to apply to a given phone number and use it for display.

## Class API
**targetMask** - a mask that will be used to bypass phone number parsing to overlay all phone numbers.
Use this field to use only one mask for all used phone numbers.

**defaultMask** - a mask that will be used in case the phone number is not recognized.
If this field is not specified, the class will use the default mask "+### ### #### ####".

**endlessPhoneNumber** - a flag that does not truncate the last part of the phone number if it exceeds the length of the mask.

```dart
final PhoneNumberMask _phoneNumberMask = PhoneNumberMask(
    targetMask: "+## #### ######",
    defaultMask: "+### (###) ### ####",
    endlessPhoneNumber: true,
);
```

## Usage
The single "apply" method does all the parsing work.
```dart
  final PhoneNumberMask _phoneNumberMask = PhoneNumberMask();
  final PhoneNumberMaskResult _result = _phoneNumberMask.apply(phoneNumber: "4492330323912034");
  print(_result0.phoneNumberMasked); // +44 9233 032391
  print(_result0.countryTitle); // United Kingdom
  print(_result0.phoneCode); // 44
  print(_result0.iso2Code); // GB
  print(_result0.mask); // +## #### ######
```

## Additional information
For more details see example project. And feel free to open an issue if you find any bugs or errors.
