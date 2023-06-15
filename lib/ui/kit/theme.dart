import 'package:fermer/ui/kit/colors.dart';
import 'package:flutter/material.dart';

class CustomUI {
  final theme = ThemeData().copyWith(
      primaryColor: CustomColors.deepGreen,
      canvasColor: CustomColors.white,
      scaffoldBackgroundColor: CustomColors.white,
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: CustomColors.deepGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      
      ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: CustomColors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: CustomColors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: CustomColors.deepGreen,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      labelStyle: const TextStyle(
        color: CustomColors.black,
      ),
      hintStyle: const TextStyle(
        color: CustomColors.grey,
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
      ),
    ),

      datePickerTheme: DatePickerThemeData(
        
        
        
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontFamily: 'JetBrainsMono',
          fontWeight: FontWeight.w700,
          color: CustomColors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontFamily: 'JetBrainsMono',
          fontWeight: FontWeight.w700,
          color: CustomColors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontFamily: 'JetBrainsMono',
          color: CustomColors.black,
        ),
      ));
}
