import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../entities/index.dart';
import '../repositories/index.dart';

class GetBoardById extends UseCase<Board, GetBoardByIdParams> {
  final BoardRepository repository;

  GetBoardById({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, Board>> call(GetBoardByIdParams params) async {
    return await repository.getBoardById(params.id);
  }
}
