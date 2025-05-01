import 'dart:io';

import 'package:dio/dio.dart';

import '../../storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required LocalStorage storage}) : _storage = storage;

  final LocalStorage _storage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    options.headers[HttpHeaders.acceptHeader] = 'application/json';
    if (_storage.token?.access.isNotEmpty == true) {
      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${_storage.token?.access}';
    }

    return handler.next(options);
  }

  
}