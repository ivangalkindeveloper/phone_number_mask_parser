import 'package:phone_number_mask/src/domain/entity/phone_number_mask_base.dart';

/// Main library result class
class PhoneNumberMaskResult implements IPhoneNumberMaskBaseModel {
  const PhoneNumberMaskResult({
    required this.phoneNumberMasked,
    this.countryTitle,
    this.iso2Code,
    this.phoneCode,
    this.mask,
  });

  final String phoneNumberMasked;
  final String? countryTitle;
  final String? iso2Code;
  final String? phoneCode;
  final String? mask;
}
