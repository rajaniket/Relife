import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String message;
  final double fontSize;
  final FontWeight fontWeight;
  final double elevation;
  final Size buttonSize;
  final double borderRadius;
  final Color buttonColor;
  final VoidCallback onTap;

  const CustomTextButton({
    Key? key,
    required this.message,
    required this.fontSize,
    required this.fontWeight,
    required this.elevation,
    required this.buttonSize,
    required this.borderRadius,
    required this.buttonColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        message,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: buttonSize,
      ),
    );
  }
}
