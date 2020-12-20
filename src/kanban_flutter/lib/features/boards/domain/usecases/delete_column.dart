import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class DeleteColumn extends UseCase<bool, DeleteColumnParams> {
  final ColumnRepository repository;

  DeleteColumn({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(DeleteColumnParams params) async {
    return await repository.deleteColumn(params);
  }
}
