// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {

 LoginStatus get status; String? get error; String? get googleAccessToken;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.googleAccessToken, googleAccessToken) || other.googleAccessToken == googleAccessToken));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,googleAccessToken);

@override
String toString() {
  return 'LoginState(status: $status, error: $error, googleAccessToken: $googleAccessToken)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 LoginStatus status, String? error, String? googleAccessToken
});




}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? googleAccessToken = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoginStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,googleAccessToken: freezed == googleAccessToken ? _self.googleAccessToken : googleAccessToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _LoginState implements LoginState {
  const _LoginState({this.status = LoginStatus.initial, this.error, this.googleAccessToken});
  

@override@JsonKey() final  LoginStatus status;
@override final  String? error;
@override final  String? googleAccessToken;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.googleAccessToken, googleAccessToken) || other.googleAccessToken == googleAccessToken));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,googleAccessToken);

@override
String toString() {
  return 'LoginState(status: $status, error: $error, googleAccessToken: $googleAccessToken)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 LoginStatus status, String? error, String? googleAccessToken
});




}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? googleAccessToken = freezed,}) {
  return _then(_LoginState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoginStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,googleAccessToken: freezed == googleAccessToken ? _self.googleAccessToken : googleAccessToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
