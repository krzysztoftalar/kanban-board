import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../error/exceptions.dart';
import '../config/app_config.dart';

class ApiClient {
  final Dio dio;

  ApiClient({
    @required this.dio,
  });

  Dio get httpClient {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static BaseOptions options = BaseOptions(
    baseUrl: config[BASE_SERVER_URL],
  );
}

typedef Future<Response<dynamic>> _ServerEndpoint();

enum ApiResponseType { Object, Number, Unit }

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
  } catch (error) {
    return Left(ServerException(error));
  }
}
