import 'package:flutter/foundation.dart';

class UpdateColumnIndexParams {
  final int oldIndex;
  final int newIndex;
  final int columnId;
  final int boardId;

  UpdateColumnIndexParams({
    @required this.oldIndex,
    @required this.newIndex,
    @required this.columnId,
    @required this.boardId,
  });

  Map<String, dynamic> toJson() => {
        "oldIndex": oldIndex,
        "newIndex": newIndex,
        "columnId": columnId,
        "boardId": boardId,
      };
}
