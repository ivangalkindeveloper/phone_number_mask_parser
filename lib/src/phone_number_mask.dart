import 'package:phone_number_mask/src/exception/exception.dart';
import 'package:phone_number_mask/phone_number_mask.dart';
import 'dart:developer' as developer;
import 'dart:math' as math;

/// Main package class
class PhoneNumberMask {
  /// [targetMask] The mask that will be used to bypass phone number parsing to overlay all phone numbers.\
  /// [defaultMask] The mask that will be used in case the phone number is not recognized.\
  /// [isPlus] The flag responsible for the plus sign at the very beginning.\
  /// [isEndlessPhoneNumber] The flag that does not truncate the last part of the phone number if it exceeds the length of the mask.
  const PhoneNumberMask({
    this.targetMask,
    this.defaultMask = "+### ### #### ####",
    this.isPlus = true,
    this.isEndlessPhoneNumber = false,
  });

  /// The mask that will be used to bypass phone number parsing to overlay all phone numbers.
  final String? targetMask;

  /// The mask that will be used in case the phone number is not recognized.
  final String defaultMask;

  /// The flag responsible for the plus sign at the very beginning.
  final bool isPlus;

  /// The flag that does not truncate the last part of the phone number if it exceeds the length of the mask.
  final bool isEndlessPhoneNumber;

  /// The main method for applying the mask
  PhoneNumberMaskResult apply({required String phoneNumber}) {
    final String phoneNumberSanitized = this.sanitize(string: phoneNumber);

    try {
      if (phoneNumberSanitized.isEmpty) {
        throw const PhoneNumberEmptyExpection();
      }

      if (this.targetMask != null) {
        return PhoneNumberMaskResult(
          phoneNumberMasked: this._applyMask(
            mask: this.targetMask!,
            phoneNumber: phoneNumberSanitized,
          ),
          iso2Code: null,
        );
      }

      // Main process
      // 1) Get potential phone code
      final String potentialPhoneCode = this._getPotentialPhoneCode(
        phoneNumberSanitized: phoneNumberSanitized,
      );

      // 2) Parse country from potential phone code
      final PhoneNumberMaskCountry phoneNumberCountry = this._parseCountry(
        potentialPhoneCode: potentialPhoneCode,
      );

      // 3) Actual phone code
      String phoneNumberResult = this._replaceOnActualPhoneCode(
        phoneCode: phoneNumberCountry.phoneCode,
        phoneNumberSanitized: phoneNumberSanitized,
      );

      // 4) Mask
      phoneNumberResult = this._applyMask(
        mask: phoneNumberCountry.mask!,
        phoneNumber: phoneNumberResult,
      );

      // 5) Plus
      if (this.isPlus == false) {
        phoneNumberResult = phoneNumberResult.replaceFirst("+", "");
      }

      // 6) Trim
      phoneNumberResult = phoneNumberResult.trim();

      // 7) Result
      return PhoneNumberMaskResult(
        phoneNumberMasked: phoneNumberResult,
        countryTitle: phoneNumberCountry.title,
        phoneCode: phoneNumberCountry.phoneCode,
        iso2Code: phoneNumberCountry.iso2Code,
        mask: phoneNumberCountry.mask,
      );
    } on PhoneNumberEmptyExpection {
      return const PhoneNumberMaskResult(
        phoneNumberMasked: "",
      );
    } on PhoneNumberProcessExpection {
      return PhoneNumberMaskResult(
        phoneNumberMasked: this._applyMask(
          mask: this.defaultMask,
          phoneNumber: phoneNumber,
        ),
      );
    } catch (error, stackTrace) {
      developer.log("PhoneNumberMask Exception: $error");
      developer.log(stackTrace.toString());
      return PhoneNumberMaskResult(
        phoneNumberMasked: phoneNumber,
      );
    }
  }

  /// Sanitize string for numbers
  String sanitize({
    required String string,
  }) =>
      string.replaceAll(RegExp(r'[^0-9]'), "");

  /// Getting potential phone code from sanitized phone number and sanitized phone codes from constant
  String _getPotentialPhoneCode({
    required String phoneNumberSanitized,
  }) {
    int maxPhoneCode = 0;

    PhoneNumberMaskConstant.countries.forEach((PhoneNumberMaskCountry country) {
      [
        country.title,
        ...country.alternativePhoneCodes,
      ]
          .map((String phoneCode) => this.sanitize(string: phoneCode))
          .toList()
          .forEach((String phoneCode) {
        if (phoneCode.length > maxPhoneCode) maxPhoneCode = phoneCode.length;
      });
    });

    final int potentialPhoneCodeLength = math.min(
      phoneNumberSanitized.length,
      maxPhoneCode,
    );

    final String potentialPhoneCode = phoneNumberSanitized.substring(
      0,
      potentialPhoneCodeLength,
    );
    return potentialPhoneCode;
  }

  /// Finding country data from potential phone code
  PhoneNumberMaskCountry _parseCountry({
    required String potentialPhoneCode,
  }) {
    for (var i = potentialPhoneCode.length; i >= 0; i--) {
      String potentialPhoneCodeSubstring =
          "+${potentialPhoneCode.substring(0, i)}";
      try {
        final PhoneNumberMaskCountry? _country = PhoneNumberMaskConstant
            .countries
            .firstWhere((PhoneNumberMaskCountry country) =>
                country.alternativePhoneCodes
                    .contains(potentialPhoneCodeSubstring) ||
                country.phoneCode == potentialPhoneCodeSubstring);
        return _country!;
      } catch (error) {
        continue;
      }
    }

    throw const PhoneNumberProcessExpection(
      message: "No country for this phone number",
    );
  }

  /// Replacement on finding phone code for crutching numbers
  String _replaceOnActualPhoneCode({
    required String? phoneCode,
    required String phoneNumberSanitized,
  }) {
    if (phoneCode == null) {
      return phoneNumberSanitized;
    }

    final String phoneCodeSaitized = this.sanitize(string: phoneCode);
    final List<String> phoneNumberSanitizedList =
        phoneNumberSanitized.split("");

    for (var index = 0; index < phoneCodeSaitized.length; index++) {
      phoneNumberSanitizedList[index] = phoneCodeSaitized[index];
    }

    return phoneNumberSanitizedList.join("");
  }

  /// Main method for applying mask on number
  String _applyMask({required String mask, required String phoneNumber}) {
    final List<String> result = [];
    int phoneNumberIndex = 0;

    for (var index = 0; index < mask.length; index++) {
      if (phoneNumberIndex >= phoneNumber.length) {
        break;
      }

      final String currentMaskChar = mask[index];
      final String currentPhoneNumberChar = phoneNumber[phoneNumberIndex];

      if (currentMaskChar == "#") {
        result.add(currentPhoneNumberChar);
        phoneNumberIndex++;
        continue;
      }

      if (int.tryParse(currentMaskChar) != null) {
        result.add(currentMaskChar);
        phoneNumberIndex++;
        continue;
      }

      result.add(currentMaskChar);
    }

    final String resultString = result.join("");

    if ((phoneNumber.length - 1) > phoneNumberIndex &&
        this.isEndlessPhoneNumber) {
      final String endlessPart = phoneNumber.substring(phoneNumberIndex);
      return "$resultString $endlessPart";
    }

    return resultString;
  }
}
