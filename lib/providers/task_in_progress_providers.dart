import 'package:adhdo_it_mob/data/storage/local_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dependencies.dart';

part 'task_in_progress_providers.freezed.dart';
part 'task_in_progress_providers.g.dart';

enum CompleteTaskStatus {
  initial,
  loading,
  complete,
  error;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isComplete => this == complete;
  bool get isError => this == error;
}

enum PauseTaskStatus {
  initial,
  pause,
  error;

  bool get isInitial => this == initial;
  bool get isPause => this == pause;
  bool get isError => this == error;
}

@freezed
abstract class TaskInProgressState with _$TaskInProgressState {
  factory TaskInProgressState({
    // @Default(CompleteTaskStatus.initial)
    // final CompleteTaskStatus completeTaskStatus,
    // @Default(PauseTaskStatus.initial) final PauseTaskStatus pauseTaskStatus,
    @Default('Something went wrong') final String errorText,
  }) = _TaskInProgressState;

  factory TaskInProgressState.initial() => TaskInProgressState();
}

@riverpod
class TaskInProgress extends _$TaskInProgress {
  LocalStorage get localStorage => ref.read(localStorageProvider);

  @override
  TaskInProgressState build() {
    return TaskInProgressState();
  }

  Future<void> startTask(int id) async {
    // state = state.copyWith(completeTaskStatus: CompleteTaskStatus.complete);
    await ref.read(taskRepoProvider).startTask(id);
  }

  Future<void> completeTask(int id, int updatedDurationInSeconds) async {
    // state = state.copyWith(completeTaskStatus: CompleteTaskStatus.complete);
    await ref.read(taskRepoProvider).completeTask(id, updatedDurationInSeconds);
  }

  Future<void> pauseTask(int id, int updatedDurationInSeconds) async {
    // state = state.copyWith(pauseTaskStatus: PauseTaskStatus.pause);

    await ref.read(taskRepoProvider).pauseTask(id, updatedDurationInSeconds);
  }
}
