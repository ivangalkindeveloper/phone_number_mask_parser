import 'package:phone_number_mask_parser/src/domain/entity/phone_number_mask_parser_country.dart';

/// Main library result class
class PhoneNumberMaskParserResult {
  const PhoneNumberMaskParserResult({
    required this.PhoneNumberMaskParsered,
    this.country,
  });

  final String PhoneNumberMaskParsered;
  final PhoneNumberMaskParserCountry? country;
}
