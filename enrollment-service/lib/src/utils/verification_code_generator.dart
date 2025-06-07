import 'dart:math';

import 'package:vaden/vaden.dart';

/// Utility for generating verification codes for certificates
///
/// Creates unique verification codes that can be used to validate
/// certificate authenticity
@Component()
class VerificationCodeGenerator {
  static const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  static const int _codeLength = 12;
  final Random _random = Random();

  /// Generates a random verification code
  ///
  /// Returns a string containing uppercase letters and numbers
  /// in the format: XXXX-XXXX-XXXX
  String generate() {
    final buffer = StringBuffer();

    for (int i = 0; i < _codeLength; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write('-');
      }
      buffer.write(_chars[_random.nextInt(_chars.length)]);
    }

    return buffer.toString();
  }

  /// Validates the format of a verification code
  ///
  /// [code] The verification code to validate
  ///
  /// Returns true if the code has the correct format
  bool isValidFormat(String code) {
    final regex = RegExp(r'^[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}$');
    return regex.hasMatch(code);
  }
}
