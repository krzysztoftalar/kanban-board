import 'package:flutter/foundation.dart';

import '../../domain/entities/card_item.dart';

class CardItemModel extends CardItem {
  final int id;
  final String title;
  final int index;

  CardItemModel({
    @required this.id,
    @required this.title,
    @required this.index,
  });

  factory CardItemModel.fromJson(Map<String, dynamic> json) {
    return CardItemModel(
      id: json['id'],
      title: json['title'],
      index: json['index'],
    );
  }
}
