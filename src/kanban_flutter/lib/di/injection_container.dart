import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/api/api_client.dart';
import '../features/boards/data/datasources/index.dart';
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
    () => BoardsBloc(
      getBoards: sl(),
      deleteBoard: sl(),
    ),
  );

  sl.registerFactory(
    () => BoardBloc(
      getBoardById: sl(),
      createBoard: sl(),
    ),
  );

  sl.registerFactory(
    () => ColumnBloc(
      updateColumnIndex: sl(),
      updateColumnTitle: sl(),
      deleteColumn: sl(),
      createColumn: sl(),
    ),
  );

  sl.registerFactory(
    () => CardBloc(
      updateCardIndex: sl(),
      createCard: sl(),
    ),
  );

  //! Use cases
  // Board
  sl.registerLazySingleton(() => GetBoards(repository: sl()));
  sl.registerLazySingleton(() => GetBoardById(repository: sl()));
  sl.registerLazySingleton(() => CreateBoard(repository: sl()));
  sl.registerLazySingleton(() => DeleteBoard(repository: sl()));
  // Column
  sl.registerLazySingleton(() => UpdateColumnIndex(repository: sl()));
  sl.registerLazySingleton(() => UpdateColumnTitle(repository: sl()));
  sl.registerLazySingleton(() => DeleteColumn(repository: sl()));
  sl.registerLazySingleton(() => CreateColumn(repository: sl()));
  // Card
  sl.registerLazySingleton(() => UpdateCardIndex(repository: sl()));
  sl.registerLazySingleton(() => CreateCard(repository: sl()));

  //! Repositories
  sl.registerLazySingleton<BoardRepository>(
      () => BoardRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ColumnRepository>(
      () => ColumnRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CardRepository>(
      () => CardRepositoryImpl(remoteDataSource: sl()));

  //! Data sources
  sl.registerLazySingleton<BoardRemoteDataSource>(
      () => BoardRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ColumnRemoteDataSource>(
      () => ColumnRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CardRemoteDataSource>(
      () => CardRemoteDataSourceImpl(client: sl()));

  //! Api
  sl.registerLazySingleton(() => ApiClient(dio: sl()));

  //! External libraries
  sl.registerLazySingleton(() => Dio(ApiClient.options));
}
