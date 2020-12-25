import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../main.dart';
import '../config/app_config.dart';
import '../error/exceptions.dart';
import '../routes/routes.dart';

class ApiClient {
  final FlutterSecureStorage storage;
  final Dio dio;

  ApiClient({
    @required this.dio,
    @required this.storage,
  });

  Dio get httpClient {
    if (config[ENVIRONMENT] == Environment.Development) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    print(cookieJar
        .loadForRequest(Uri.parse("https://localhost:5001/api/")));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          final token = await storage.read(key: JWT_KEY);
          if (token != null) {
            options.headers.addAll({"Authorization": "Bearer $token"});
          }
          return options;
        },
        onError: (DioError error) async {
          if (error.response.statusCode == 401 &&
              error.response.headers.map.containsKey('www-authenticate')) {
            await storage.delete(key: JWT_KEY);
            KanbanApp.navigatorKey.currentState
                .pushReplacementNamed(Routes.AUTH_PAGE);
          }
        },
      ),
    );

    return dio;
  }

  static BaseOptions options = BaseOptions(
    baseUrl: config[BASE_SERVER_URL],
  );
}

typedef Future<Response<dynamic>> _ServerEndpoint();

enum ApiResponseType { Object, Number, Unit }

// RestException object thrown from server
class Error {
  final String message;

  Error({this.message});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(message: json['Error']);
  }
}

Future<Either<ServerException, T>> getRemoteData<T>(
    _ServerEndpoint _serverEndpoint, ApiResponseType type,
    [Function fromJson]) async {
  try {
    final response = await _serverEndpoint();

    if (response.statusCode == 200) {
      switch (type) {
        case ApiResponseType.Number:
          return Right(response.data);
        case ApiResponseType.Unit:
          return Right(true as T);
        case ApiResponseType.Object:
          return Right(fromJson(response.data));
      }
    }

    return null;
  } on DioError catch (e) {
    print(e);
    if (e.response.data != '') {
      return Left(ServerException(Error.fromJson(e.response.data).message));
    } else {
      return Left(ServerException(e.response.statusMessage));
    }
  }
}
