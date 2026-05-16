import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppu_connect/domain/models/payment_method_input.dart';

class CardInputWidget extends StatefulWidget {
  const CardInputWidget({super.key});

  @override
  State<CardInputWidget> createState() => CardInputWidgetState();
}

class CardInputWidgetState extends State<CardInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final _numberCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();

  String _brand = '';
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _numberCtrl.dispose();
    _nameCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  void _onNumberChanged(String v) {
    final digits = v.replaceAll(' ', '');
    String brand = '';
    if (digits.startsWith('4')) {
      brand = 'Visa';
    } else if (digits.startsWith('5')) {
      brand = 'Mastercard';
    } else if (digits.startsWith('3')) {
      brand = 'Amex';
    } else if (digits.startsWith('6')) {
      brand = 'Discover';
    }
    if (brand != _brand) setState(() => _brand = brand);
  }

  PaymentMethodInput? validate() {
    setState(() => _autovalidateMode = AutovalidateMode.always);
    if (!_formKey.currentState!.validate()) return null;
    final digits = _numberCtrl.text.replaceAll(' ', '');
    final expiry = _expiryCtrl.text.split('/');
    final month = int.tryParse(expiry.first) ?? 0;
    final year = int.tryParse(expiry.length > 1 ? expiry[1] : '') ?? 0;
    return PaymentMethodInput(
      number: digits,
      holderName: _nameCtrl.text.trim(),
      expiryMonth: month,
      expiryYear: 2000 + year,
      cvv: _cvvCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _numberCtrl,
            decoration: InputDecoration(
              labelText: 'Card Number',
              prefixIcon: const Icon(Icons.credit_card_outlined),
              suffixIcon: _brand.isNotEmpty
                  ? Icon(Icons.credit_card,
                      color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _CardNumberFormatter(),
            ],
            onChanged: _onNumberChanged,
            validator: (v) {
              final digits = (v ?? '').replaceAll(' ', '');
              if (digits.length < 13) return 'Enter a valid card number';
              if (!PaymentMethodInput(
                number: digits,
                holderName: '',
                expiryMonth: 1,
                expiryYear: 2099,
                cvv: '000',
              ).isValid) {
                return 'Invalid card number';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Cardholder Name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (v) =>
                (v ?? '').trim().isEmpty ? 'Enter cardholder name' : null,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiryCtrl,
                  decoration: const InputDecoration(
                    labelText: 'MM/YY',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _ExpiryFormatter(),
                  ],
                  validator: (v) {
                    final parts = (v ?? '').split('/');
                    if (parts.length != 2) return 'Invalid expiry';
                    final m = int.tryParse(parts[0]) ?? 0;
                    final y = int.tryParse(parts[1]) ?? 0;
                    if (m < 1 || m > 12) return 'Invalid expiry';
                    final currentYear = DateTime.now().year % 100;
                    if (y < currentYear) return 'Card has expired';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _cvvCtrl,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  validator: (v) =>
                      (v ?? '').length < 3 ? 'Enter CVV' : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue next) {
    final digits = next.text.replaceAll(' ', '');
    if (digits.length > 16) {
      return old;
    }
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    final text = buffer.toString();
    return next.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue next) {
    final digits = next.text.replaceAll('/', '');
    if (digits.length > 4) return old;
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(digits[i]);
    }
    final text = buffer.toString();
    return next.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
