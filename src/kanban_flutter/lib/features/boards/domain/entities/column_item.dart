import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import './card_item.dart';

class ColumnItem extends Equatable {
  final int id;
  final int boardId;
  final String title;
  final int index;
  final List<CardItem> cards;

  ColumnItem({
    @required this.id,
    @required this.boardId,
    @required this.title,
    @required this.index,
    @required this.cards,
  });

  @override
  List<Object> get props => [id, boardId, title, index, cards];
}
