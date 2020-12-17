import 'package:flutter/foundation.dart';

class GetBoardsParams{
  final int skip;
  final int limit;

  GetBoardsParams({
    @required this.skip,
    @required this.limit,
  });

  Map<String, dynamic> toJson() => {
    "skip": skip,
    "limit": limit,
  };
}
