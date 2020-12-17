import 'package:flutter/foundation.dart';

class CreateColumnParams {
  final int boardId;
  final int columnIndex;
  final String title;

  CreateColumnParams({
    @required this.boardId,
    @required this.columnIndex,
    @required this.title,
  });

  Map<String, dynamic> toJson() => {
        "boardId": boardId,
        "columnIndex": columnIndex,
        "title": title,
      };
}
