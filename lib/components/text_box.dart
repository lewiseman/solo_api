import 'package:flutter/material.dart';

class FormTextBox extends StatelessWidget {
  const FormTextBox({
    super.key,
    this.placeholder,
    this.validator,
    this.controller,
  });
  final String? placeholder;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }
}

bool emptyString(String? value) {
  return value?.trim().isEmpty ?? true;
}
