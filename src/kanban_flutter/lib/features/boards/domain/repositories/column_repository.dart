import 'package:dartz/dartz.dart';

import '../../data/params/index.dart';
import '../../../../core/error/exceptions.dart';

abstract class ColumnRepository {
  Future<Either<ServerException, bool>> updateColumnIndex(
      UpdateColumnIndexParams params);

  Future<Either<ServerException, bool>> updateColumnTitle(
      UpdateColumnTitleParams params);

  Future<Either<ServerException, bool>> deleteColumn(DeleteColumnParams params);
  Future<Either<ServerException, bool>> createColumn(CreateColumnParams params);
}
