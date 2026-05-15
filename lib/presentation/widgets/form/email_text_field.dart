import 'package:flutter/material.dart';
import 'package:ppu_connect/core/validators/auth_validators.dart';

import 'app_text_field.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.validator,
    this.ppuOnly = false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool ppuOnly;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Email',
      hint: ppuOnly ? 'name@student.ppu.edu.ps' : 'you@example.com',
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      prefixIcon: const Icon(Icons.email_outlined),
      onFieldSubmitted: onFieldSubmitted,
      validator: validator ??
          (ppuOnly ? EmailValidator.ppu : EmailValidator.format),
    );
  }
}
