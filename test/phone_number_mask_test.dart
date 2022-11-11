import 'package:phone_number_mask/phone_number_mask.dart';
import 'package:test/test.dart';

void main() {
  test("Checking mask", () {
    final PhoneNumberMask _phoneNumberMask = PhoneNumberMask();
    final PhoneNumberMaskResult _result0 = _phoneNumberMask.apply(phoneNumber: "4492330323912034");
    expect(_result0.phoneNumberMasked, "+44 9233 032391");
    expect(_result0.countryTitle, "United Kingdom");
    expect(_result0.phoneCode, "44");
    expect(_result0.iso2Code, "GB");
    expect(_result0.mask, "+## #### ######");

    final PhoneNumberMaskResult _result1 = _phoneNumberMask.apply(phoneNumber: "168491012345120455");
    expect(_result1.phoneNumberMasked, "+1 (684) 910 1234");
    expect(_result1.countryTitle, "American Samoa");
    expect(_result1.phoneCode, "1684");
    expect(_result1.iso2Code, "AS");
    expect(_result1.mask, "+# (###) ### ####");

    final PhoneNumberMaskResult _result2 = _phoneNumberMask.apply(phoneNumber: "898491012345120455");
    expect(_result2.phoneNumberMasked, "+7 (984) 910-12-34");
    expect(_result2.countryTitle, "Russian Federation");
    expect(_result2.phoneCode, "7");
    expect(_result2.iso2Code, "RU");
    expect(_result2.mask, "+# (###) ###-##-##");

    final PhoneNumberMaskResult _result3 = _phoneNumberMask.apply(phoneNumber: "778491012345120455");
    expect(_result3.phoneNumberMasked, "+7 (784) 910 1234");
    expect(_result3.countryTitle, "Kazakhstan");
    expect(_result3.phoneCode, "7");
    expect(_result3.iso2Code, "KZ");
    expect(_result3.mask, "+# (###) ### ####");
  });

  test("Checking target mask", () {
    final PhoneNumberMask _phoneNumberMask = PhoneNumberMask(targetMask: "+## ## (####) ####");
    final PhoneNumberMaskResult _result0 = _phoneNumberMask.apply(phoneNumber: "930293023049495565");
    expect(_result0.phoneNumberMasked, "+93 02 (9302) 3049");
    expect(_result0.countryTitle, null);
    expect(_result0.phoneCode, null);
    expect(_result0.iso2Code, null);
    expect(_result0.mask, null);

    final PhoneNumberMaskResult _result1 = _phoneNumberMask.apply(phoneNumber: "672235859394");
    expect(_result1.phoneNumberMasked, "+67 22 (3585) 9394");
    expect(_result1.countryTitle, null);
    expect(_result1.phoneCode, null);
    expect(_result1.iso2Code, null);
    expect(_result1.mask, null);
  });

  test("Checking default mask", () {
    final PhoneNumberMask _phoneNumberMask0 = PhoneNumberMask(); //"+000 000 0000 0000"
    final PhoneNumberMaskResult _result0 = _phoneNumberMask0.apply(phoneNumber: "0492330323912034");
    expect(_result0.phoneNumberMasked, "+049 233 0323 9120");
    expect(_result0.countryTitle, null);
    expect(_result0.phoneCode, null);
    expect(_result0.iso2Code, null);
    expect(_result0.mask, null);

    final PhoneNumberMask _phoneNumberMask1 = PhoneNumberMask(defaultMask: "+#### (####) ## ##");
    final PhoneNumberMaskResult _result1 = _phoneNumberMask1.apply(phoneNumber: "0492330323912034");
    expect(_result1.phoneNumberMasked, "+0492 (3303) 23 91");
    expect(_result1.countryTitle, null);
    expect(_result1.phoneCode, null);
    expect(_result1.iso2Code, null);
    expect(_result1.mask, null);
  });

  test("Checking endless mask", () {
    final PhoneNumberMask _phoneNumberMask0 = PhoneNumberMask(endlessPhoneNumber: true);
    final PhoneNumberMaskResult _result0 = _phoneNumberMask0.apply(phoneNumber: "1492330323912034");
    expect(_result0.phoneNumberMasked, "+1 (492) 330 3239 12034");
    expect(_result0.countryTitle, "United States");
    expect(_result0.phoneCode, "1");
    expect(_result0.iso2Code, "US");
    expect(_result0.mask, "+# (###) ### ####");

    final PhoneNumberMask _phoneNumberMask1 = PhoneNumberMask(endlessPhoneNumber: false);
    final PhoneNumberMaskResult _result1 = _phoneNumberMask1.apply(phoneNumber: "3702033002300440403");
    expect(_result1.phoneNumberMasked, "+370 203 3002");
    expect(_result1.countryTitle, "Lithuania");
    expect(_result1.phoneCode, "370");
    expect(_result1.iso2Code, "LT");
    expect(_result1.mask, "+### ### ####");
  });
}
