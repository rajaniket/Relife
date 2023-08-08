import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // ._() is a named private constructor. // can't be instanitated
  // Default text colour
  static const Color defaultTextColor = Color(0xff000000);
  //Icon colour
  static const Color bottomNavigatorBarIconColour = Color(0xff062540);
  // button colour
  static const Color buttonColor = Color(0xffDF532B);
  static const Color buttonTextColor = Colors.white;

  //  welcome screen colors
  static const List<Color> welcomeScreenBackgroundColor = [
    Color(0xffDF532B),
    Color(0xffFA8A3C)
  ];
  static const Color welcomeScreenTextColor = Color(0xff062540);

  // Login screen colors
  static const Color textFieldBorderColor = Color(0xff000000);
  static const Color focusedBorderColor = Color(0xffDF532B);

  // Start Screen Colors
  static const Color startScreenBackgroundColor = Color(0xff062540);
  static const Color startScreenTextColor = Colors.white;

  // add habit screen colors
  static const Color addHabitScreenBackgroundColor = Color(0xffF7F6F2);

  // Secret screen colors
  static const Color secretScreenBackgroundColor = Color(0xff062540);
  static const Color progressIndicatorColor = Color(0xffDF532B);

  // habit stacking screen colors
  static const Color habitStackingScreenBackgroundColor = Color(0xff062540);

  // bottomSheet
  static const Color bottomSheetTextFieldColor = Color(0xffFDEEE4);

  //view habit heighlight colour

  static const Color viewHabitHighlightColor = Color(0xff062540);
}
