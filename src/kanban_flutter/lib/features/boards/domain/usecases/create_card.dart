import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/index.dart';

class CreateCard extends UseCase<bool, CreateCardParams> {
  final CardRepository repository;

  CreateCard({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(CreateCardParams params) async {
    return await repository.createCard(params);
  }
}
