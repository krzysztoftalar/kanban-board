import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/index.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class GetBoards extends UseCase<BoardsEnvelope, GetBoardsParams> {
  final BoardRepository repository;

  GetBoards({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, BoardsEnvelope>> call(
      GetBoardsParams params) async {
    return await repository.getBoards(params);
  }
}
