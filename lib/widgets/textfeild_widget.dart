import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.onChanged,
    this.keyboardType,
    this.validator, required bool enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          
          decoration: InputDecoration(
            hintText: hint,
            
          ),
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          validator: validator,
          
        ),
      ],
    );
  }
}
