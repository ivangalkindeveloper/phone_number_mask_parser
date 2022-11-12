/// Common properties
class _PhoneNumberMaskBaseModel {
  const _PhoneNumberMaskBaseModel({
    required this.phoneCode,
    required this.iso2Code,
    required this.mask,
  });

  final String? phoneCode;
  final String? iso2Code;
  final String? mask;
}

/// Main library result class
class PhoneNumberMaskResult extends _PhoneNumberMaskBaseModel {
  const PhoneNumberMaskResult({
    required this.phoneNumberMasked,
    this.countryTitle,
    String? phoneCode,
    String? iso2Code,
    String? mask,
  }) : super(
          phoneCode: phoneCode,
          iso2Code: iso2Code,
          mask: mask,
        );

  final String phoneNumberMasked;
  final String? countryTitle;
}

/// Country data
class PhoneNumberMaskCountry extends _PhoneNumberMaskBaseModel {
  const PhoneNumberMaskCountry({
    required this.title,
    required String phoneCode,
    required this.alternativePhoneCodes,
    required String iso2Code,
    required String mask,
  }) : super(
          phoneCode: phoneCode,
          iso2Code: iso2Code,
          mask: mask,
        );

  final String title;
  final List<String> alternativePhoneCodes;
}
