import 'package:flutter/foundation.dart';

import 'index.dart';

class BoardsEnvelope {
  List<BoardModel> boards;
  int boardsCount;

  BoardsEnvelope({
    @required this.boards,
    @required this.boardsCount,
  });

  BoardsEnvelope.fromJson(Map<String, dynamic> json) {
    if (json['boards'] != null) {
      boards =
          (json['boards'] as List).map((x) => BoardModel.fromJson(x)).toList();
      boardsCount = json['boardsCount'];
    }
  }

  static BoardsEnvelope fromJsonModel(Map<String, dynamic> json) =>
      BoardsEnvelope.fromJson(json);
}
