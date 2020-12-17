import 'package:flutter/material.dart';

import 'index.dart';
import '../../style/index.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Function deleteHandler;
  final Function cancelHandler;
  final Function messageWidget;

  ConfirmDeleteDialog({
    @required this.deleteHandler,
    @required this.cancelHandler,
    @required this.messageWidget,
  });

  Widget _buildDeleteButton() {
    return OutlinedButton(
      child: Text('Delete'),
      onPressed: deleteHandler,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return ThemeColor.danger_press;
            }
            return ThemeColor.danger_press.withOpacity(0.2);
          },
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          return BorderSide(color: ThemeColor.danger_border);
        }),
        foregroundColor:
            MaterialStateProperty.all<Color>(ThemeColor.text_normal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateWidth(15)),
      decoration: BoxDecoration(color: ThemeColor.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          messageWidget(),
          SizedBox(height: getProportionateHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedCancelButton(handler: cancelHandler),
              SizedBox(width: getProportionateHeight(15)),
              _buildDeleteButton(),
            ],
          )
        ],
      ),
    );
  }
}