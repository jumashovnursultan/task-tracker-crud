// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskListState {

 AsyncValue<List<TaskModel>> get list; TaskParamsModel get params; bool get isPageNotFound;
/// Create a copy of TaskListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskListStateCopyWith<TaskListState> get copyWith => _$TaskListStateCopyWithImpl<TaskListState>(this as TaskListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskListState&&(identical(other.list, list) || other.list == list)&&(identical(other.params, params) || other.params == params)&&(identical(other.isPageNotFound, isPageNotFound) || other.isPageNotFound == isPageNotFound));
}


@override
int get hashCode => Object.hash(runtimeType,list,params,isPageNotFound);

@override
String toString() {
  return 'TaskListState(list: $list, params: $params, isPageNotFound: $isPageNotFound)';
}


}

/// @nodoc
abstract mixin class $TaskListStateCopyWith<$Res>  {
  factory $TaskListStateCopyWith(TaskListState value, $Res Function(TaskListState) _then) = _$TaskListStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<List<TaskModel>> list, TaskParamsModel params, bool isPageNotFound
});


$TaskParamsModelCopyWith<$Res> get params;

}
/// @nodoc
class _$TaskListStateCopyWithImpl<$Res>
    implements $TaskListStateCopyWith<$Res> {
  _$TaskListStateCopyWithImpl(this._self, this._then);

  final TaskListState _self;
  final $Res Function(TaskListState) _then;

/// Create a copy of TaskListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,Object? params = null,Object? isPageNotFound = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<TaskModel>>,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as TaskParamsModel,isPageNotFound: null == isPageNotFound ? _self.isPageNotFound : isPageNotFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of TaskListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskParamsModelCopyWith<$Res> get params {
  
  return $TaskParamsModelCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// @nodoc


class _TaskListState implements TaskListState {
   _TaskListState({this.list = const AsyncValue.loading(), this.params = const TaskParamsModel(), this.isPageNotFound = false});
  

@override@JsonKey() final  AsyncValue<List<TaskModel>> list;
@override@JsonKey() final  TaskParamsModel params;
@override@JsonKey() final  bool isPageNotFound;

/// Create a copy of TaskListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskListStateCopyWith<_TaskListState> get copyWith => __$TaskListStateCopyWithImpl<_TaskListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskListState&&(identical(other.list, list) || other.list == list)&&(identical(other.params, params) || other.params == params)&&(identical(other.isPageNotFound, isPageNotFound) || other.isPageNotFound == isPageNotFound));
}


@override
int get hashCode => Object.hash(runtimeType,list,params,isPageNotFound);

@override
String toString() {
  return 'TaskListState(list: $list, params: $params, isPageNotFound: $isPageNotFound)';
}


}

/// @nodoc
abstract mixin class _$TaskListStateCopyWith<$Res> implements $TaskListStateCopyWith<$Res> {
  factory _$TaskListStateCopyWith(_TaskListState value, $Res Function(_TaskListState) _then) = __$TaskListStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<List<TaskModel>> list, TaskParamsModel params, bool isPageNotFound
});


@override $TaskParamsModelCopyWith<$Res> get params;

}
/// @nodoc
class __$TaskListStateCopyWithImpl<$Res>
    implements _$TaskListStateCopyWith<$Res> {
  __$TaskListStateCopyWithImpl(this._self, this._then);

  final _TaskListState _self;
  final $Res Function(_TaskListState) _then;

/// Create a copy of TaskListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,Object? params = null,Object? isPageNotFound = null,}) {
  return _then(_TaskListState(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<TaskModel>>,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as TaskParamsModel,isPageNotFound: null == isPageNotFound ? _self.isPageNotFound : isPageNotFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of TaskListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskParamsModelCopyWith<$Res> get params {
  
  return $TaskParamsModelCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

// dart format on
