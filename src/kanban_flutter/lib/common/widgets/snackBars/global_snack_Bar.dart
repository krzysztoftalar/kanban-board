import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../style/index.dart';

class GlobalSnackBar {
  static show(String message, Color bgColor) {
    KanbanApp.scaffoldMessengerKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: TextStyle(
            color: ThemeColor.text_selected,
            fontSize: ThemeSize.fs_17,
          ),
        ),
      ),
    );
  }
}
