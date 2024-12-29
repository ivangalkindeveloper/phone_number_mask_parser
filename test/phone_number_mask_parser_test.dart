import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';
import 'package:test/test.dart';

void main() {
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();

  test(
    "Checking mask",
    () {
      const PhoneNumberMaskParser phoneNumberMaskParser =
          PhoneNumberMaskParser();

      final PhoneNumberMaskParserResult result0 = phoneNumberMaskParser.apply(
        phoneNumber: "4492330323912034",
      );
      expect(result0.phoneNumberMasked, "+44 9233 032391");
      expect(result0.country?.title, "United Kingdom");
      expect(result0.country?.iso2Code, "GB");
      expect(result0.country?.phoneCode, "+44");
      expect(result0.country?.mask, "+## #### ######");

      final PhoneNumberMaskParserResult result1 = phoneNumberMaskParser.apply(
        phoneNumber: "168491012345120455",
      );
      expect(result1.phoneNumberMasked, "+1 (684) 910 1234");
      expect(result1.country?.title, "American Samoa");
      expect(result1.country?.iso2Code, "AS");
      expect(result1.country?.phoneCode, "+1");
      expect(result1.country?.mask, "+# (###) ### ####");

      final PhoneNumberMaskParserResult result2 = phoneNumberMaskParser.apply(
        phoneNumber: "898491012345120455",
      );
      expect(result2.phoneNumberMasked, "+7 (984) 910-12-34");
      expect(result2.country?.title, "Russian Federation");
      expect(result2.country?.iso2Code, "RU");
      expect(result2.country?.phoneCode, "+7");
      expect(result2.country?.mask, "+# (###) ###-##-##");

      final PhoneNumberMaskParserResult result3 = phoneNumberMaskParser.apply(
        phoneNumber: "798491012345120455",
      );
      expect(result3.phoneNumberMasked, "+7 (984) 910-12-34");
      expect(result3.country?.title, "Russian Federation");
      expect(result3.country?.iso2Code, "RU");
      expect(result3.country?.phoneCode, "+7");
      expect(result3.country?.mask, "+# (###) ###-##-##");

      final PhoneNumberMaskParserResult result4 = phoneNumberMaskParser.apply(
        phoneNumber: "778491012345120455",
      );
      expect(result4.phoneNumberMasked, "+7 (784) 910 1234");
      expect(result4.country?.title, "Kazakhstan");
      expect(result4.country?.iso2Code, "KZ");
      expect(result4.country?.phoneCode, "+7");
      expect(result4.country?.mask, "+# (###) ### ####");
    },
  );

  test(
    "Checking target mask",
    () {
      const PhoneNumberMaskParser phoneNumberMaskParser = PhoneNumberMaskParser(
        targetMask: "+## ## (####) ####",
      );

      final PhoneNumberMaskParserResult result0 = phoneNumberMaskParser.apply(
        phoneNumber: "930293023049495565",
      );
      expect(result0.phoneNumberMasked, "+93 02 (9302) 3049");
      expect(result0.country?.title, null);
      expect(result0.country?.iso2Code, null);
      expect(result0.country?.phoneCode, null);
      expect(result0.country?.mask, null);

      final PhoneNumberMaskParserResult result1 = phoneNumberMaskParser.apply(
        phoneNumber: "672235859394",
      );
      expect(result1.phoneNumberMasked, "+67 22 (3585) 9394");
      expect(result1.country?.title, null);
      expect(result1.country?.iso2Code, null);
      expect(result1.country?.phoneCode, null);
      expect(result1.country?.mask, null);
    },
  );

  test(
    "Checking default mask",
    () {
      const PhoneNumberMaskParser phoneNumberMaskParser0 =
          PhoneNumberMaskParser();

      final PhoneNumberMaskParserResult result0 = phoneNumberMaskParser0.apply(
        phoneNumber: "0492330323912034",
      );
      expect(result0.phoneNumberMasked, "+049 233 0323 9120");
      expect(result0.country?.title, null);
      expect(result0.country?.iso2Code, null);
      expect(result0.country?.phoneCode, null);
      expect(result0.country?.mask, null);

      const PhoneNumberMaskParser phoneNumberMaskParser1 =
          PhoneNumberMaskParser(
        defaultMask: "+#### (####) ## ##",
      );

      final PhoneNumberMaskParserResult result1 = phoneNumberMaskParser1.apply(
        phoneNumber: "0492330323912034",
      );
      expect(result1.phoneNumberMasked, "+0492 (3303) 23 91");
      expect(result1.country?.title, null);
      expect(result1.country?.iso2Code, null);
      expect(result1.country?.phoneCode, null);
      expect(result1.country?.mask, null);
    },
  );

  test(
    "Checking endless mask",
    () {
      const PhoneNumberMaskParser phoneNumberMaskParser0 =
          PhoneNumberMaskParser(
        isEndless: true,
      );

      final PhoneNumberMaskParserResult result0 = phoneNumberMaskParser0.apply(
        phoneNumber: "1492330323912034",
      );
      expect(result0.phoneNumberMasked, "+1 (492) 330 3239 12034");
      expect(result0.country?.title, "United States of America");
      expect(result0.country?.iso2Code, "US");
      expect(result0.country?.phoneCode, "+1");
      expect(result0.country?.mask, "+# (###) ### ####");

      final PhoneNumberMaskParserResult result2 = phoneNumberMaskParser0.apply(
        phoneNumber: "4201234567896",
      );
      expect(result2.phoneNumberMasked, "+420 123 456 789 6");
      expect(result2.country?.title, "Czech Republic");
      expect(result2.country?.iso2Code, "CZ");
      expect(result2.country?.phoneCode, "+420");
      expect(result2.country?.mask, "+### ### ### ###");

      const PhoneNumberMaskParser phoneNumberMaskParser1 =
          PhoneNumberMaskParser(
        isEndless: false,
      );

      final PhoneNumberMaskParserResult result1 = phoneNumberMaskParser1.apply(
        phoneNumber: "3702033002300440403",
      );
      expect(result1.phoneNumberMasked, "+370 203 3002");
      expect(result1.country?.title, "Lithuania");
      expect(result1.country?.iso2Code, "LT");
      expect(result1.country?.phoneCode, "+370");
      expect(result1.country?.mask, "+### ### ####");
    },
  );

  test(
    "Checking overriding map",
    () {
      const PhoneNumberMaskParser phoneNumberMaskParser = PhoneNumberMaskParser(
        overrideIso2CodeMask: {
          "GB": "+## #### ### ###",
          "AS": "+# ### ### ####",
          "RU": "+# ### ### ## ##",
          "KZ": "+# ### ### ####",
        },
      );

      final PhoneNumberMaskParserResult result0 = phoneNumberMaskParser.apply(
        phoneNumber: "4492330323912034",
      );
      expect(result0.phoneNumberMasked, "+44 9233 032 391");
      expect(result0.country?.title, "United Kingdom");
      expect(result0.country?.iso2Code, "GB");
      expect(result0.country?.phoneCode, "+44");
      expect(result0.country?.mask, "+## #### ######");

      final PhoneNumberMaskParserResult result1 = phoneNumberMaskParser.apply(
        phoneNumber: "168491012345120455",
      );
      expect(result1.phoneNumberMasked, "+1 684 910 1234");
      expect(result1.country?.title, "American Samoa");
      expect(result1.country?.iso2Code, "AS");
      expect(result1.country?.phoneCode, "+1");
      expect(result1.country?.mask, "+# (###) ### ####");

      final PhoneNumberMaskParserResult result2 = phoneNumberMaskParser.apply(
        phoneNumber: "898491012345120455",
      );
      expect(result2.phoneNumberMasked, "+7 984 910 12 34");
      expect(result2.country?.title, "Russian Federation");
      expect(result2.country?.iso2Code, "RU");
      expect(result2.country?.phoneCode, "+7");
      expect(result2.country?.mask, "+# (###) ###-##-##");

      final PhoneNumberMaskParserResult result3 = phoneNumberMaskParser.apply(
        phoneNumber: "798491012345120455",
      );
      expect(result3.phoneNumberMasked, "+7 984 910 12 34");
      expect(result3.country?.title, "Russian Federation");
      expect(result3.country?.iso2Code, "RU");
      expect(result3.country?.phoneCode, "+7");
      expect(result3.country?.mask, "+# (###) ###-##-##");

      final PhoneNumberMaskParserResult result4 = phoneNumberMaskParser.apply(
        phoneNumber: "778491012345120455",
      );
      expect(result4.phoneNumberMasked, "+7 784 910 1234");
      expect(result4.country?.title, "Kazakhstan");
      expect(result4.country?.iso2Code, "KZ");
      expect(result4.country?.phoneCode, "+7");
      expect(result4.country?.mask, "+# (###) ### ####");
    },
  );

  test(
    "Checking small number",
    () {
      const PhoneNumberMaskParser phoneNumberMaskParser =
          PhoneNumberMaskParser();

      final PhoneNumberMaskParserResult result0 = phoneNumberMaskParser.apply(
        phoneNumber: "34566",
      );
      expect(result0.phoneNumberMasked, "+34 566");
      expect(result0.country?.title, "Spain");
      expect(result0.country?.iso2Code, "ES");
      expect(result0.country?.phoneCode, "+34");
      expect(result0.country?.mask, "+## ### ### ###");
    },
  );

  test(
    "Checking dirty number",
    () {
      const PhoneNumberMaskParser phoneNumberMaskParser = PhoneNumberMaskParser(
        isEndless: true,
      );

      final PhoneNumberMaskParserResult result0 = phoneNumberMaskParser.apply(
        phoneNumber: "2513-304(3033943)34dsf3",
      );
      expect(result0.phoneNumberMasked, "+251 33 043 0339 43343");
      expect(result0.country?.title, "Ethiopia");
      expect(result0.country?.iso2Code, "ET");
      expect(result0.country?.phoneCode, "+251");
      expect(result0.country?.mask, "+### ## ### ####");
    },
  );

  test(
    "Checking plus flag",
    () {
      const PhoneNumberMaskParser phoneNumberMaskParser = PhoneNumberMaskParser(
        isPlus: false,
      );

      final PhoneNumberMaskParserResult result0 = phoneNumberMaskParser.apply(
        phoneNumber: "299307978",
      );
      expect(result0.phoneNumberMasked, "299 307978");
      expect(result0.country?.title, "Greenland");
      expect(result0.country?.iso2Code, "GL");
      expect(result0.country?.phoneCode, "+299");
      expect(result0.country?.mask, "+### ######");
    },
  );

  stopwatch.stop();
}
