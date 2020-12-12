import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/boards/data/api/api_client.dart';
import '../features/boards/data/datasources/board_remote_data_source.dart';
import '../features/boards/data/repositories/index.dart';
import '../features/boards/domain/repositories/index.dart';
import '../features/boards/domain/usecases/index.dart';
import '../features/boards/presentation/blocs/index.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Boards
  // Blocs
  sl.registerFactory(
    () => BoardBloc(
      getBoardById: sl(),
      updateColumnIndex: sl(),
      updateCardIndex: sl(),
    ),
  );

  sl.registerFactory(
    () => ColumnBloc(
      updateColumnIndex: sl(),
      updateColumnTitle: sl(),
      deleteColumn: sl(),
    ),
  );

  sl.registerFactory(
    () => CardBloc(
      updateCardIndex: sl(),
      createCard: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetBoardById(repository: sl()));
  sl.registerLazySingleton(() => UpdateColumnIndex(repository: sl()));
  sl.registerLazySingleton(() => UpdateColumnTitle(repository: sl()));
  sl.registerLazySingleton(() => DeleteColumn(repository: sl()));
  sl.registerLazySingleton(() => UpdateCardIndex(repository: sl()));
  sl.registerLazySingleton(() => CreateCard(repository: sl()));

  // Repositories
  sl.registerLazySingleton<BoardRepository>(
      () => BoardRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ColumnRepository>(
      () => ColumnRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CardRepository>(
      () => CardRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<BoardRemoteDataSource>(
      () => BoardRemoteDataSourceImpl(client: sl()));

  // Api
  sl.registerLazySingleton(() => ApiClient(dio: sl()));

  // External libraries
  sl.registerLazySingleton(() => Dio(ApiClient.options));
}
