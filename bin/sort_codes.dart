import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';
import 'dart:io';

main() async {
  final File file = File('phone_number_mask_parser_constant.dart');
  final IOSink sink = file.openWrite();

  final List<PhoneNumberMaskParserCountry> countries =
      List.from(PhoneNumberMaskParserConstant.countries);

  countries.sort((country0, country1) =>
      int.parse(country0.phoneCode.replaceAll(RegExp(r'[^0-9]'), "")).compareTo(
          int.parse(country1.phoneCode.replaceAll(RegExp(r'[^0-9]'), ""))));

  sink.writeln(
      "import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';");
  sink.writeln("");
  sink.writeln("/// Main package constants");
  sink.writeln("class PhoneNumberMaskParserConstant {");
  sink.writeln("static const int maxLengthPhoneCode = 4;");
  sink.writeln("");
  sink.writeln("static const List<PhoneNumberMaskParserCountry> countries = [");

  for (PhoneNumberMaskParserCountry country in countries) {
    writeCountry(
      sink,
      country,
    );
  }

  sink.writeln("];");
  sink.writeln("}");
  sink.close();

  await Process.run('dart', ['format', '.']);
}

void writeCountry(
  IOSink sink,
  PhoneNumberMaskParserCountry country,
) {
  sink.writeln("PhoneNumberMaskParserCountry(");
  sink.writeln("title: \"${country.title}\",");
  sink.writeln("iso2Code: \"${country.iso2Code}\",");
  sink.writeln("phoneCode: \"${country.phoneCode}\",");
  sink.writeln(
      "alternativePhoneCodes: [${country.alternativePhoneCodes.isEmpty ? "" : "\"${country.alternativePhoneCodes.join("\", \"")}\","}],");
  sink.writeln("mask: \"${country.mask}\",");
  sink.writeln("),");
}
