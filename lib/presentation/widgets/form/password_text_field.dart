import 'package:flutter/material.dart';
import 'package:ppu_connect/core/validators/auth_validators.dart';

import 'app_text_field.dart';
import 'password_strength_bar.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.label = 'Password',
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.validator,
    this.showStrengthBar = false,
    this.autofillHint = AutofillHints.password,
    this.enableAutofill = true,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool showStrengthBar;
  final String autofillHint;
  final bool enableAutofill;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: widget.label,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: !_visible,
          keyboardType: TextInputType.visiblePassword,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: widget.textInputAction,
            autofillHints:
              widget.enableAutofill ? [widget.autofillHint] : null,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(_visible ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _visible = !_visible),
            tooltip: _visible ? 'Hide password' : 'Show password',
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator ?? PasswordValidator.strength,
        ),
        if (widget.showStrengthBar) ...[
          const SizedBox(height: 6),
          ValueListenableBuilder(
            valueListenable: widget.controller,
            builder: (_, value, __) => PasswordStrengthBar(
              score: PasswordValidator.score(value.text),
            ),
          ),
        ],
      ],
    );
  }
}
