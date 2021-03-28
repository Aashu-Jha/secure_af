
import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ?
      ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme().copyWith(
            // color: Color(0xff152030),
          ),
          snackBarTheme: SnackBarThemeData().copyWith(
            backgroundColor: Colors.blueGrey,
          ),
          canvasColor: Color(0xff152030),
          scaffoldBackgroundColor: Color(0xff152030),
          cardColor: Color(0xff0E151E),
          primaryColor: Color(0xff122B43),
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blue[800])
      ) : ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          )
      ),
    );
  }
}


