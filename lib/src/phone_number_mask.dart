import 'package:phone_number_mask/src/constant.dart';
import 'package:phone_number_mask/src/exception.dart';
import 'package:phone_number_mask/src/data.dart';
import 'package:collection/collection.dart';
import 'dart:developer' as developer;
import 'dart:math' as math;

// dart format lib/src/phone_number_mask.dart

/// Main package class
class PhoneNumberMask {
  /// [targetMask] The mask that will be used to bypass phone number parsing to overlay all phone numbers.\
  /// [defaultMask] The mask that will be used in case the phone number is not recognized.\
  /// [isPlus] The flag responsible for the plus sign at the very beginning.\
  /// [isEndlessPhoneNumber] The flag that does not truncate the last part of the phone number if it exceeds the length of the mask.
  PhoneNumberMask({
    final String? targetMask,
    final String defaultMask = "+### ### #### ####",
    final bool isPlus = true,
    final bool isEndlessPhoneNumber = false,
  }) {
    this._targetMask = targetMask;
    this._defaultMask = defaultMask;
    this._isPlus = isPlus;
    this._isEndlessPhoneNumber = isEndlessPhoneNumber;
  }

  /// The mask that will be used to bypass phone number parsing to overlay all phone numbers.
  String? _targetMask;

  /// The mask that will be used in case the phone number is not recognized.
  late String _defaultMask;

  /// The flag responsible for the plus sign at the very beginning.
  late bool _isPlus;

  /// The flag that does not truncate the last part of the phone number if it exceeds the length of the mask.
  late bool _isEndlessPhoneNumber;

  /// The main method for applying the mask
  PhoneNumberMaskResult apply({required String phoneNumber}) {
    final String _phoneNumberSanitized =
        phoneNumber.replaceAll(RegExp(r'[^0-9]'), "");

    try {
      if (_phoneNumberSanitized.isEmpty) {
        throw const PhoneNumberEmptyExpection();
      }

      if (this._targetMask != null) {
        return PhoneNumberMaskResult(
          phoneNumberMasked: this._applyMask(
            mask: this._targetMask!,
            phoneNumber: _phoneNumberSanitized,
          ),
          iso2Code: null,
        );
      }

      // Main process
      // 1) Get potential phone code
      final String _potentialPhoneCode = this
          ._getPotentialPhoneCode(phoneNumberSanitized: _phoneNumberSanitized);

      // 2) Parse country from potential phone code
      final PhoneNumberMaskCountry _phoneNumberCountry =
          this._parseCountry(potentialPhoneCode: _potentialPhoneCode);

      // 3) Actual phone code
      String _phoneNumberResult = this._replaceOnActualPhoneCode(
          phoneCode: _phoneNumberCountry.phoneCode,
          phoneNumberSanitized: _phoneNumberSanitized);

      // 4) Mask
      _phoneNumberResult = this._applyMask(
          mask: _phoneNumberCountry.mask!, phoneNumber: _phoneNumberResult);

      // 5) Plus
      if (this._isPlus == false) {
        _phoneNumberResult = _phoneNumberResult.replaceFirst("+", "");
      }

      // 6) Trim
      _phoneNumberResult = _phoneNumberResult.trim();

      // 7) Result
      return PhoneNumberMaskResult(
        phoneNumberMasked: _phoneNumberResult,
        countryTitle: _phoneNumberCountry.title,
        phoneCode: _phoneNumberCountry.phoneCode,
        iso2Code: _phoneNumberCountry.iso2Code,
        mask: _phoneNumberCountry.mask,
      );
    } on PhoneNumberEmptyExpection {
      return const PhoneNumberMaskResult(
        phoneNumberMasked: "",
      );
    } on PhoneNumberProcessExpection {
      return PhoneNumberMaskResult(
        phoneNumberMasked: this._applyMask(
          mask: this._defaultMask,
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

  /// Getting potential phone code from sanitized phone number
  String _getPotentialPhoneCode({required String phoneNumberSanitized}) {
    final int _potentialPhoneCodeLength =
        math.min(phoneNumberSanitized.length, 4);
    final String _potentialPhoneCode =
        phoneNumberSanitized.substring(0, _potentialPhoneCodeLength);
    // print("PotentialPhoneCode: $_potentialPhoneCode");
    return _potentialPhoneCode;
  }

  /// Finding country data from potential phone code
  PhoneNumberMaskCountry _parseCountry({required String potentialPhoneCode}) {
    for (var i = potentialPhoneCode.length; i >= 0; i--) {
      String _potentialPhoneCodeSubstring = potentialPhoneCode.substring(0, i);
      // print("PotentialPhoneCodeSubstring: $_potentialPhoneCodeSubstring");
      final PhoneNumberMaskCountry? _country = PhoneNumberMaskConstant.countries
          .firstWhereOrNull((PhoneNumberMaskCountry country) =>
              country.alternativePhoneCodes
                  .contains(_potentialPhoneCodeSubstring) ||
              country.phoneCode == _potentialPhoneCodeSubstring);
      if (_country?.mask == null) {
        continue;
      }
      return _country!;
    }

    throw const PhoneNumberProcessExpection(
      message: "No country for this phone number",
    );
  }

  /// Replacement on finding phone code for crutching numbers
  String _replaceOnActualPhoneCode(
      {required String? phoneCode, required String phoneNumberSanitized}) {
    if (phoneCode == null) {
      return phoneNumberSanitized;
    }

    final List<String> _phoneNumberSanitizedList =
        phoneNumberSanitized.split("");

    for (var index = 0; index < phoneCode.length; index++) {
      _phoneNumberSanitizedList[index] = phoneCode[index];
    }
    return _phoneNumberSanitizedList.join("");
  }

  /// Main method for applying mask on number
  String _applyMask({required String mask, required String phoneNumber}) {
    final List<String> _result = [];
    int _phoneNumberIndex = 0;

    for (var index = 0; index < mask.length; index++) {
      if (_phoneNumberIndex >= phoneNumber.length) {
        break;
      }

      final String _currentMaskChar = mask[index];
      final String _currentPhoneNumberChar = phoneNumber[_phoneNumberIndex];
      // print("Index: $index");
      // print("Mask length: ${mask.length}");
      // print("PhoneNumberIndex: $_phoneNumberIndex");
      // print("CurrentMaskChar:$_currentMaskChar");
      // print("CurrentPhoneNumberChar: $_currentPhoneNumberChar");
      // print("Current result $_result");
      // print("\n");

      if (_currentMaskChar == "#") {
        _result.add(_currentPhoneNumberChar);
        _phoneNumberIndex++;
        continue;
      }

      if (int.tryParse(_currentMaskChar) != null) {
        _result.add(_currentMaskChar);
        _phoneNumberIndex++;
        continue;
      }

      _result.add(_currentMaskChar);
    }

    final String _resultString = _result.join("");

    if ((phoneNumber.length - 1) > _phoneNumberIndex &&
        this._isEndlessPhoneNumber) {
      final String _endlessPart = phoneNumber.substring(_phoneNumberIndex);
      return "$_resultString $_endlessPart";
    }

    return _resultString;
  }
}
