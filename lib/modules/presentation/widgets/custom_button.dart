import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/core/configs/themes.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Size? size;
  final VoidCallback onPressed;
  final Color? color;
  const CustomButton({
    super.key,
    required this.label,
    this.color,
    this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? blueColor,
        elevation: 1,
        minimumSize: size ?? Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
      ),
    );
  }
}
