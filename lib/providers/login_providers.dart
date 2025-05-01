import 'package:adhdo_it_mob/providers/dependencies.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_providers.g.dart';
part 'login_providers.freezed.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isError => this == error;
}

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,
    String? error,
    String? googleAccessToken,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(status: LoginStatus.initial);
}

@riverpod
class Login extends _$Login {
  @override
  LoginState build() {
    return LoginState.initial();
  }

  Future<void> login(String email, String password) async {
    state = const LoginState(status: LoginStatus.loading);
    final response = await ref.read(userRepoProvider).login(email, password);
    if (response.isSuccessful) {
      state = const LoginState(status: LoginStatus.success);
    } else {
      state = LoginState(status: LoginStatus.error, error: response.errorData);
    }
  }
}
