import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../params/index.dart';
import '../models/index.dart';
import '../api/api_client.dart';
import '../../../../core/error/exceptions.dart';

abstract class BoardRemoteDataSource {
  Future<Either<ServerException, BoardModel>> getBoardById(int id);

  Future<Either<ServerException, bool>> updateColumnIndex(
      UpdateColumnIndexParams params);

  Future<Either<ServerException, bool>> updateColumnTitle(
      UpdateColumnTitleParams params);

  Future<Either<ServerException, bool>> deleteColumn(DeleteColumnParams params);

  Future<Either<ServerException, bool>> updateCardIndex(
      UpdateCardIndexParams params);

  Future<Either<ServerException, bool>> createCard(CreateCardParams params);
}

class BoardRemoteDataSourceImpl implements BoardRemoteDataSource {
  final ApiClient client;

  BoardRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<Either<ServerException, BoardModel>> getBoardById(int id) async {
    try {
      final response = await client.httpClient.get(
        '/boards/$id',
      );

      if (response.statusCode == 200) {
        return Right(BoardModel.fromJson(response.data));
      }

      return null;
    } catch (error) {
      return Left(ServerException(error));
    }
  }

  @override
  Future<Either<ServerException, bool>> updateColumnIndex(
      UpdateColumnIndexParams params) async {
    try {
      final response = await client.httpClient.put(
        '/columns/${params.columnId}/drag',
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(true);
      }

      return null;
    } catch (error) {
      return Left(ServerException(error));
    }
  }

  @override
  Future<Either<ServerException, bool>> updateCardIndex(
      UpdateCardIndexParams params) async {
    try {
      final response = await client.httpClient.put(
        '/cards/${params.cardId}/drag',
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(true);
      }

      return null;
    } catch (error) {
      return Left(ServerException(error));
    }
  }

  @override
  Future<Either<ServerException, bool>> createCard(
      CreateCardParams params) async {
    try {
      final response = await client.httpClient.post(
        '/cards',
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(true);
      }

      return null;
    } catch (error) {
      return Left(ServerException(error));
    }
  }

  @override
  Future<Either<ServerException, bool>> updateColumnTitle(
      UpdateColumnTitleParams params) async {
    try {
      final response = await client.httpClient.put(
        '/columns/${params.columnId}',
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(true);
      }

      return null;
    } catch (error) {
      return Left(ServerException(error));
    }
  }

  @override
  Future<Either<ServerException, bool>> deleteColumn(
      DeleteColumnParams params) async {
    try {
      final response =
          await client.httpClient.delete('/columns/${params.columnId}');

      if (response.statusCode == 200) {
        return Right(true);
      }

      return null;
    } catch (error) {
      return Left(ServerException(error));
    }
  }
}
