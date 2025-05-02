import 'package:adhdo_it_mob/data/models/api_response.dart';
import 'package:adhdo_it_mob/data/models/token.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
import '../client/client.dart';

abstract final class UserRepo {
  Future<ApiResponse<Token>> login(String email, String password);
  Future<ApiResponse> register(String email, String password);

  Future<ApiResponse<Token>> codeVerify(String email, String? code);
}

base class UserAPIRepo implements UserRepo {
  const UserAPIRepo({required ApiClient client}) : _client = client;
  final ApiClient _client;

  @override
  Future<ApiResponse<Token>> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return ApiResponse(statusCode: 200);
    // _client.post(
    //   'api/fdsa',
    //   data: {'phone': phone},
    //   decoder: (data) {
    //     return Token(access: data, refresh: data);
    //   },
    // );
  }

  @override
  Future<ApiResponse<Token>> codeVerify(String email, String? code) async {
    // return _client.post(
    //   'accounts/verify_code/',
    //   data: {
    //     if (code != null) 'code': code,
    //   },
    // );
    await Future.delayed(Duration(seconds: 2));
    return Future.value(ApiResponse(statusCode: 200));
  }

  @override
  Future<ApiResponse> register(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(ApiResponse(statusCode: 200));
  }
}
