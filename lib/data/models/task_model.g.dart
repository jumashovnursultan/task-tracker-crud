// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  backgroundImage: json['image'] as String?,
  date: DateTime.parse(json['date'] as String),
  durationInSeconds: (json['duration_in_seconds'] as num).toInt(),
  priority: (json['priority'] as num).toInt(),
);

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.backgroundImage,
      'date': instance.date.toIso8601String(),
      'duration_in_seconds': instance.durationInSeconds,
      'priority': instance.priority,
    };

_TaskParamsModel _$TaskParamsModelFromJson(Map<String, dynamic> json) =>
    _TaskParamsModel(
      page: (json['page'] as num?)?.toInt() ?? 0,
      byPriority: json['byPriority'] as bool?,
      byDate:
          json['byDate'] == null
              ? null
              : DateTime.parse(json['byDate'] as String),
      byTime: (json['byTime'] as num?)?.toInt(),
      filterType:
          $enumDecodeNullable(_$TaskFilterEnumMap, json['filterType']) ??
          TaskFilter.all,
    );

Map<String, dynamic> _$TaskParamsModelToJson(_TaskParamsModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'byPriority': instance.byPriority,
      'byDate': instance.byDate?.toIso8601String(),
      'byTime': instance.byTime,
      'filterType': _$TaskFilterEnumMap[instance.filterType]!,
    };

const _$TaskFilterEnumMap = {
  TaskFilter.all: 'all',
  TaskFilter.byPriority: 'byPriority',
  TaskFilter.byDate: 'byDate',
  TaskFilter.byTime: 'byTime',
};
