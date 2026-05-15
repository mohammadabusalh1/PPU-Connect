import 'package:flutter/material.dart';
import 'package:ppu_connect/core/validators/auth_validators.dart';

import 'app_text_field.dart';

class FullNameTextField extends StatelessWidget {
  const FullNameTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Full name',
      hint: 'As it appears on your student ID',
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: TextInputType.name,
      autofillHints: const [AutofillHints.name],
      prefixIcon: const Icon(Icons.person_outline),
      validator: NameValidator.required,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
