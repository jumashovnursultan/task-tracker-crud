// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginHash() => r'870314680af7c55b79d98bc19ac073569fede927';

/// See also [Login].
@ProviderFor(Login)
final loginProvider = AutoDisposeNotifierProvider<Login, LoginState>.internal(
  Login.new,
  name: r'loginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Login = AutoDisposeNotifier<LoginState>;
String _$verifyCodeHash() => r'1fd5a95f4180737d2423d310476f89163ca0a929';

/// See also [VerifyCode].
@ProviderFor(VerifyCode)
final verifyCodeProvider =
    AutoDisposeNotifierProvider<VerifyCode, VerifyCodeState>.internal(
      VerifyCode.new,
      name: r'verifyCodeProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$verifyCodeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VerifyCode = AutoDisposeNotifier<VerifyCodeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
