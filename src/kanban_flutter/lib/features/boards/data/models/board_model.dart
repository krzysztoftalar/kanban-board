import 'package:flutter/foundation.dart';

import '../../domain/entities/board.dart';
import 'column_item_model.dart';

class BoardModel extends Board {
  final int id;
  final String title;
  final int templateId;
  final List<ColumnItemModel> columns;

  BoardModel({
    @required this.id,
    @required this.title,
    @required this.templateId,
    @required this.columns,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json['id'],
      title: json['title'],
      templateId: json['boardTemplateId'],
      columns: json['columns'] != null
          ? (json['columns'] as List)
              .map((x) => ColumnItemModel.fromJson(x))
              .toList()
          : [],
    );
  }

  static BoardModel fromJsonModel(Map<String, dynamic> json) =>
      BoardModel.fromJson(json);
}
