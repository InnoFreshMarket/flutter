import 'package:flutter/material.dart';

class CustomColors {
  static const Color deepGreen = Color(0xFF758650);
  static const Color lightGreen = Color(0xFFB5C267);
  static const Color lightYellow = Color(0xFFFFE27C);
  static const Color deepYellow = Color(0xFFE8B634);
  static const Color white = Color(0xFFF8F9F8);
  static const Color black = Color(0xFF1E1E1E);
  static const Color grey = Color(0xFFC9B6A1);

  static const List<BoxShadow> shadowsLogin = <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(0, 32, 51, 0.16),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 32, 51, 0.02),
      blurRadius: 2,
      offset: Offset(0, 2),
    ),
  ];
}
