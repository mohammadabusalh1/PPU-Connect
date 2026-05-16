class PaymentMethodInput {
  const PaymentMethodInput({
    required this.number,
    required this.holderName,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
  });

  final String number;
  final String holderName;
  final int expiryMonth;
  final int expiryYear;
  final String cvv;

  String get _digits => number.replaceAll(' ', '');

  String get last4 =>
      _digits.substring((_digits.length - 4).clamp(0, _digits.length));

  String get brand {
    if (_digits.startsWith('4')) return 'Visa';
    if (_digits.startsWith('5')) return 'Mastercard';
    if (_digits.startsWith('3')) return 'Amex';
    if (_digits.startsWith('6')) return 'Discover';
    return 'Card';
  }

  bool get isValid => _digits.length >= 13 && _luhn(_digits);

  static bool _luhn(String digits) {
    int sum = 0;
    bool alternate = false;
    for (int i = digits.length - 1; i >= 0; i--) {
      int n = int.parse(digits[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }
}
