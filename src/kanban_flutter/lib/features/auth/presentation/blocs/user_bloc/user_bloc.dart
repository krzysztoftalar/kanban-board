import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/config/app_config.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/params/index.dart';
import '../../../domain/usecases/index.dart';
import '../../../domain/entities/user.dart';

part 'user_event.dart';

part 'user_state.dart';

// typedef Future<Either<ServerException, User>> _UserRequest();

class UserBloc extends Bloc<UserEvent, UserState> {
  final FlutterSecureStorage storage;
  final Login login;
  final CurrentUser currentUser;

  UserBloc({
    @required this.storage,
    @required this.login,
    @required this.currentUser,
  }) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _mapLoginUserToState(event);
    } else if (event is CurrentUserEvent) {
      yield* _mapCurrentUserToState();
    }
  }

  Stream<UserState> _mapLoginUserToState(LoginEvent event) async* {
    yield UserLoading();

    final userEither = await login(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    yield userEither.fold(
      (failure) => UserError(message: failure.message),
      (user) {
        storage.write(key: JWT_KEY, value: user.token);
        return UserAuthenticated(user: user);
      },
    );
  }

  Stream<UserState> _mapCurrentUserToState() async* {
    yield UserLoading();

    final token = await storage.read(key: JWT_KEY);

    if (token != null) {
      final userEither = await currentUser(NoParams());

      yield userEither.fold(
        (failure) => UserError(message: failure.message),
        (user) {
          storage.write(key: JWT_KEY, value: user.token);
          return UserAuthenticated(user: user);
        },
      );
    } else {
      yield UserError(message: "Unauthorized");
    }
  }
}
