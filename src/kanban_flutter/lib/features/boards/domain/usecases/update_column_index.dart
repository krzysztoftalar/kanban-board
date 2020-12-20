import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class UpdateColumnIndex extends UseCase<bool, UpdateColumnIndexParams> {
  final ColumnRepository repository;

  UpdateColumnIndex({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(
      UpdateColumnIndexParams params) async {
    return await repository.updateColumnIndex(params);
  }
}
