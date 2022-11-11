import 'package:phone_number_mask/phone_number_mask.dart';

void main() {
  final PhoneNumberMask _phoneNumberMask0 = PhoneNumberMask();
  final PhoneNumberMaskResult _result0 = _phoneNumberMask0.apply(phoneNumber: "4492330323912034");
  print(_result0.phoneNumberMasked);
  print(_result0.countryTitle);
  print(_result0.phoneCode);
  print(_result0.iso2Code);
  print(_result0.mask);
  print("\n");
  final PhoneNumberMaskResult _result1 = _phoneNumberMask0.apply(phoneNumber: "168491012345120455");
  print(_result1.phoneNumberMasked);
  print(_result1.countryTitle);
  print(_result1.phoneCode);
  print(_result1.iso2Code);
  print(_result1.mask);
  print("\n");
  final PhoneNumberMaskResult _result2 = _phoneNumberMask0.apply(phoneNumber: "898491012345120455");
  print(_result2.phoneNumberMasked);
  print(_result2.countryTitle);
  print(_result2.phoneCode);
  print(_result2.iso2Code);
  print(_result2.mask);
  print("\n");
  final PhoneNumberMaskResult _result3 = _phoneNumberMask0.apply(phoneNumber: "778491012345120455");
  print(_result3.phoneNumberMasked);
  print(_result3.countryTitle);
  print(_result3.phoneCode);
  print(_result3.iso2Code);
  print(_result3.mask);
  print("\n");

  final PhoneNumberMask _phoneNumberMask1 = PhoneNumberMask(targetMask: "+00 00 (0000) 0000");
  final PhoneNumberMaskResult _result4 = _phoneNumberMask1.apply(phoneNumber: "930293023049495565");
  print(_result4.phoneNumberMasked);
  print(_result4.countryTitle);
  print(_result4.phoneCode);
  print(_result4.iso2Code);
  print(_result4.mask);
  print("\n");
  final PhoneNumberMaskResult _result5 = _phoneNumberMask1.apply(phoneNumber: "672235859394");
  print(_result5.phoneNumberMasked);
  print(_result5.countryTitle);
  print(_result5.phoneCode);
  print(_result5.iso2Code);
  print(_result5.mask);
  print("\n");

  final PhoneNumberMask _phoneNumberMask2 = PhoneNumberMask(); //"+000 000 0000 0000"
  final PhoneNumberMaskResult _result6 = _phoneNumberMask2.apply(phoneNumber: "0492330323912034");
  print(_result6.phoneNumberMasked);
  print(_result6.countryTitle);
  print(_result6.phoneCode);
  print(_result6.iso2Code);
  print(_result6.mask);
  print("\n");

  final PhoneNumberMask _phoneNumberMask3 = PhoneNumberMask(defaultMask: "+0000 (0000) 00 00");
  final PhoneNumberMaskResult _result7 = _phoneNumberMask3.apply(phoneNumber: "0492330323912034");
  print(_result7.phoneNumberMasked);
  print(_result7.countryTitle);
  print(_result7.phoneCode);
  print(_result7.iso2Code);
  print(_result7.mask);
  print("\n");

  final PhoneNumberMask _phoneNumberMask4 = PhoneNumberMask(endlessPhoneNumber: true);
  final PhoneNumberMaskResult _result8 = _phoneNumberMask4.apply(phoneNumber: "1492330323912034");
  print(_result8.phoneNumberMasked);
  print(_result8.countryTitle);
  print(_result8.phoneCode);
  print(_result8.iso2Code);
  print(_result8.mask);
  print("\n");

  final PhoneNumberMask _phoneNumberMask5 = PhoneNumberMask(endlessPhoneNumber: false);
  final PhoneNumberMaskResult _result9 = _phoneNumberMask5.apply(phoneNumber: "3702033002300440403");
  print(_result9.phoneNumberMasked);
  print(_result9.countryTitle);
  print(_result9.phoneCode);
  print(_result9.iso2Code);
  print(_result9.mask);
  print("\n");
}
