import 'package:flutter/material.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

class RoundedTag extends StatelessWidget {
  const RoundedTag({super.key, required this.label, required this.backgroundColor});

  final Widget label;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.responsiveWidth, vertical: 2.responsiveHeight),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(60.fontSize),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white, fontSize: 12.fontSize, fontWeight: FontWeight.w500),
        child: label,
      ),
    );
  }
}
