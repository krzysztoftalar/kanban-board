import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../style/index.dart';
import '../../domain/entities/index.dart';

const BOARD_TEMPLATES = const [
  BoardTemplate(
    id: 1,
    title: 'Starter Kanban',
    color: ThemeColor.blue,
    icon: FontAwesomeIcons.columns,
    iconColor: ThemeColor.light_blue,
    columns: ['To Do', 'In Progress', 'Done'],
  ),
  BoardTemplate(
    id: 2,
    title: 'Weekly Tasks',
    color: ThemeColor.green,
    icon: FontAwesomeIcons.calendarAlt,
    iconColor: ThemeColor.light_green,
    columns: [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ],
  ),
  BoardTemplate(
    id: 3,
    title: 'Sprint/Release Cycle',
    color: ThemeColor.dark_blue,
    icon: FontAwesomeIcons.recycle,
    iconColor: ThemeColor.dark_blue2,
    columns: ['Backlog', 'In Progress', 'Testing', 'Done'],
  ),
  BoardTemplate(
    id: 4,
    title: 'Product Roadmap',
    color: ThemeColor.purple,
    icon: FontAwesomeIcons.mapSigns,
    iconColor: ThemeColor.purple2,
    columns: ['Q1', 'Q2', 'Q3', 'Q4'],
  ),
  BoardTemplate(
    id: 5,
    title: 'Product Backlog',
    color: ThemeColor.dark_purple,
    icon: FontAwesomeIcons.list,
    iconColor: ThemeColor.dark_purple2,
    columns: ['Bugs', 'Features', 'Next Release'],
  ),
];

BoardTemplate getBoardTemplateById(int id) {
  return BOARD_TEMPLATES.firstWhere((x) => x.id == id);
}
