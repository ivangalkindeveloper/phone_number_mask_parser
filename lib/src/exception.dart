class PhoneNumberEmptyExpection implements Exception {
  static const String message = "Phone number mask is empty";
}

class PhoneNumberProcessExpection implements Exception {
  const PhoneNumberProcessExpection({
    required this.message,
  });

  final String message;
}
