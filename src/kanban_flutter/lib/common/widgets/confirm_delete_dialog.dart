import 'package:flutter/material.dart';

import '../../style/index.dart';
import 'index.dart';

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
      padding: EdgeInsets.all(getSize(15)),
      decoration: BoxDecoration(
        color: ThemeColor.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          messageWidget(),
          SizedBox(height: getSize(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedCancelButton(handler: cancelHandler),
              SizedBox(width: getSize(15)),
              _buildDeleteButton(),
            ],
          )
        ],
      ),
    );
  }
}
