import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';
import 'dart:io';

main() async {
  final File file = File('phone_number_mask_parser_hash.dart');
  final IOSink sink = file.openWrite();

  sink.writeln(
      "import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';");
  sink.writeln("");
  sink.writeln("/// Hash for algorithm work");
  sink.writeln("class PhoneNumberMaskParserHash {");
  sink.writeln(
      "static const Map<String, PhoneNumberMaskParserCountry> countries = {");

  PhoneNumberMaskParserConstant.countries.forEach(
    (
      PhoneNumberMaskParserCountry country,
    ) {
      if (country.alternativePhoneCodes.isEmpty) {
        final String code = country.phoneCode.replaceAll(RegExp(r'[^0-9]'), "");
        writeCountry(
          sink,
          code,
          country,
        );
      } else {
        country.alternativePhoneCodes.forEach(
          (
            String phoneCode,
          ) {
            final String code = phoneCode.replaceAll(RegExp(r'[^0-9]'), "");
            writeCountry(
              sink,
              code,
              country,
            );
          },
        );
      }
    },
  );

  sink.writeln("};");
  sink.writeln("}");
  sink.close();

  await Process.run('dart', ['format', '.']);
}

void writeCountry(
  IOSink sink,
  String phoneCode,
  PhoneNumberMaskParserCountry country,
) {
  sink.writeln("\"$phoneCode\": PhoneNumberMaskParserCountry(");
  sink.writeln("title: \"${country.title}\",");
  sink.writeln("iso2Code: \"${country.iso2Code}\",");
  sink.writeln("phoneCode: \"${country.phoneCode}\",");
  sink.writeln(
      "alternativePhoneCodes: [${country.alternativePhoneCodes.isEmpty ? "" : "\"${country.alternativePhoneCodes.join("\", \"")}\","}],");
  sink.writeln("mask: \"${country.mask}\",");
  sink.writeln("),");
}
