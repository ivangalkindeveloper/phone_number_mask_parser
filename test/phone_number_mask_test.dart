import 'package:phone_number_mask/phone_number_mask.dart';
import 'package:test/test.dart';

void main() {
  test("Checking mask", () {
    final PhoneNumberMask _phoneNumberMask = PhoneNumberMask();

    const String _phone0 = "4492330323912034";
    final PhoneNumberMaskResult _result0 = _phoneNumberMask.apply(phoneNumber: _phone0);
    expect(_result0.phoneNumberMasked, "+44 9233 032391");
    expect(_result0.countryTitle, "United Kingdom");
    expect(_result0.phoneCode, "44");
    expect(_result0.iso2Code, "GB");
    expect(_result0.mask, "+## #### ######");

    const String _phone1 = "168491012345120455";
    final PhoneNumberMaskResult _result1 = _phoneNumberMask.apply(phoneNumber: _phone1);
    expect(_result1.phoneNumberMasked, "+1 (684) 910 1234");
    expect(_result1.countryTitle, "American Samoa");
    expect(_result1.phoneCode, "1684");
    expect(_result1.iso2Code, "AS");
    expect(_result1.mask, "+# (###) ### ####");

    const String _phone2 = "898491012345120455";
    final PhoneNumberMaskResult _result2 = _phoneNumberMask.apply(phoneNumber: _phone2);
    expect(_result2.phoneNumberMasked, "+7 (984) 910-12-34");
    expect(_result2.countryTitle, "Russian Federation");
    expect(_result2.phoneCode, "7");
    expect(_result2.iso2Code, "RU");
    expect(_result2.mask, "+# (###) ###-##-##");

    const String _phone3 = "798491012345120455";
    final PhoneNumberMaskResult _result3 = _phoneNumberMask.apply(phoneNumber: _phone3);
    expect(_result3.phoneNumberMasked, "+7 (984) 910-12-34");
    expect(_result3.countryTitle, "Russian Federation");
    expect(_result3.phoneCode, "7");
    expect(_result3.iso2Code, "RU");
    expect(_result3.mask, "+# (###) ###-##-##");

    const String _phone4 = "778491012345120455";
    final PhoneNumberMaskResult _result4 = _phoneNumberMask.apply(phoneNumber: _phone4);
    expect(_result4.phoneNumberMasked, "+7 (784) 910 1234");
    expect(_result4.countryTitle, "Kazakhstan");
    expect(_result4.phoneCode, "7");
    expect(_result4.iso2Code, "KZ");
    expect(_result4.mask, "+# (###) ### ####");
  });

  test("Checking target mask", () {
    final PhoneNumberMask _phoneNumberMask = PhoneNumberMask(targetMask: "+## ## (####) ####");

    const String _phone5 = "930293023049495565";
    final PhoneNumberMaskResult _result5 = _phoneNumberMask.apply(phoneNumber: _phone5);
    expect(_result5.phoneNumberMasked, "+93 02 (9302) 3049");
    expect(_result5.countryTitle, null);
    expect(_result5.phoneCode, null);
    expect(_result5.iso2Code, null);
    expect(_result5.mask, null);

    const String _phone6 = "672235859394";
    final PhoneNumberMaskResult _result6 = _phoneNumberMask.apply(phoneNumber: _phone6);
    expect(_result6.phoneNumberMasked, "+67 22 (3585) 9394");
    expect(_result6.countryTitle, null);
    expect(_result6.phoneCode, null);
    expect(_result6.iso2Code, null);
    expect(_result6.mask, null);
  });

  test("Checking default mask", () {
    final PhoneNumberMask _phoneNumberMask0 = PhoneNumberMask();

    const String _phone7 = "0492330323912034";
    final PhoneNumberMaskResult _result7 = _phoneNumberMask0.apply(phoneNumber: _phone7);
    expect(_result7.phoneNumberMasked, "+049 233 0323 9120");
    expect(_result7.countryTitle, null);
    expect(_result7.phoneCode, null);
    expect(_result7.iso2Code, null);
    expect(_result7.mask, null);

    final PhoneNumberMask _phoneNumberMask1 = PhoneNumberMask(defaultMask: "+#### (####) ## ##");

    const String _phone8 = "0492330323912034";
    final PhoneNumberMaskResult _result8 = _phoneNumberMask1.apply(phoneNumber: _phone8);
    expect(_result8.phoneNumberMasked, "+0492 (3303) 23 91");
    expect(_result8.countryTitle, null);
    expect(_result8.phoneCode, null);
    expect(_result8.iso2Code, null);
    expect(_result8.mask, null);
  });

  test("Checking endless mask", () {
    final PhoneNumberMask _phoneNumberMask0 = PhoneNumberMask(isEndlessPhoneNumber: true);

    const String _phone9 = "1492330323912034";
    final PhoneNumberMaskResult _result9 = _phoneNumberMask0.apply(phoneNumber: _phone9);
    expect(_result9.phoneNumberMasked, "+1 (492) 330 3239 12034");
    expect(_result9.countryTitle, "United States");
    expect(_result9.phoneCode, "1");
    expect(_result9.iso2Code, "US");
    expect(_result9.mask, "+# (###) ### ####");

    final PhoneNumberMask _phoneNumberMask1 = PhoneNumberMask(isEndlessPhoneNumber: false);

    const String _phone10 = "3702033002300440403";
    final PhoneNumberMaskResult _result10 = _phoneNumberMask1.apply(phoneNumber: _phone10);
    expect(_result10.phoneNumberMasked, "+370 203 3002");
    expect(_result10.countryTitle, "Lithuania");
    expect(_result10.phoneCode, "370");
    expect(_result10.iso2Code, "LT");
    expect(_result10.mask, "+### ### ####");
  });

  test("Checking small number", () {
    final PhoneNumberMask _phoneNumberMask = PhoneNumberMask();

    const String _phone11 = "34566";
    final PhoneNumberMaskResult _result11 = _phoneNumberMask.apply(phoneNumber: _phone11);
    expect(_result11.phoneNumberMasked, "+3 (456) 6");
    expect(_result11.countryTitle, "Cayman Islands");
    expect(_result11.phoneCode, "345");
    expect(_result11.iso2Code, "KY");
    expect(_result11.mask, "+# (###) ### ####");
  });

  test("Checking dirty number", () {
    final PhoneNumberMask _phoneNumberMask = PhoneNumberMask(isEndlessPhoneNumber: true);

    const String _phone12 = "2513-304(30_33943_)34dsf3";
    final PhoneNumberMaskResult _result12 = _phoneNumberMask.apply(phoneNumber: _phone12);
    expect(_result12.phoneNumberMasked, "+251 33 043 0339 43343");
    expect(_result12.countryTitle, "Ethiopia");
    expect(_result12.phoneCode, "251");
    expect(_result12.iso2Code, "ET");
    expect(_result12.mask, "+### ## ### ####");
  });

  test("Checking plus flag", () {
    final PhoneNumberMask _phoneNumberMask = PhoneNumberMask(isPlus: false);

    const String _phone13 = "299307978";
    final PhoneNumberMaskResult _result13 = _phoneNumberMask.apply(phoneNumber: _phone13);
    expect(_result13.phoneNumberMasked, "299 307978");
    expect(_result13.countryTitle, "Greenland");
    expect(_result13.phoneCode, "299");
    expect(_result13.iso2Code, "GL");
    expect(_result13.mask, "+### ######");
  });
}
