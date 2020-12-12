import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../params/index.dart';
import '../datasources/board_remote_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/column_repository.dart';

class ColumnRepositoryImpl implements ColumnRepository {
  final BoardRemoteDataSource remoteDataSource;

  ColumnRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<ServerException, bool>> updateColumnIndex(
      UpdateColumnIndexParams params) async {
    return await remoteDataSource.updateColumnIndex(params);
  }

  @override
  Future<Either<ServerException, bool>> updateColumnTitle(
      UpdateColumnTitleParams params) async {
    return await remoteDataSource.updateColumnTitle(params);
  }

  @override
  Future<Either<ServerException, bool>> deleteColumn(
      DeleteColumnParams params) async {
    return await remoteDataSource.deleteColumn(params);
  }
}
