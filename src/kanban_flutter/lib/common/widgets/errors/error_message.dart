import 'package:flutter/material.dart';

import '../../../style/index.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  ErrorMessage({
    @required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: ThemeColor.text_selected,
          fontSize: ThemeSize.fs_17,
        ),
      ),
    );
  }
}
