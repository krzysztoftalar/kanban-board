import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/app_config.dart';

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
