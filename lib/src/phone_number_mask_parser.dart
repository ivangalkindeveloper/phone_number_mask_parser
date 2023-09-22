import 'package:phone_number_mask_parser/src/domain/exception/phone_number_process_exception.dart';
import 'package:phone_number_mask_parser/src/domain/exception/phone_number_target_exception.dart';
import 'package:phone_number_mask_parser/src/domain/exception/phone_number_empty_exception.dart';
import 'package:phone_number_mask_parser/src/domain/entity/phone_number_mask_parser_hash.dart';
import 'package:phone_number_mask_parser/phone_number_mask_parser.dart';
import 'dart:math' as math;

/// Main package class.\
/// ☎️ Dart package of simple parsing of phone numbers and various masking options.
class PhoneNumberMaskParser {
  /// [targetMask] The mask that will be used to bypass phone number parsing to overlay all phone numbers.\
  /// [defaultMask] The mask that will be used in case the phone number is not recognized.\
  /// [isPlus] The flag responsible for the plus sign at the very beginning.\
  /// [isEndless] The flag that does not truncate the last part of the phone number if it exceeds the length of the mask.
  const PhoneNumberMaskParser({
    this.targetMask,
    this.defaultMask = "+### ### #### ####",
    this.isPlus = true,
    this.isEndless = false,
  });

  /// The mask that will be used to bypass phone number parsing to overlay all phone numbers.
  final String? targetMask;

  /// The mask that will be used in case the phone number is not recognized.
  final String defaultMask;

  /// The flag responsible for the plus sign at the very beginning.
  final bool isPlus;

  /// The flag that does not truncate the last part of the phone number if it exceeds the length of the mask.
  final bool isEndless;

  /// The main method for applying the mask
  PhoneNumberMaskParserResult apply({
    required String phoneNumber,
  }) {
    final String phoneNumberSanitized = this._sanitize(
      string: phoneNumber,
    );

    try {
      if (phoneNumberSanitized.isEmpty) {
        throw const PhoneNumberEmptyException();
      }

      if (this.targetMask != null) {
        throw const PhoneNumberTargetException();
      }

      // Main process
      // 1) Get potential phone code
      final String potentialPhoneCode = this._getPotentialPhoneCode(
        phoneNumberSanitized: phoneNumberSanitized,
      );

      // 2) Parse country from potential phone code
      final PhoneNumberMaskParserCountry? phoneNumberCountry =
          this._parseCountry(
        potentialPhoneCode: potentialPhoneCode,
      );

      if (phoneNumberCountry == null) {
        throw const PhoneNumberProcessException(
          message: "No country for this phone number",
        );
      }

      // 3) Actual phone code
      final String phoneNumberWithActualPhoneCodeSanitized =
          this._replaceOnActualPhoneCode(
        actualPhoneCode: phoneNumberCountry.phoneCode,
        phoneNumberSanitized: phoneNumberSanitized,
      );

      // 4) Mask
      final String result = this._applyMask(
        mask: phoneNumberCountry.mask,
        phoneNumberSanitized: phoneNumberWithActualPhoneCodeSanitized,
      );

      // 5) Result
      return PhoneNumberMaskParserResult(
        phoneNumberMasked: this.isPlus ? result : result.replaceFirst("+", ""),
        country: phoneNumberCountry,
      );
    } on PhoneNumberEmptyException {
      return const PhoneNumberMaskParserResult(
        phoneNumberMasked: "",
      );
    } on PhoneNumberTargetException {
      return PhoneNumberMaskParserResult(
        phoneNumberMasked: this._applyMask(
          mask: this.targetMask!,
          phoneNumberSanitized: phoneNumberSanitized,
        ),
      );
    } on PhoneNumberProcessException {
      return PhoneNumberMaskParserResult(
        phoneNumberMasked: this._applyMask(
          mask: this.defaultMask,
          phoneNumberSanitized: phoneNumberSanitized,
        ),
      );
    } catch (error, stackTrace) {
      print("PhoneNumberMaskParser Exception: $error");
      print(stackTrace.toString());
      return PhoneNumberMaskParserResult(
        phoneNumberMasked: phoneNumber,
      );
    }
  }

  /// Sanitize string for numbers
  String _sanitize({
    required String string,
  }) =>
      string.replaceAll(RegExp(r'[^0-9]'), "");

  /// Getting potential phone code from sanitized phone number and sanitized phone codes from constant
  String _getPotentialPhoneCode({
    required String phoneNumberSanitized,
  }) =>
      phoneNumberSanitized.substring(
        0,
        math.min(
          phoneNumberSanitized.length,
          PhoneNumberMaskParserConstant.maxLengthPhoneCode,
        ),
      );

  /// Finding country data from potential phone code
  PhoneNumberMaskParserCountry? _parseCountry({
    required String potentialPhoneCode,
  }) {
    for (int i = potentialPhoneCode.length; i >= 0; i--) {
      final String potentialPhoneCodeSubstring =
          potentialPhoneCode.substring(0, i);

      final PhoneNumberMaskParserCountry? country =
          PhoneNumberMaskParserHash.countries[potentialPhoneCodeSubstring];
      if (country != null) {
        return country;
      }
      continue;
    }

    return null;
  }

  /// Replacement on finding phone code for crutching numbers
  String _replaceOnActualPhoneCode({
    required String actualPhoneCode,
    required String phoneNumberSanitized,
  }) {
    actualPhoneCode = this._sanitize(string: actualPhoneCode);
    final List<String> phoneNumberSanitizedList =
        phoneNumberSanitized.split("");

    for (int index = 0; index < actualPhoneCode.length; index++) {
      phoneNumberSanitizedList[index] = actualPhoneCode[index];
    }

    return phoneNumberSanitizedList.join("");
  }

  /// Main method for applying mask on number
  String _applyMask({
    required String mask,
    required String phoneNumberSanitized,
  }) {
    String result = "";
    int phoneNumberIndex = 0;

    for (int index = 0; index < mask.length; index++) {
      if (phoneNumberIndex >= phoneNumberSanitized.length) {
        break;
      }

      final String currentMaskChar = mask[index];
      final String currentPhoneNumberChar =
          phoneNumberSanitized[phoneNumberIndex];

      if (currentMaskChar == "#") {
        result = "$result$currentPhoneNumberChar";
        phoneNumberIndex++;
        continue;
      }

      if (int.tryParse(currentMaskChar) != null) {
        result = "$result$currentMaskChar";
        phoneNumberIndex++;
        continue;
      }

      result = "$result$currentMaskChar";
    }

    if ((phoneNumberSanitized.length - 1) >= phoneNumberIndex &&
        this.isEndless) {
      return "$result ${phoneNumberSanitized.substring(phoneNumberIndex)}";
    }

    return result;
  }
}
