import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../datasources/board_remote_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/board.dart';
import '../../domain/repositories/board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  final BoardRemoteDataSource remoteDataSource;

  BoardRepositoryImpl({
    @required this.remoteDataSource,
  });

  Future<Either<ServerException, Board>> getBoardById(int id) async {
    return await remoteDataSource.getBoardById(id);
  }
}
