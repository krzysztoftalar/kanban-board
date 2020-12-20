import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class UpdateCardIndex extends UseCase<bool, UpdateCardIndexParams> {
  final CardRepository repository;

  UpdateCardIndex({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(
      UpdateCardIndexParams params) async {
    return await repository.updateCardIndex(params);
  }
}
