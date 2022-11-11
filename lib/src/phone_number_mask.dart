import 'package:phone_number_mask/src/constant.dart';
import 'package:phone_number_mask/src/exception.dart';
import 'package:phone_number_mask/src/data.dart';
import 'dart:developer' as developer;
import 'dart:math' as math;

/// Main package class
class PhoneNumberMask {
  /// [targetMask] А mask that will be used to bypass phone number parsing to overlay all phone numbers.
  /// [endlessPhoneNumber] А mask that will be used in case the phone number is not recognized.
  /// [endlessPhoneNumber] А flag that does not truncate the last part of the phone number if it exceeds the length of the mask.
  PhoneNumberMask({
    final String? targetMask,
    final String? defaultMask,
    final bool endlessPhoneNumber = false,
  }) {
    this._targetMask = targetMask;
    this._defaultMask = defaultMask;
    this._endlessPhoneNumber = endlessPhoneNumber;
  }

  /// А mask that will be used to bypass phone number parsing to overlay all phone numbers.
  String? _targetMask;

  /// А mask that will be used in case the phone number is not recognized.
  String? _defaultMask;

  /// А flag that does not truncate the last part of the phone number if it exceeds the length of the mask.
  late bool _endlessPhoneNumber;

  /// The main method for applying the mask
  PhoneNumberMaskResult apply({required String phoneNumber}) {
    String _phoneNumberSanitized =
        phoneNumber.replaceAll(RegExp(r'[^0-9]'), "");

    try {
      if (_phoneNumberSanitized.isEmpty) {
        throw PhoneNumberEmptyExpection();
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
      final PhoneNUmberMaskCountry _phoneNumberCountry =
          this._parseCountry(potentialPhoneCode: _potentialPhoneCode);

      // 3) Actual phone code
      String _phoneNumberResult = this._replaceOnActualPhoneCode(
          phoneCode: _phoneNumberCountry.phoneCode,
          phoneNumberSanitized: _phoneNumberSanitized);

      // 3) Mask
      _phoneNumberResult = this._applyMask(
          mask: _phoneNumberCountry.mask!, phoneNumber: _phoneNumberResult);

      // 4) Trim
      _phoneNumberResult.trim();

      // 5) Result
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
          mask: this._defaultMask ?? PhoneNumberMaskConstant.defaultPhoneMask,
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
  PhoneNUmberMaskCountry _parseCountry({required String potentialPhoneCode}) {
    for (var i = potentialPhoneCode.length; i >= 0; i--) {
      String _potentialPhoneCodeSubstring = potentialPhoneCode.substring(0, i);
      // Russian phone numbers
      if (_potentialPhoneCodeSubstring == "79" ||
          _potentialPhoneCodeSubstring == "89") {
        return PhoneNumberMaskConstant.countries.firstWhere(
            (PhoneNUmberMaskCountry country) => country.iso2Code == "RU");
      }
      // print("PotentialPhoneCodeSubstring: $_potentialPhoneCodeSubstring");
      try {
        final PhoneNUmberMaskCountry _country = PhoneNumberMaskConstant
            .countries
            .firstWhere((PhoneNUmberMaskCountry country) =>
                country.phoneCode == _potentialPhoneCodeSubstring);
        if (_country.mask == null) {
          throw const PhoneNumberProcessExpection(
            message: "Country mask is null",
          );
        }
        return _country;
      } catch (error) {
        continue;
      }
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
        this._endlessPhoneNumber) {
      final String _endlessPart = phoneNumber.substring(_phoneNumberIndex);
      return "$_resultString $_endlessPart";
    }
    return _resultString;
  }
}
