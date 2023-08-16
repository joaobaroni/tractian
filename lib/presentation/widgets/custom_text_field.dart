import 'package:flutter/material.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
  });

  final String? hintText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 6.responsiveHeight, left: 12.responsiveWidth),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.fontSize)),
        hintText: hintText,
      ),
    );
  }
}
