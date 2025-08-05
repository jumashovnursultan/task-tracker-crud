import 'package:to_do/data/models/api_response.dart';
import 'package:to_do/data/models/token.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
import '../client/client.dart';

abstract final class UserRepo {
  Future<ApiResponse> login(String email);
  Future<ApiResponse<Token>> codeVerify(String email, String code);
}

base class UserAPIRepo implements UserRepo {
  const UserAPIRepo({required ApiClient client}) : _client = client;
  final ApiClient _client;

  @override
  Future<ApiResponse> login(String email) async {
    return _client.post('/auth/register/', data: {'email': email});
  }

  @override
  Future<ApiResponse<Token>> codeVerify(String email, String code) async {
    return _client.post(
      '/auth/email_verify/',
      data: {'code': code, 'email': email},
      decoder: (data) => Token.fromMap(data),
    );
  }
}
