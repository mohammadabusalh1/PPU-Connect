import 'package:flutter/material.dart';

mixin FormValidationMixin<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();

  bool validateForm() {
    final form = formKey.currentState;
    if (form == null) return false;
    return form.validate();
  }

  void saveForm() => formKey.currentState?.save();

  bool validateAndSave() {
    if (!validateForm()) return false;
    saveForm();
    return true;
  }

  void resetForm() => formKey.currentState?.reset();
}
