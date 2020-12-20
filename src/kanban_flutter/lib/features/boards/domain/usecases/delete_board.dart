import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class DeleteBoard extends UseCase<bool, DeleteBoardParams> {
  final BoardRepository repository;

  DeleteBoard({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(DeleteBoardParams params) async {
    return await repository.deleteBoard(params);
  }
}
