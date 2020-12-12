import 'package:flutter/material.dart';

import '../../../../../style/index.dart';

class OutlinedDeleteButton extends StatelessWidget {
  final Function handler;

  OutlinedDeleteButton({
    @required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text('Cancel'),
      onPressed: handler,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(MaterialState.pressed)) {
            return BorderSide(color: ThemeColor.text_selected);
          }
          return BorderSide(color: ThemeColor.default_border);
        }),
        foregroundColor:
            MaterialStateProperty.all<Color>(ThemeColor.text_normal),
      ),
    );
  }
}
