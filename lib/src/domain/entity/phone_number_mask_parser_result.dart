import 'package:phone_number_mask_parser/src/domain/entity/phone_number_mask_parser_country.dart';

/// Main library result class
class PhoneNumberMaskParserResult {
  const PhoneNumberMaskParserResult({
    required this.phoneNumberMasked,
    this.country,
  });

  final String phoneNumberMasked;
  final PhoneNumberMaskParserCountry? country;
}
