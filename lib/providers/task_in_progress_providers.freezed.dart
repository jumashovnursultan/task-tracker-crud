// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_in_progress_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskInProgressState {

// @Default(CompleteTaskStatus.initial)
// final CompleteTaskStatus completeTaskStatus,
// @Default(PauseTaskStatus.initial) final PauseTaskStatus pauseTaskStatus,
 String get errorText;
/// Create a copy of TaskInProgressState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskInProgressStateCopyWith<TaskInProgressState> get copyWith => _$TaskInProgressStateCopyWithImpl<TaskInProgressState>(this as TaskInProgressState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskInProgressState&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,errorText);

@override
String toString() {
  return 'TaskInProgressState(errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class $TaskInProgressStateCopyWith<$Res>  {
  factory $TaskInProgressStateCopyWith(TaskInProgressState value, $Res Function(TaskInProgressState) _then) = _$TaskInProgressStateCopyWithImpl;
@useResult
$Res call({
 String errorText
});




}
/// @nodoc
class _$TaskInProgressStateCopyWithImpl<$Res>
    implements $TaskInProgressStateCopyWith<$Res> {
  _$TaskInProgressStateCopyWithImpl(this._self, this._then);

  final TaskInProgressState _self;
  final $Res Function(TaskInProgressState) _then;

/// Create a copy of TaskInProgressState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errorText = null,}) {
  return _then(_self.copyWith(
errorText: null == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _TaskInProgressState implements TaskInProgressState {
   _TaskInProgressState({this.errorText = 'Something went wrong'});
  

// @Default(CompleteTaskStatus.initial)
// final CompleteTaskStatus completeTaskStatus,
// @Default(PauseTaskStatus.initial) final PauseTaskStatus pauseTaskStatus,
@override@JsonKey() final  String errorText;

/// Create a copy of TaskInProgressState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskInProgressStateCopyWith<_TaskInProgressState> get copyWith => __$TaskInProgressStateCopyWithImpl<_TaskInProgressState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskInProgressState&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,errorText);

@override
String toString() {
  return 'TaskInProgressState(errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class _$TaskInProgressStateCopyWith<$Res> implements $TaskInProgressStateCopyWith<$Res> {
  factory _$TaskInProgressStateCopyWith(_TaskInProgressState value, $Res Function(_TaskInProgressState) _then) = __$TaskInProgressStateCopyWithImpl;
@override @useResult
$Res call({
 String errorText
});




}
/// @nodoc
class __$TaskInProgressStateCopyWithImpl<$Res>
    implements _$TaskInProgressStateCopyWith<$Res> {
  __$TaskInProgressStateCopyWithImpl(this._self, this._then);

  final _TaskInProgressState _self;
  final $Res Function(_TaskInProgressState) _then;

/// Create a copy of TaskInProgressState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorText = null,}) {
  return _then(_TaskInProgressState(
errorText: null == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
