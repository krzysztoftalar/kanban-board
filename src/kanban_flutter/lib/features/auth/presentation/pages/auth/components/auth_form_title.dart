import 'package:flutter/material.dart';

import '../../../../../../style/index.dart';

class AuthFormTitle extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  AuthFormTitle({
    @required this.title,
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  _AuthFormTitleState createState() => _AuthFormTitleState();
}

class _AuthFormTitleState extends State<AuthFormTitle> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeColor.card_bg,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(
          color: ThemeColor.text_selected,
          fontSize: getSize(ThemeSize.fs_20),
        ),
      ),
    );
  }
}
