import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';

void main() {
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();

  const String phone0 = "4492330323912034";
  const PhoneNumberMaskParser PhoneNumberMaskParser0 = PhoneNumberMaskParser();
  final PhoneNumberMaskParserResult result0 = PhoneNumberMaskParser0.apply(
    phoneNumber: phone0,
  );
  print(phone0);
  print(result0.PhoneNumberMaskParsered);
  print(result0.country?.title);
  print(result0.country?.iso2Code);
  print(result0.country?.phoneCode);
  print(result0.country?.mask);
  print("\n");

  const String phone1 = "168491012345120455";
  final PhoneNumberMaskParserResult result1 = PhoneNumberMaskParser0.apply(
    phoneNumber: phone1,
  );
  print(phone1);
  print(result1.PhoneNumberMaskParsered);
  print(result1.country?.title);
  print(result1.country?.iso2Code);
  print(result1.country?.phoneCode);
  print(result1.country?.mask);
  print("\n");

  const String phone2 = "898491012345120455";
  final PhoneNumberMaskParserResult result2 = PhoneNumberMaskParser0.apply(
    phoneNumber: phone2,
  );
  print(phone2);
  print(result2.PhoneNumberMaskParsered);
  print(result2.country?.title);
  print(result2.country?.iso2Code);
  print(result2.country?.phoneCode);
  print(result2.country?.mask);
  print("\n");

  const String phone3 = "798491012345120455";
  final PhoneNumberMaskParserResult result3 = PhoneNumberMaskParser0.apply(
    phoneNumber: phone3,
  );
  print(phone3);
  print(result3.PhoneNumberMaskParsered);
  print(result3.country?.title);
  print(result3.country?.iso2Code);
  print(result3.country?.phoneCode);
  print(result3.country?.mask);
  print("\n");

  const String phone4 = "778491012345120455";
  final PhoneNumberMaskParserResult result4 = PhoneNumberMaskParser0.apply(
    phoneNumber: phone4,
  );
  print(phone4);
  print(result4.PhoneNumberMaskParsered);
  print(result4.country?.title);
  print(result4.country?.iso2Code);
  print(result4.country?.phoneCode);
  print(result4.country?.mask);
  print("\n");

  const String phone5 = "930293023049495565";
  const PhoneNumberMaskParser PhoneNumberMaskParser1 = PhoneNumberMaskParser(
    targetMask: "+## ## (####) ####",
  );
  final PhoneNumberMaskParserResult result5 = PhoneNumberMaskParser1.apply(
    phoneNumber: phone5,
  );
  print(phone5);
  print(result5.PhoneNumberMaskParsered);
  print(result5.country?.title);
  print(result5.country?.iso2Code);
  print(result5.country?.phoneCode);
  print(result5.country?.mask);
  print("\n");

  const String phone6 = "672235859394";
  final PhoneNumberMaskParserResult result6 = PhoneNumberMaskParser1.apply(
    phoneNumber: phone6,
  );
  print(phone6);
  print(result6.PhoneNumberMaskParsered);
  print(result6.country?.title);
  print(result6.country?.iso2Code);
  print(result6.country?.phoneCode);
  print(result6.country?.mask);
  print("\n");

  const String phone7 = "0492330323912034";
  const PhoneNumberMaskParser PhoneNumberMaskParser2 = PhoneNumberMaskParser();
  final PhoneNumberMaskParserResult result7 = PhoneNumberMaskParser2.apply(
    phoneNumber: phone7,
  );
  print(phone7);
  print(result7.PhoneNumberMaskParsered);
  print(result7.country?.title);
  print(result7.country?.iso2Code);
  print(result7.country?.phoneCode);
  print(result7.country?.mask);
  print("\n");

  const String phone8 = "0492330323912034";
  const PhoneNumberMaskParser PhoneNumberMaskParser3 = PhoneNumberMaskParser(
    defaultMask: "+#### (####) ## ##",
  );
  final PhoneNumberMaskParserResult result8 = PhoneNumberMaskParser3.apply(
    phoneNumber: phone8,
  );
  print(phone8);
  print(result8.PhoneNumberMaskParsered);
  print(result8.country?.title);
  print(result8.country?.iso2Code);
  print(result8.country?.phoneCode);
  print(result8.country?.mask);
  print("\n");

  const String phone9 = "1492330323912034";
  const PhoneNumberMaskParser PhoneNumberMaskParser4 = PhoneNumberMaskParser(
    isEndless: true,
  );
  final PhoneNumberMaskParserResult result9 = PhoneNumberMaskParser4.apply(
    phoneNumber: phone9,
  );
  print(phone9);
  print(result9.PhoneNumberMaskParsered);
  print(result9.country?.title);
  print(result9.country?.iso2Code);
  print(result9.country?.phoneCode);
  print(result9.country?.mask);
  print("\n");

  const String phone10 = "3702033002300440403";
  const PhoneNumberMaskParser PhoneNumberMaskParser5 = PhoneNumberMaskParser(
    isEndless: false,
  );
  final PhoneNumberMaskParserResult result10 = PhoneNumberMaskParser5.apply(
    phoneNumber: phone10,
  );
  print(phone10);
  print(result10.PhoneNumberMaskParsered);
  print(result10.country?.title);
  print(result10.country?.iso2Code);
  print(result10.country?.phoneCode);
  print(result10.country?.mask);
  print("\n");

  stopwatch.stop();
  print(stopwatch.elapsedMicroseconds);
}
