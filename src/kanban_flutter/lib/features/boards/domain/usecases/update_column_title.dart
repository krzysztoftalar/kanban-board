import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class UpdateColumnTitle extends UseCase<bool, UpdateColumnTitleParams> {
  final ColumnRepository repository;

  UpdateColumnTitle({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(
      UpdateColumnTitleParams params) async {
    return await repository.updateColumnTitle(params);
  }
}
