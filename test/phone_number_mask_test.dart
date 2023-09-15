import 'package:phone_number_mask/phone_number_mask.dart';
import 'package:test/test.dart';

void main() {
  test("Checking mask", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask();

    final PhoneNumberMaskResult result0 = phoneNumberMask.apply(
      phoneNumber: "4492330323912034",
    );
    expect(result0.phoneNumberMasked, "+44 9233 032391");
    expect(result0.countryTitle, "United Kingdom");
    expect(result0.iso2Code, "GB");
    expect(result0.phoneCode, "+44");
    expect(result0.mask, "+## #### ######");

    final PhoneNumberMaskResult result1 = phoneNumberMask.apply(
      phoneNumber: "168491012345120455",
    );
    expect(result1.phoneNumberMasked, "+1 (684) 910 1234");
    expect(result1.countryTitle, "American Samoa");
    expect(result1.iso2Code, "AS");
    expect(result1.phoneCode, "+1");
    expect(result1.mask, "+# (###) ### ####");

    final PhoneNumberMaskResult result2 = phoneNumberMask.apply(
      phoneNumber: "898491012345120455",
    );
    expect(result2.phoneNumberMasked, "+7 (984) 910-12-34");
    expect(result2.countryTitle, "Russian Federation");
    expect(result2.iso2Code, "RU");
    expect(result2.phoneCode, "+7");
    expect(result2.mask, "+# (###) ###-##-##");

    final PhoneNumberMaskResult result3 = phoneNumberMask.apply(
      phoneNumber: "798491012345120455",
    );
    expect(result3.phoneNumberMasked, "+7 (984) 910-12-34");
    expect(result3.countryTitle, "Russian Federation");
    expect(result3.iso2Code, "RU");
    expect(result3.phoneCode, "+7");
    expect(result3.mask, "+# (###) ###-##-##");

    final PhoneNumberMaskResult result4 = phoneNumberMask.apply(
      phoneNumber: "778491012345120455",
    );
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

    final PhoneNumberMaskResult result0 = phoneNumberMask.apply(
      phoneNumber: "930293023049495565",
    );
    expect(result0.phoneNumberMasked, "+93 02 (9302) 3049");
    expect(result0.countryTitle, null);
    expect(result0.iso2Code, null);
    expect(result0.phoneCode, null);
    expect(result0.mask, null);

    final PhoneNumberMaskResult result1 = phoneNumberMask.apply(
      phoneNumber: "672235859394",
    );
    expect(result1.phoneNumberMasked, "+67 22 (3585) 9394");
    expect(result1.countryTitle, null);
    expect(result1.iso2Code, null);
    expect(result1.phoneCode, null);
    expect(result1.mask, null);
  });

  test("Checking default mask", () {
    final PhoneNumberMask phoneNumberMask0 = PhoneNumberMask();

    final PhoneNumberMaskResult result0 = phoneNumberMask0.apply(
      phoneNumber: "0492330323912034",
    );
    expect(result0.phoneNumberMasked, "+049 233 0323 9120");
    expect(result0.countryTitle, null);
    expect(result0.iso2Code, null);
    expect(result0.phoneCode, null);
    expect(result0.mask, null);

    final PhoneNumberMask phoneNumberMask1 = PhoneNumberMask(
      defaultMask: "+#### (####) ## ##",
    );

    final PhoneNumberMaskResult result1 = phoneNumberMask1.apply(
      phoneNumber: "0492330323912034",
    );
    expect(result1.phoneNumberMasked, "+0492 (3303) 23 91");
    expect(result1.countryTitle, null);
    expect(result1.iso2Code, null);
    expect(result1.phoneCode, null);
    expect(result1.mask, null);
  });

  test("Checking endless mask", () {
    final PhoneNumberMask phoneNumberMask0 = PhoneNumberMask(
      isEndlessPhoneNumber: true,
    );

    final PhoneNumberMaskResult result0 = phoneNumberMask0.apply(
      phoneNumber: "1492330323912034",
    );
    expect(result0.phoneNumberMasked, "+1 (492) 330 3239 12034");
    expect(result0.countryTitle, "United States");
    expect(result0.iso2Code, "US");
    expect(result0.phoneCode, "+1");
    expect(result0.mask, "+# (###) ### ####");

    final PhoneNumberMaskResult result2 = phoneNumberMask0.apply(
      phoneNumber: "4201234567896",
    );
    expect(result2.phoneNumberMasked, "+420 123 456 789 6");
    expect(result2.countryTitle, "Czech Republic");
    expect(result2.iso2Code, "CZ");
    expect(result2.phoneCode, "+420");
    expect(result2.mask, "+### ### ### ###");

    final PhoneNumberMask phoneNumberMask1 = PhoneNumberMask(
      isEndlessPhoneNumber: false,
    );

    final PhoneNumberMaskResult result1 = phoneNumberMask1.apply(
      phoneNumber: "3702033002300440403",
    );
    expect(result1.phoneNumberMasked, "+370 203 3002");
    expect(result1.countryTitle, "Lithuania");
    expect(result1.iso2Code, "LT");
    expect(result1.phoneCode, "+370");
    expect(result1.mask, "+### ### ####");
  });

  test("Checking small number", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask();

    final PhoneNumberMaskResult result0 = phoneNumberMask.apply(
      phoneNumber: "34566",
    );
    expect(result0.phoneNumberMasked, "+34 566");
    expect(result0.countryTitle, "Spain");
    expect(result0.iso2Code, "ES");
    expect(result0.phoneCode, "+34");
    expect(result0.mask, "+## ### ### ###");
  });

  test("Checking dirty number", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask(
      isEndlessPhoneNumber: true,
    );

    final PhoneNumberMaskResult result0 = phoneNumberMask.apply(
      phoneNumber: "2513-304(3033943)34dsf3",
    );
    expect(result0.phoneNumberMasked, "+251 33 043 0339 43343");
    expect(result0.countryTitle, "Ethiopia");
    expect(result0.iso2Code, "ET");
    expect(result0.phoneCode, "+251");
    expect(result0.mask, "+### ## ### ####");
  });

  test("Checking plus flag", () {
    final PhoneNumberMask phoneNumberMask = PhoneNumberMask(
      isPlus: false,
    );

    final PhoneNumberMaskResult result0 = phoneNumberMask.apply(
      phoneNumber: "299307978",
    );
    expect(result0.phoneNumberMasked, "299 307978");
    expect(result0.countryTitle, "Greenland");
    expect(result0.iso2Code, "GL");
    expect(result0.phoneCode, "299");
    expect(result0.mask, "+### ######");
  });
}
