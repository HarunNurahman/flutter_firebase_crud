import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/core/configs/themes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isObsecure;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.isObsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: isObsecure,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: grayTextStyle,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            counterText: '',
          ),
        ),
      ],
    );
  }
}
