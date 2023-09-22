/// Process of phone mask applying exception
class PhoneNumberProcessException implements Exception {
  const PhoneNumberProcessException({
    required this.message,
  });

  final String message;
}
