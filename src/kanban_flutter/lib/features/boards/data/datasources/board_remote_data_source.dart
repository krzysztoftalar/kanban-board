import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_client.dart';
import '../params/index.dart';
import '../models/index.dart';
import '../../../../core/error/exceptions.dart';

abstract class BoardRemoteDataSource {
  Future<Either<ServerException, BoardsEnvelope>> getBoards(
      GetBoardsParams params);

  Future<Either<ServerException, BoardModel>> getBoardById(int id);

  Future<Either<ServerException, int>> createBoard(CreateBoardParams params);

  Future<Either<ServerException, bool>> deleteBoard(DeleteBoardParams params);
}

class BoardRemoteDataSourceImpl implements BoardRemoteDataSource {
  final ApiClient client;

  BoardRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<Either<ServerException, BoardModel>> getBoardById(int id) async {
    return getRemoteData<BoardModel>(
      () => client.httpClient.get('/boards/$id'),
      ApiResponseType.Object,
      BoardModel.fromJsonModel,
    );
  }

  @override
  Future<Either<ServerException, int>> createBoard(
      CreateBoardParams params) async {
    return getRemoteData<int>(
      () => client.httpClient.post(
        '/boards',
        data: params.toJson(),
      ),
      ApiResponseType.Number,
    );
  }

  @override
  Future<Either<ServerException, BoardsEnvelope>> getBoards(
      GetBoardsParams params) async {
    return getRemoteData<BoardsEnvelope>(
      () => client.httpClient.get(
        '/boards',
        queryParameters: params.toJson(),
      ),
      ApiResponseType.Object,
      BoardsEnvelope.fromJsonModel,
    );
  }

  @override
  Future<Either<ServerException, bool>> deleteBoard(
      DeleteBoardParams params) async {
    return getRemoteData<bool>(
      () => client.httpClient.delete('/boards/${params.boardId}'),
      ApiResponseType.Unit,
    );
  }
}
