// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserState {

 AuthStatus get authStatus; AsyncValue<UserModel> get userProfile;
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStateCopyWith<UserState> get copyWith => _$UserStateCopyWithImpl<UserState>(this as UserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState&&(identical(other.authStatus, authStatus) || other.authStatus == authStatus)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}


@override
int get hashCode => Object.hash(runtimeType,authStatus,userProfile);

@override
String toString() {
  return 'UserState(authStatus: $authStatus, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) _then) = _$UserStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus authStatus, AsyncValue<UserModel> userProfile
});




}
/// @nodoc
class _$UserStateCopyWithImpl<$Res>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._self, this._then);

  final UserState _self;
  final $Res Function(UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authStatus = null,Object? userProfile = null,}) {
  return _then(_self.copyWith(
authStatus: null == authStatus ? _self.authStatus : authStatus // ignore: cast_nullable_to_non_nullable
as AuthStatus,userProfile: null == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as AsyncValue<UserModel>,
  ));
}

}


/// @nodoc


class _UserState implements UserState {
   _UserState({this.authStatus = AuthStatus.unauthenticated, this.userProfile = const AsyncValue.loading()});
  

@override@JsonKey() final  AuthStatus authStatus;
@override@JsonKey() final  AsyncValue<UserModel> userProfile;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserState&&(identical(other.authStatus, authStatus) || other.authStatus == authStatus)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}


@override
int get hashCode => Object.hash(runtimeType,authStatus,userProfile);

@override
String toString() {
  return 'UserState(authStatus: $authStatus, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) _then) = __$UserStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus authStatus, AsyncValue<UserModel> userProfile
});




}
/// @nodoc
class __$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(this._self, this._then);

  final _UserState _self;
  final $Res Function(_UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authStatus = null,Object? userProfile = null,}) {
  return _then(_UserState(
authStatus: null == authStatus ? _self.authStatus : authStatus // ignore: cast_nullable_to_non_nullable
as AuthStatus,userProfile: null == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as AsyncValue<UserModel>,
  ));
}


}

// dart format on
