import 'package:flutter/services.dart';

class PhoneOrEmailFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Check if the input contains only digits (phone number style)
    final isDigitsOnly = RegExp(r'^[0-9]+$').hasMatch(newValue.text);
    if (isDigitsOnly) {
      if (newValue.text.startsWith('0')) {
        // 10 digits total (0 + 9 digits)
        if (newValue.text.length > 10) {
          return oldValue;
        }
      } else {
        // 9 digits total (without leading 0)
        if (newValue.text.length > 9) {
          return oldValue;
        }
      }
    }
    return newValue;
  }
}
