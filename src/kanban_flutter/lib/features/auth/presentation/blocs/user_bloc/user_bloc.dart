import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/config/app_config.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../main.dart';
import '../../../data/params/index.dart';
import '../../../data/services/token_service.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/index.dart';

part 'user_event.dart';

part 'user_state.dart';

typedef Future<Either<ServerException, User>> _UserRequest();

class UserBloc extends Bloc<UserEvent, UserState> {
  final FlutterSecureStorage storage;
  final LoginUser login;
  final RegisterUser register;
  final CurrentUser currentUser;
  final LogoutUser logout;

  UserBloc({
    @required this.storage,
    @required this.login,
    @required this.register,
    @required this.currentUser,
    @required this.logout,
  }) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _mapAuthenticatedUserToState(
        () => login(
          LoginParams(
            email: event.email,
            password: event.password,
          ),
        ),
        event,
      );
    } else if (event is RegisterEvent) {
      yield* _mapAuthenticatedUserToState(
        () => register(
          RegisterParams(
            userName: event.userName,
            email: event.email,
            password: event.password,
          ),
        ),
        event,
      );
    } else if (event is CurrentUserEvent) {
      yield* _mapCurrentUserToState();
    } else if (event is LogoutEvent) {
      yield* _mapLogoutUserToState();
    }
  }

  Stream<UserState> _mapAuthenticatedUserToState(
      _UserRequest _userRequest, UserEvent event) async* {
    yield UserLoading();

    final userEither = await _userRequest();

    yield userEither.fold(
      (failure) => UserError(message: failure.message),
      (user) {
        storage.write(key: JWT_TOKEN, value: user.token);
        storage.write(key: JWT_REFRESH_TOKEN, value: user.refreshToken);

        TokenService.startRefreshTokenTimer(user.token);

        return UserAuthenticated(user: user);
      },
    );
  }

  Stream<UserState> _mapCurrentUserToState() async* {
    yield UserLoading();

    final token = await storage.read(key: JWT_TOKEN);

    if (token != null) {
      final userEither = await currentUser(
        CurrentUserParams(
          refreshToken: await storage.read(key: JWT_REFRESH_TOKEN),
        ),
      );

      yield userEither.fold(
        (failure) => UserError(message: failure.message),
        (user) {
          storage.write(key: JWT_TOKEN, value: user.token);
          storage.write(key: JWT_REFRESH_TOKEN, value: user.refreshToken);

          TokenService.startRefreshTokenTimer(user.token);

          return UserAuthenticated(user: user);
        },
      );
    } else {
      yield UserError(message: "Unauthorized");
    }
  }

  Stream<UserState> _mapLogoutUserToState() async* {
    yield UserLoading();

    final userEither = await logout(
      LogoutParams(
        refreshToken: await storage.read(key: JWT_REFRESH_TOKEN),
      ),
    );

    yield userEither.fold(
      (failure) => UserError(message: failure.message),
      (user) {
        storage.delete(key: JWT_TOKEN);
        storage.delete(key: JWT_REFRESH_TOKEN);

        TokenService.stopRefreshTokenTimer();

        KanbanApp.navigatorKey.currentState.pop();
        KanbanApp.navigatorKey.currentState
            .pushReplacementNamed(Routes.AUTH_PAGE);

        return UserAuthenticated(user: null);
      },
    );
  }
}
