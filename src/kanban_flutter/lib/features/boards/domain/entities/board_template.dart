import 'package:flutter/cupertino.dart';

class BoardTemplate {
  final int id;
  final String title;
  final Color color;
  final IconData icon;
  final Color iconColor;
  final List<String> columns;

  const BoardTemplate({
    @required this.id,
    @required this.title,
    @required this.color,
    @required this.icon,
    @required this.iconColor,
    @required this.columns,
  });
}
