import 'package:adhdo_it_mob/providers/dependencies.dart';
import 'package:adhdo_it_mob/providers/user_providers.dart';
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

  Future<void> login(String email) async {
    state = state.copyWith(status: LoginStatus.loading);
    final response = await ref.read(userRepoProvider).login(email);
    if (response.isSuccessful) {
      state = state.copyWith(status: LoginStatus.success);
    } else {
      state = state.copyWith(
        status: LoginStatus.error,
        error: response.errorData,
      );
    }
  }
}

enum VerifyCodeStatus {
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
abstract class VerifyCodeState with _$VerifyCodeState {
  const factory VerifyCodeState({
    @Default(VerifyCodeStatus.initial) VerifyCodeStatus status,

    String? error,
    String? googleAccessToken,
  }) = _VerifyCodeState;

  factory VerifyCodeState.initial() =>
      VerifyCodeState(status: VerifyCodeStatus.initial);
}

@riverpod
class VerifyCode extends _$VerifyCode {
  @override
  VerifyCodeState build() {
    return VerifyCodeState.initial();
  }

  Future<void> codeVerify(String email, String code) async {
    state = state.copyWith(status: VerifyCodeStatus.loading);
    final response = await ref.read(userRepoProvider).codeVerify(email, code);
    if (response.isSuccessful) {
      ref.read(userProvider.notifier).authenticate(response.result!);
      state = state.copyWith(status: VerifyCodeStatus.success);
    } else {
      state = state.copyWith(
        status: VerifyCodeStatus.error,
        error: response.errorData,
      );
    }
  }

  Future<void> resendCode(String email) async {
    await ref.read(userRepoProvider).login(email);
  }
}
