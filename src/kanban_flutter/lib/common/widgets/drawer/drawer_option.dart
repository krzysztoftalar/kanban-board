import 'package:flutter/material.dart';

class DrawerOption {
  final String text;
  final IconData icon;
  final Function handler;

  DrawerOption({
    @required this.text,
    @required this.icon,
    @required this.handler,
  });
}

