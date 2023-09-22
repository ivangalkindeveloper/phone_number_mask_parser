/// Country data
class PhoneNumberMaskParserCountry {
  const PhoneNumberMaskParserCountry({
    required this.title,
    required this.iso2Code,
    required this.phoneCode,
    required this.alternativePhoneCodes,
    required this.mask,
  });

  final String title;
  final String iso2Code;
  final String phoneCode;
  final List<String> alternativePhoneCodes;
  final String mask;
}
