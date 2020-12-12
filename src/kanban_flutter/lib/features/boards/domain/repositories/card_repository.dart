import 'package:dartz/dartz.dart';

import '../../data/params/index.dart';
import '../../../../core/error/exceptions.dart';

abstract class CardRepository {
  Future<Either<ServerException, bool>> updateCardIndex(UpdateCardIndexParams params);
  Future<Either<ServerException, bool>> createCard(CreateCardParams params);
}