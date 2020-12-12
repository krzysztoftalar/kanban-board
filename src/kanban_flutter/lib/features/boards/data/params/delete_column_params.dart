import 'package:flutter/foundation.dart';

class DeleteColumnParams {
  final int columnId;

  DeleteColumnParams({
    @required this.columnId,
  });

  Map<String, dynamic> toJson() => {
        "columnId": columnId,
      };
}
