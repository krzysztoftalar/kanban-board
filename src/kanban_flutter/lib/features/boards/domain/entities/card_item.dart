import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CardItem extends Equatable {
  final int id;
  final String title;
  final int index;

  CardItem({
    @required this.id,
    @required this.title,
    @required this.index,
  });

  @override
  List<Object> get props => [id, title, index];
}
