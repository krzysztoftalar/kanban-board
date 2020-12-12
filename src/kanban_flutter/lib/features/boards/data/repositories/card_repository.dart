import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../params/index.dart';
import '../../domain/repositories/card_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../datasources/board_remote_data_source.dart';

class CardRepositoryImpl implements CardRepository {
  final BoardRemoteDataSource remoteDataSource;

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
