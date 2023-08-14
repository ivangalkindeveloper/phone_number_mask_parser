import 'package:phone_number_mask/src/domain/entities/phone_number_mask_base.dart';

/// Country data
class PhoneNumberMaskCountry implements IPhoneNumberMaskBaseModel {
  const PhoneNumberMaskCountry({
    required this.title,
    this.iso2Code,
    this.phoneCode,
    required this.alternativePhoneCodes,
    this.mask,
  });

  final String title;
  final String? iso2Code;
  final String? phoneCode;
  final List<String> alternativePhoneCodes;
  final String? mask;
}
