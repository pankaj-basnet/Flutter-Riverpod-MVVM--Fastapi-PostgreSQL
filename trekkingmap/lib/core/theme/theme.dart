import 'package:trekkingmap/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
   
  static final darkThemeMode = ThemeData.dark().copyWith(
    // scaffoldBackgroundColor: Pallete.backgroundColor,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor,
    ),

    
  );
}
