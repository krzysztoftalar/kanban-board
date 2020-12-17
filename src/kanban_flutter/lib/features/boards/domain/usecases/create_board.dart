import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/index.dart';
import '../../data/params/index.dart';
import '../../../../core/error/exceptions.dart';

class CreateBoard extends UseCase<int, CreateBoardParams> {
  final BoardRepository repository;

  CreateBoard({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, int>> call(CreateBoardParams params) async {
    return await repository.createBoard(params);
  }
}
