import 'package:flutter/foundation.dart';

import '../../domain/entities/column_item.dart';
import './card_item_model.dart';

class ColumnItemModel extends ColumnItem {
  final int id;
  final int boardId;
  final String title;
  final int index;
  final List<CardItemModel> cards;

  ColumnItemModel({
    @required this.id,
    @required this.boardId,
    @required this.title,
    @required this.index,
    @required this.cards,
  });

  factory ColumnItemModel.fromJson(Map<String, dynamic> json) {
    return ColumnItemModel(
      id: json['id'],
      boardId: json['boardId'],
      title: json['title'],
      index: json['index'],
      cards: json['cards'] != null
          ? (json['cards'] as List)
              .map((x) => CardItemModel.fromJson(x))
              .toList()
          : [],
    );
  }
}
