import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../params/index.dart';

abstract class CardRemoteDataSource {
  Future<Either<ServerException, bool>> updateCardIndex(
      UpdateCardIndexParams params);

  Future<Either<ServerException, bool>> createCard(CreateCardParams params);
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final ApiClient client;

  CardRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<Either<ServerException, bool>> updateCardIndex(
      UpdateCardIndexParams params) async {
    return getRemoteData<bool>(
      () => client.httpClient.put(
        '/cards/${params.cardId}/drag',
        data: params.toJson(),
      ),
      ApiResponseType.Unit,
    );
  }

  @override
  Future<Either<ServerException, bool>> createCard(
      CreateCardParams params) async {
    return getRemoteData<bool>(
      () => client.httpClient.post(
        '/cards',
        data: params.toJson(),
      ),
      ApiResponseType.Unit,
    );
  }
}
