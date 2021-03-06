import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../core/api/api_client.dart';
import '../features/auth/data/datasources/user_remote_data_source.dart';
import '../features/auth/data/repositories/user_repository_impl.dart';
import '../features/auth/domain/repositories/user_repository.dart';
import '../features/auth/domain/usecases/index.dart';
import '../features/auth/presentation/blocs/user_bloc/user_bloc.dart';
import '../features/boards/data/datasources/board_remote_data_source.dart';
import '../features/boards/data/datasources/index.dart';
import '../features/boards/data/repositories/index.dart';
import '../features/boards/domain/repositories/index.dart';
import '../features/boards/domain/usecases/index.dart';
import '../features/boards/presentation/blocs/index.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - User
  // Blocs
  sl.registerFactory(
    () => UserBloc(
      storage: sl(),
      login: sl(),
      register: sl(),
      currentUser: sl(),
      logout: sl(),
    ),
  );

  //! Use cases
  sl.registerLazySingleton(() => LoginUser(repository: sl()));
  sl.registerLazySingleton(() => RegisterUser(repository: sl()));
  sl.registerLazySingleton(() => CurrentUser(repository: sl()));
  sl.registerLazySingleton(() => LogoutUser(repository: sl()));

  //! Repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));

  //! Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  // ========================================================
  //! Features - Boards
  // Blocs
  sl.registerFactory(
    () => BoardsBloc(
      getBoards: sl(),
      createBoard: sl(),
      editBoard: sl(),
      deleteBoard: sl(),
    ),
  );

  sl.registerFactory(
    () => BoardBloc(
      getBoardById: sl(),
    ),
  );

  sl.registerFactory(
    () => ColumnBloc(
      updateColumnIndex: sl(),
      editColumn: sl(),
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
  sl.registerLazySingleton(() => EditBoard(repository: sl()));
  sl.registerLazySingleton(() => DeleteBoard(repository: sl()));
  // Column
  sl.registerLazySingleton(() => UpdateColumnIndex(repository: sl()));
  sl.registerLazySingleton(() => CreateColumn(repository: sl()));
  sl.registerLazySingleton(() => EditColumn(repository: sl()));
  sl.registerLazySingleton(() => DeleteColumn(repository: sl()));
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

  // ========================================================
  //! Api
  sl.registerLazySingleton(
    () => ApiClient(
      storage: sl(),
      dio: sl(),
    ),
  );

  //! External libraries
  sl.registerLazySingleton(() => Dio(ApiClient.options));
  sl.registerLazySingleton(() => FlutterSecureStorage());
}
