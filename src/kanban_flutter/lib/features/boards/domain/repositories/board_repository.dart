import 'package:dartz/dartz.dart';

import '../entities/index.dart';
import '../../../../core/error/exceptions.dart';

abstract class BoardRepository {
  Future<Either<ServerException, Board>> getBoardById(int id);
}
