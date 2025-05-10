import 'dart:io';

import 'package:adhdo_it_mob/ui/dialogs/filter_dialog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const TaskModel._();
  const factory TaskModel({
    required int id,
    required String title,
    @JsonKey(name: 'image') final String? backgroundImage,
    @JsonKey(includeToJson: false, includeFromJson: false)
    final File? imageFile,
    required DateTime date,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    required int priority,
    //
    @JsonKey(name: 'duration_in_seconds') required int durationInSeconds,
    @JsonKey(name: 'started_at') final DateTime? startedAt,
    @JsonKey(name: 'paused_at') final DateTime? pausedAt,
  }) = _TaskModel;
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'priority': priority,
      'duration_in_seconds': durationInSeconds,
    };
  }
}

@freezed
abstract class TaskParamsModel with _$TaskParamsModel {
  const TaskParamsModel._();

  const factory TaskParamsModel({
    @Default(0) final int page,

    final DateTime? byDate,
    final int? byTime,
    @Default(TaskFilter.all) final TaskFilter filterType,
  }) = _TaskParamsModel;

  factory TaskParamsModel.fromJson(Map<String, dynamic> json) =>
      _$TaskParamsModelFromJson(json);

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      if (filterType.isByPriority) 'by_priority': true,
      if (byDate != null) 'by_date': byDate,
      if (byTime != null) 'by_time': byTime,
    };
  }
}
