import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class EditColumn extends UseCase<bool, EditColumnParams> {
  final ColumnRepository repository;

  EditColumn({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(EditColumnParams params) async {
    return await repository.editColumn(params);
  }
}
