import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import './column_item.dart';

class Board extends Equatable {
  final int id;
  final String title;
  final int templateId;
  final List<ColumnItem> columns;

  Board({
    @required this.id,
    @required this.title,
    @required this.templateId,
    @required this.columns,
  });

  Board copyWith({int id, String title, List<ColumnItem> columns}) {
    return Board(
      id: id ?? this.id,
      title: title ?? this.title,
      templateId: templateId ?? this.templateId,
      columns: columns ?? this.columns,
    );
  }

  @override
  List<Object> get props => [id, title, templateId, columns];
}
