// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskModel {

 int get id; String get title;@JsonKey(name: 'image') String? get backgroundImage;@JsonKey(includeToJson: false, includeFromJson: false) dynamic get imageFile; DateTime get date;@JsonKey(name: 'created_at') DateTime? get createdAt; int get priority;@JsonKey(name: 'duration_in_seconds') int get durationInSeconds;@JsonKey(name: 'updated_duration_in_seconds') int? get updatedDurationInSeconds;
/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskModelCopyWith<TaskModel> get copyWith => _$TaskModelCopyWithImpl<TaskModel>(this as TaskModel, _$identity);

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.backgroundImage, backgroundImage) || other.backgroundImage == backgroundImage)&&const DeepCollectionEquality().equals(other.imageFile, imageFile)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.durationInSeconds, durationInSeconds) || other.durationInSeconds == durationInSeconds)&&(identical(other.updatedDurationInSeconds, updatedDurationInSeconds) || other.updatedDurationInSeconds == updatedDurationInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,backgroundImage,const DeepCollectionEquality().hash(imageFile),date,createdAt,priority,durationInSeconds,updatedDurationInSeconds);

@override
String toString() {
  return 'TaskModel(id: $id, title: $title, backgroundImage: $backgroundImage, imageFile: $imageFile, date: $date, createdAt: $createdAt, priority: $priority, durationInSeconds: $durationInSeconds, updatedDurationInSeconds: $updatedDurationInSeconds)';
}


}

/// @nodoc
abstract mixin class $TaskModelCopyWith<$Res>  {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) _then) = _$TaskModelCopyWithImpl;
@useResult
$Res call({
 int id, String title,@JsonKey(name: 'image') String? backgroundImage,@JsonKey(includeToJson: false, includeFromJson: false) dynamic imageFile, DateTime date,@JsonKey(name: 'created_at') DateTime? createdAt, int priority,@JsonKey(name: 'duration_in_seconds') int durationInSeconds,@JsonKey(name: 'updated_duration_in_seconds') int? updatedDurationInSeconds
});




}
/// @nodoc
class _$TaskModelCopyWithImpl<$Res>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._self, this._then);

  final TaskModel _self;
  final $Res Function(TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? backgroundImage = freezed,Object? imageFile = freezed,Object? date = null,Object? createdAt = freezed,Object? priority = null,Object? durationInSeconds = null,Object? updatedDurationInSeconds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,backgroundImage: freezed == backgroundImage ? _self.backgroundImage : backgroundImage // ignore: cast_nullable_to_non_nullable
as String?,imageFile: freezed == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as dynamic,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,durationInSeconds: null == durationInSeconds ? _self.durationInSeconds : durationInSeconds // ignore: cast_nullable_to_non_nullable
as int,updatedDurationInSeconds: freezed == updatedDurationInSeconds ? _self.updatedDurationInSeconds : updatedDurationInSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TaskModel extends TaskModel {
  const _TaskModel({required this.id, required this.title, @JsonKey(name: 'image') this.backgroundImage, @JsonKey(includeToJson: false, includeFromJson: false) this.imageFile, required this.date, @JsonKey(name: 'created_at') this.createdAt, required this.priority, @JsonKey(name: 'duration_in_seconds') required this.durationInSeconds, @JsonKey(name: 'updated_duration_in_seconds') this.updatedDurationInSeconds}): super._();
  factory _TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey(name: 'image') final  String? backgroundImage;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  dynamic imageFile;
@override final  DateTime date;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override final  int priority;
@override@JsonKey(name: 'duration_in_seconds') final  int durationInSeconds;
@override@JsonKey(name: 'updated_duration_in_seconds') final  int? updatedDurationInSeconds;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskModelCopyWith<_TaskModel> get copyWith => __$TaskModelCopyWithImpl<_TaskModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.backgroundImage, backgroundImage) || other.backgroundImage == backgroundImage)&&const DeepCollectionEquality().equals(other.imageFile, imageFile)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.durationInSeconds, durationInSeconds) || other.durationInSeconds == durationInSeconds)&&(identical(other.updatedDurationInSeconds, updatedDurationInSeconds) || other.updatedDurationInSeconds == updatedDurationInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,backgroundImage,const DeepCollectionEquality().hash(imageFile),date,createdAt,priority,durationInSeconds,updatedDurationInSeconds);

@override
String toString() {
  return 'TaskModel(id: $id, title: $title, backgroundImage: $backgroundImage, imageFile: $imageFile, date: $date, createdAt: $createdAt, priority: $priority, durationInSeconds: $durationInSeconds, updatedDurationInSeconds: $updatedDurationInSeconds)';
}


}

/// @nodoc
abstract mixin class _$TaskModelCopyWith<$Res> implements $TaskModelCopyWith<$Res> {
  factory _$TaskModelCopyWith(_TaskModel value, $Res Function(_TaskModel) _then) = __$TaskModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title,@JsonKey(name: 'image') String? backgroundImage,@JsonKey(includeToJson: false, includeFromJson: false) dynamic imageFile, DateTime date,@JsonKey(name: 'created_at') DateTime? createdAt, int priority,@JsonKey(name: 'duration_in_seconds') int durationInSeconds,@JsonKey(name: 'updated_duration_in_seconds') int? updatedDurationInSeconds
});




}
/// @nodoc
class __$TaskModelCopyWithImpl<$Res>
    implements _$TaskModelCopyWith<$Res> {
  __$TaskModelCopyWithImpl(this._self, this._then);

  final _TaskModel _self;
  final $Res Function(_TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? backgroundImage = freezed,Object? imageFile = freezed,Object? date = null,Object? createdAt = freezed,Object? priority = null,Object? durationInSeconds = null,Object? updatedDurationInSeconds = freezed,}) {
  return _then(_TaskModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,backgroundImage: freezed == backgroundImage ? _self.backgroundImage : backgroundImage // ignore: cast_nullable_to_non_nullable
as String?,imageFile: freezed == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as dynamic,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,durationInSeconds: null == durationInSeconds ? _self.durationInSeconds : durationInSeconds // ignore: cast_nullable_to_non_nullable
as int,updatedDurationInSeconds: freezed == updatedDurationInSeconds ? _self.updatedDurationInSeconds : updatedDurationInSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TaskParamsModel {

 int get page; DateTime? get byDate; bool? get byTime; TaskFilter get filterType;
/// Create a copy of TaskParamsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskParamsModelCopyWith<TaskParamsModel> get copyWith => _$TaskParamsModelCopyWithImpl<TaskParamsModel>(this as TaskParamsModel, _$identity);

  /// Serializes this TaskParamsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskParamsModel&&(identical(other.page, page) || other.page == page)&&(identical(other.byDate, byDate) || other.byDate == byDate)&&(identical(other.byTime, byTime) || other.byTime == byTime)&&(identical(other.filterType, filterType) || other.filterType == filterType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,byDate,byTime,filterType);

@override
String toString() {
  return 'TaskParamsModel(page: $page, byDate: $byDate, byTime: $byTime, filterType: $filterType)';
}


}

/// @nodoc
abstract mixin class $TaskParamsModelCopyWith<$Res>  {
  factory $TaskParamsModelCopyWith(TaskParamsModel value, $Res Function(TaskParamsModel) _then) = _$TaskParamsModelCopyWithImpl;
@useResult
$Res call({
 int page, DateTime? byDate, bool? byTime, TaskFilter filterType
});




}
/// @nodoc
class _$TaskParamsModelCopyWithImpl<$Res>
    implements $TaskParamsModelCopyWith<$Res> {
  _$TaskParamsModelCopyWithImpl(this._self, this._then);

  final TaskParamsModel _self;
  final $Res Function(TaskParamsModel) _then;

/// Create a copy of TaskParamsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? byDate = freezed,Object? byTime = freezed,Object? filterType = null,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,byDate: freezed == byDate ? _self.byDate : byDate // ignore: cast_nullable_to_non_nullable
as DateTime?,byTime: freezed == byTime ? _self.byTime : byTime // ignore: cast_nullable_to_non_nullable
as bool?,filterType: null == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as TaskFilter,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TaskParamsModel extends TaskParamsModel {
  const _TaskParamsModel({this.page = 0, this.byDate, this.byTime, this.filterType = TaskFilter.all}): super._();
  factory _TaskParamsModel.fromJson(Map<String, dynamic> json) => _$TaskParamsModelFromJson(json);

@override@JsonKey() final  int page;
@override final  DateTime? byDate;
@override final  bool? byTime;
@override@JsonKey() final  TaskFilter filterType;

/// Create a copy of TaskParamsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskParamsModelCopyWith<_TaskParamsModel> get copyWith => __$TaskParamsModelCopyWithImpl<_TaskParamsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskParamsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskParamsModel&&(identical(other.page, page) || other.page == page)&&(identical(other.byDate, byDate) || other.byDate == byDate)&&(identical(other.byTime, byTime) || other.byTime == byTime)&&(identical(other.filterType, filterType) || other.filterType == filterType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,byDate,byTime,filterType);

@override
String toString() {
  return 'TaskParamsModel(page: $page, byDate: $byDate, byTime: $byTime, filterType: $filterType)';
}


}

/// @nodoc
abstract mixin class _$TaskParamsModelCopyWith<$Res> implements $TaskParamsModelCopyWith<$Res> {
  factory _$TaskParamsModelCopyWith(_TaskParamsModel value, $Res Function(_TaskParamsModel) _then) = __$TaskParamsModelCopyWithImpl;
@override @useResult
$Res call({
 int page, DateTime? byDate, bool? byTime, TaskFilter filterType
});




}
/// @nodoc
class __$TaskParamsModelCopyWithImpl<$Res>
    implements _$TaskParamsModelCopyWith<$Res> {
  __$TaskParamsModelCopyWithImpl(this._self, this._then);

  final _TaskParamsModel _self;
  final $Res Function(_TaskParamsModel) _then;

/// Create a copy of TaskParamsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? byDate = freezed,Object? byTime = freezed,Object? filterType = null,}) {
  return _then(_TaskParamsModel(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,byDate: freezed == byDate ? _self.byDate : byDate // ignore: cast_nullable_to_non_nullable
as DateTime?,byTime: freezed == byTime ? _self.byTime : byTime // ignore: cast_nullable_to_non_nullable
as bool?,filterType: null == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as TaskFilter,
  ));
}


}

// dart format on
