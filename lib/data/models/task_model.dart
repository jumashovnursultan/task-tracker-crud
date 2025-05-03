import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required int id,

    required String title,
    @JsonKey(name: 'image') final String? backgroundImage,
    required DateTime date,
    @JsonKey(name: 'duration_in_seconds') required int durationInSeconds,
    required int priority,
  }) = _TaskModel;
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

@freezed
abstract class TaskParamsModel with _$TaskParamsModel {
  const TaskParamsModel._();

  const factory TaskParamsModel({
    @Default(0) final int page,
    final bool? byPriority,
    final DateTime? byDate,
    final int? byTime,
  }) = _TaskParamsModel;

  factory TaskParamsModel.fromJson(Map<String, dynamic> json) =>
      _$TaskParamsModelFromJson(json);

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      if (byPriority != null) 'by_priority': byPriority,
      if (byDate != null) 'by_date': byDate,
      if (byTime != null) 'by_time': byTime,
    };
  }
}
