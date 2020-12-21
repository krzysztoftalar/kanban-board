import 'package:flutter/material.dart';

import '../../../style/index.dart';
import 'index.dart';

class NavDrawerItem extends StatelessWidget {
  final DrawerOption item;

  NavDrawerItem(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.handler,
      child: Row(
        children: [
          Icon(
            item.icon,
            color: ThemeColor.text_disabled,
          ),
          SizedBox(width: getSize(8)),
          Text(
            item.text,
            style: TextStyle(
              color: ThemeColor.text_normal,
              fontSize: ThemeSize.fs_17,
            ),
          ),
        ],
      ),
    );
  }
}
