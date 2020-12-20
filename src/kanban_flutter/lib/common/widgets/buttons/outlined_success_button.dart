import 'package:flutter/material.dart';

import '../../../style/index.dart';

class OutlinedSuccessButton extends StatelessWidget {
  final Function handler;
  final String btnText;
  final bool isFieldEmpty;

  OutlinedSuccessButton({
    @required this.isFieldEmpty,
    @required this.btnText,
    @required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(btnText),
      onPressed: !isFieldEmpty ? handler : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return ThemeColor.success_press;
            } else if (isFieldEmpty) {
              return ThemeColor.success_bg.withOpacity(0.2);
            }
            return ThemeColor.success_bg;
          },
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (isFieldEmpty) {
            return BorderSide(
              color: ThemeColor.success_border.withOpacity(0.2),
            );
          }
          return BorderSide(color: ThemeColor.success_border);
        }),
        foregroundColor:
            MaterialStateProperty.all<Color>(ThemeColor.text_normal),
      ),
    );
  }
}
