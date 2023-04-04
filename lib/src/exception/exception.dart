/// Empty phone number exception
class PhoneNumberEmptyExpection implements Exception {
  const PhoneNumberEmptyExpection();

  static const String message = "Phone number mask is empty";
}

/// Process of phone mask applying exception
class PhoneNumberProcessExpection implements Exception {
  const PhoneNumberProcessExpection({
    required this.message,
  });

  final String message;
}
