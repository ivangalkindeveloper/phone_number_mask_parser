# phone_number_mask
The package provides a simple parsing of phone numbers and various masking options.\
The used masks must be formatted with "#" symbol, for example: "+## (##) ####".

## Motivation
Some server APIs provide unformatted phone numbers, while the application client must figure out what mask to apply to a given phone number and use it for display.

## Usage
### Main class
The package has the only main class to use - **PhoneNumberMask**.\
**String? targetMask** - a mask that will be used to bypass phone number parsing to overlay all phone numbers.\
Use this field to use only one mask for all phone numbers.\
**String? defaultMask** - a mask that will be used in case the phone number is not recognized.\
If this field is not specified, the class will use the default mask "+### ### #### ####".\
**bool endlessPhoneNumber** - a flag that doesn't cut the last part of the phone number if it exceeds the length of the mask.\
Default value - false.

```dart
final PhoneNumberMask _phoneNumberMask = PhoneNumberMask(
    targetMask: "+## #### ######",
    defaultMask: "+### (###) ### ####",
    endlessPhoneNumber: true,
);
```

### Main method
The main method **apply()** does all the parsing work.\
The result is a separate class **PhoneNumberMaskResult** that provides the following fields:\
**String phoneNumberMasked** - formatted phone number.\
**String? countryTitle** - name of the country of the phone.\
**String? phoneCode** - phone country code.\
**String? iso2Code** - country code according to ISO 3166 standard.\
**String? mask** - the mask of this number in its pure form.

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
Additionally, the package provides a constant list of country objects for its own use - **PhoneNumberMask.countries**.


## Additional information
For more details see example project.\
And feel free to open an issue if you find any bugs or errors.
