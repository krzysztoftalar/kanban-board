import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/board.dart';
import '../../domain/repositories/board_repository.dart';
import '../datasources/board_remote_data_source.dart';
import '../models/index.dart';
import '../params/index.dart';

class BoardRepositoryImpl implements BoardRepository {
  final BoardRemoteDataSource remoteDataSource;

  BoardRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<ServerException, BoardsEnvelope>> getBoards(
      GetBoardsParams params) async {
    return await remoteDataSource.getBoards(params);
  }

  Future<Either<ServerException, Board>> getBoardById(int id) async {
    return await remoteDataSource.getBoardById(id);
  }

  @override
  Future<Either<ServerException, int>> createBoard(
      CreateBoardParams params) async {
    return await remoteDataSource.createBoard(params);
  }

  @override
  Future<Either<ServerException, bool>> editBoard(
      EditBoardParams params) async {
    return await remoteDataSource.editBoard(params);
  }

  @override
  Future<Either<ServerException, bool>> deleteBoard(
      DeleteBoardParams params) async {
    return await remoteDataSource.deleteBoard(params);
  }
}
