import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double value = double.tryParse(newValue.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final newString = '\$${(value / 100).toStringAsFixed(2)}';
    return newValue.copyWith(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
