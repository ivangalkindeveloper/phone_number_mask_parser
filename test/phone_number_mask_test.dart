import 'package:phone_number_mask/phone_number_mask.dart';
import 'package:test/test.dart';

void main() {
  test("Checking mask", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask();

    const String phone0 = "4492330323912034";
    final PhoneNumberMaskResult result0 =
        phoneNumberMask.apply(phoneNumber: phone0);
    expect(result0.phoneNumberMasked, "+44 9233 032391");
    expect(result0.countryTitle, "United Kingdom");
    expect(result0.iso2Code, "GB");
    expect(result0.phoneCode, "+44");
    expect(result0.mask, "+## #### ######");

    const String phone1 = "168491012345120455";
    final PhoneNumberMaskResult result1 =
        phoneNumberMask.apply(phoneNumber: phone1);
    expect(result1.phoneNumberMasked, "+1 (684) 910 1234");
    expect(result1.countryTitle, "American Samoa");
    expect(result1.iso2Code, "AS");
    expect(result1.phoneCode, "+1");
    expect(result1.mask, "+# (###) ### ####");

    const String phone2 = "898491012345120455";
    final PhoneNumberMaskResult result2 =
        phoneNumberMask.apply(phoneNumber: phone2);
    expect(result2.phoneNumberMasked, "+7 (984) 910-12-34");
    expect(result2.countryTitle, "Russian Federation");
    expect(result2.iso2Code, "RU");
    expect(result2.phoneCode, "+7");
    expect(result2.mask, "+# (###) ###-##-##");

    const String phone3 = "798491012345120455";
    final PhoneNumberMaskResult result3 =
        phoneNumberMask.apply(phoneNumber: phone3);
    expect(result3.phoneNumberMasked, "+7 (984) 910-12-34");
    expect(result3.countryTitle, "Russian Federation");
    expect(result3.iso2Code, "RU");
    expect(result3.phoneCode, "+7");
    expect(result3.mask, "+# (###) ###-##-##");

    const String phone4 = "778491012345120455";
    final PhoneNumberMaskResult result4 =
        phoneNumberMask.apply(phoneNumber: phone4);
    expect(result4.phoneNumberMasked, "+7 (784) 910 1234");
    expect(result4.countryTitle, "Kazakhstan");
    expect(result4.iso2Code, "KZ");
    expect(result4.phoneCode, "+7");
    expect(result4.mask, "+# (###) ### ####");
  });

  test("Checking target mask", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask(
      targetMask: "+## ## (####) ####",
    );

    const String phone5 = "930293023049495565";
    final PhoneNumberMaskResult result5 =
        phoneNumberMask.apply(phoneNumber: phone5);
    expect(result5.phoneNumberMasked, "+93 02 (9302) 3049");
    expect(result5.countryTitle, null);
    expect(result5.iso2Code, null);
    expect(result5.phoneCode, null);
    expect(result5.mask, null);

    const String phone6 = "672235859394";
    final PhoneNumberMaskResult result6 =
        phoneNumberMask.apply(phoneNumber: phone6);
    expect(result6.phoneNumberMasked, "+67 22 (3585) 9394");
    expect(result6.countryTitle, null);
    expect(result6.iso2Code, null);
    expect(result6.phoneCode, null);
    expect(result6.mask, null);
  });

  test("Checking default mask", () {
    final PhoneNumberMask phoneNumberMask0 = PhoneNumberMask();

    const String phone7 = "0492330323912034";
    final PhoneNumberMaskResult result7 =
        phoneNumberMask0.apply(phoneNumber: phone7);
    expect(result7.phoneNumberMasked, "+049 233 0323 9120");
    expect(result7.countryTitle, null);
    expect(result7.iso2Code, null);
    expect(result7.phoneCode, null);
    expect(result7.mask, null);

    final PhoneNumberMask phoneNumberMask1 = PhoneNumberMask(
      defaultMask: "+#### (####) ## ##",
    );

    const String phone8 = "0492330323912034";
    final PhoneNumberMaskResult result8 =
        phoneNumberMask1.apply(phoneNumber: phone8);
    expect(result8.phoneNumberMasked, "+0492 (3303) 23 91");
    expect(result8.countryTitle, null);
    expect(result8.iso2Code, null);
    expect(result8.phoneCode, null);
    expect(result8.mask, null);
  });

  test("Checking endless mask", () {
    final PhoneNumberMask phoneNumberMask0 = PhoneNumberMask(
      isEndlessPhoneNumber: true,
    );

    const String phone9 = "1492330323912034";
    final PhoneNumberMaskResult result9 =
        phoneNumberMask0.apply(phoneNumber: phone9);
    expect(result9.phoneNumberMasked, "+1 (492) 330 3239 12034");
    expect(result9.countryTitle, "United States");
    expect(result9.iso2Code, "US");
    expect(result9.phoneCode, "+1");
    expect(result9.mask, "+# (###) ### ####");

    final PhoneNumberMask phoneNumberMask1 = PhoneNumberMask(
      isEndlessPhoneNumber: false,
    );

    const String phone10 = "3702033002300440403";
    final PhoneNumberMaskResult result10 =
        phoneNumberMask1.apply(phoneNumber: phone10);
    expect(result10.phoneNumberMasked, "+370 203 3002");
    expect(result10.countryTitle, "Lithuania");
    expect(result10.iso2Code, "LT");
    expect(result10.phoneCode, "+370");
    expect(result10.mask, "+### ### ####");
  });

  test("Checking small number", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask();

    const String phone11 = "34566";
    final PhoneNumberMaskResult result11 =
        phoneNumberMask.apply(phoneNumber: phone11);
    expect(result11.phoneNumberMasked, "+34 566");
    expect(result11.countryTitle, "Spain");
    expect(result11.iso2Code, "ES");
    expect(result11.phoneCode, "+34");
    expect(result11.mask, "+## ### ### ###");
  });

  test("Checking dirty number", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask(
      isEndlessPhoneNumber: true,
    );

    const String phone12 = "2513-304(3033943)34dsf3";
    final PhoneNumberMaskResult result12 =
        phoneNumberMask.apply(phoneNumber: phone12);
    expect(result12.phoneNumberMasked, "+251 33 043 0339 43343");
    expect(result12.countryTitle, "Ethiopia");
    expect(result12.iso2Code, "ET");
    expect(result12.phoneCode, "+251");
    expect(result12.mask, "+### ## ### ####");
  });

  test("Checking plus flag", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask(
      isPlus: false,
    );

    const String phone13 = "299307978";
    final PhoneNumberMaskResult result13 =
        phoneNumberMask.apply(phoneNumber: phone13);
    expect(result13.phoneNumberMasked, "299 307978");
    expect(result13.countryTitle, "Greenland");
    expect(result13.iso2Code, "GL");
    expect(result13.phoneCode, "299");
    expect(result13.mask, "+### ######");
  });
}
