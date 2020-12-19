import 'package:flutter/material.dart';

import '../../../style/index.dart';

class OutlinedActionButton extends StatelessWidget {
  final Function handler;
  final Function disableBtn;
  final Widget btnContent;

  OutlinedActionButton({
    @required this.handler,
    @required this.disableBtn,
    @required this.btnContent,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: btnContent,
      onPressed: disableBtn() ? null : handler,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(MaterialState.pressed)) {
            return BorderSide(color: ThemeColor.text_selected);
          } else if (disableBtn()) {
            return BorderSide(
                color: ThemeColor.default_border.withOpacity(0.4));
          }
          return BorderSide(color: ThemeColor.default_border);
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (disableBtn()) {
            return ThemeColor.text_normal.withOpacity(0.4);
          }
          return ThemeColor.text_normal;
        }),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}
