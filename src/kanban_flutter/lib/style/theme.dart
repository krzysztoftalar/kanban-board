import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'index.dart';

ThemeData theme() {
  return ThemeData(
    appBarTheme: appBarTheme(),
    accentColor: ThemeColor.accent,
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: ThemeColor.text_normal,
      ),
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: ThemeColor.board_header_bg,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: ThemeColor.text_normal,
        fontSize: ThemeSize.fs_20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: ThemeColor.primary_border,
      width: 1.5,
    ),
    gapPadding: 5,
  );

  return InputDecorationTheme(
    focusedBorder: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
    errorMaxLines: 3,
    errorStyle: TextStyle(
      color: ThemeColor.text_error,
      fontSize: ThemeSize.fs_13,
    ),
    fillColor: ThemeColor.input_bg,
    filled: true,
    isDense: true,
    hintStyle: TextStyle(
      color: ThemeColor.text_disabled,
      fontSize: ThemeSize.fs_15,
    ),
  );
}
