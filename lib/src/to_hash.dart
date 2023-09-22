import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';
import 'dart:io';

main() async {
  final File file = File('domain/entity/phone_number_mask_parser_hash.dart');
  final IOSink sink = file.openWrite();

  sink.writeln(
      "import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';");
  sink.writeln("");
  sink.writeln("class PhoneNumberMaskParserHash {");
  sink.writeln(
      "   static const Map<String, PhoneNumberMaskParserCountry> countries = {");

  PhoneNumberMaskParserConstant.countries.forEach(
    (
      PhoneNumberMaskParserCountry country,
    ) {
      if (country.alternativePhoneCodes.isEmpty) {
        final String code = country.phoneCode.replaceAll(RegExp(r'[^0-9]'), "");
        sink.writeln("\"$code\": ${country.toString()},");
      } else {
        country.alternativePhoneCodes.forEach((
          String phoneCode,
        ) {
          final String code = phoneCode.replaceAll(RegExp(r'[^0-9]'), "");
          sink.writeln("\"$code\": ${country.toString()},");
        });
      }
    },
  );

  sink.writeln("  };");
  sink.writeln("}");
  sink.close();

  await Process.run('dart', ['format', '.']);
}
