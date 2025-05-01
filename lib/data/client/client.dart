import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:adhdo_it_mob/data/client/interceptors/auth_interceptor.dart';
import 'package:adhdo_it_mob/data/models/api_response.dart';
import 'package:adhdo_it_mob/data/models/token.dart';
import 'package:tf_dio_cache/tf_dio_cache.dart';

import '../storage/local_storage.dart';

class ApiClient {
  final Dio _dio;
  final Logger _logger;
  final Function()? onErrorRefreshToken;

  ApiClient._(this._dio, {this.onErrorRefreshToken})
    : _logger = Logger('ApiClient');

  factory ApiClient(
    String baseUrl, {
    required LocalStorage storage,
    final Function()? onErrorRefresh,
  }) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    dio.interceptors.add(AuthInterceptor(storage: storage));
    dio.interceptors.add(
      DioCacheManager(
        CacheConfig(defaultMaxAge: const Duration(days: 7), baseUrl: baseUrl),
      ).interceptor,
    );

    return ApiClient._(dio, onErrorRefreshToken: onErrorRefresh);
  }

  Future<ApiResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    required T Function(dynamic data) decoder,
  }) {
    return request<T>(
      url,
      'get',
      decoder: decoder,
      params: params,
      options: options,
    );
  }

  Future<ApiResponse<T>> post<T>(
    String url, {
    T Function(dynamic data)? decoder,
    dynamic data,
    dynamic params,
  }) {
    return request<T>(
      url,
      'POST',
      decoder: decoder,
      data: data,
      params: params,
    );
  }

  Future<ApiResponse<T>> put<T>(
    String url, {
    T Function(dynamic data)? decoder,
    dynamic data,
  }) {
    return request<T>(url, 'PUT', decoder: decoder, data: data);
  }

  Future<ApiResponse<T>> patch<T>(
    String url, {
    T Function(dynamic data)? decoder,
    dynamic data,
  }) {
    return request<T>(url, 'PATCH', decoder: decoder, data: data);
  }

  Future<ApiResponse<T>> delete<T>(
    String url, {
    T Function(dynamic data)? decoder,
    dynamic params,
    dynamic data,
  }) {
    return request<T>(
      url,
      'DELETE',
      decoder: decoder,
      params: params,
      data: data,
    );
  }

  Future<ApiResponse<T>> request<T>(
    String url,
    String method, {
    required T Function(dynamic data)? decoder,
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
  }) async {
    final model = ApiResponse<T>();
    try {
      final response = await _dio
          .request(
            url,
            queryParameters: params,
            data: data,
            options: (options ?? Options()).copyWith(method: method),
          )
          .timeout(const Duration(days: 1));

      _logger.info('request $url \nstatus-code:${response.statusCode};');
      model.statusCode = response.statusCode;
      model.result = decoder?.call(response.data);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      model.statusCode = e.response?.statusCode;

      if ((statusCode == 401 || statusCode == 403) &&
          LocalStorage().token != null) {
        final refreshResponse = await _dio.post(
          'accounts/token/refresh/',
          data: {'refresh': LocalStorage().token!.refresh},
        );

        if (refreshResponse.statusCode == 200) {
          final newToken = refreshResponse.data;

          LocalStorage().token = Token(
            access: newToken['access'],
            refresh: newToken['refresh'],
          );
          return request(
            url,
            method,
            decoder: decoder,
            params: params,
            data: data,
          );
        } else if (refreshResponse.statusCode == 401 ||
            refreshResponse.statusCode == 403) {
          onErrorRefreshToken?.call();
        }
      }
      _logger.warning('endpoind: $url, status code:${e.response?.statusCode}');
      _logger.warning(data);
      _logger.warning(e.response?.data);
      model.errorData = e.response?.data;
    } catch (e) {
      _logger.warning('----------------------------');
      _logger.warning('request error: ');
      _logger.warning('$url $e');
      if (method != 'GET') _logger.warning('params $data');
      _logger.warning('----------------------------');
    }

    return model;
  }
}
