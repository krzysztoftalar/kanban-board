import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class EditBoard extends UseCase<bool, EditBoardParams> {
  final BoardRepository repository;

  EditBoard({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(EditBoardParams params) async {
    return await repository.editBoard(params);
  }
}
