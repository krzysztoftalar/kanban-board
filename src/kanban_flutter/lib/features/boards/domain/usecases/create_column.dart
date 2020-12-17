import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class CreateColumn extends UseCase<bool, CreateColumnParams> {
  final ColumnRepository repository;

  CreateColumn({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(CreateColumnParams params) async {
    return await repository.createColumn(params);
  }
}
