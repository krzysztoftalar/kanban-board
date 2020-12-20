import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/card_repository.dart';
import '../datasources/index.dart';
import '../params/index.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteDataSource remoteDataSource;

  CardRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<ServerException, bool>> updateCardIndex(
      UpdateCardIndexParams params) async {
    return await remoteDataSource.updateCardIndex(params);
  }

  @override
  Future<Either<ServerException, bool>> createCard(
      CreateCardParams params) async {
    return await remoteDataSource.createCard(params);
  }
}
