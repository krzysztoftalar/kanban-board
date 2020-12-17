import 'package:flutter/foundation.dart';

class CreateBoardParams {
  final String title;
  final int templateId;

  CreateBoardParams({
    @required this.title,
    @required this.templateId,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "templateId": templateId,
      };
}
