import 'package:adhdo_it_mob/data/models/api_response.dart';
import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/data/storage/local_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dependencies.dart';

part 'task_providers.freezed.dart';
part 'task_providers.g.dart';

@freezed
abstract class TaskListState with _$TaskListState {
  factory TaskListState({
    @Default(AsyncValue.loading()) final AsyncValue<List<TaskModel>> list,
    @Default(TaskParamsModel()) final TaskParamsModel params,
    @Default(false) final bool isPageNotFound,
  }) = _TaskListState;

  factory TaskListState.initial() => TaskListState();
}

@riverpod
class TaskList extends _$TaskList {
  LocalStorage get localStorage => ref.read(localStorageProvider);

  @override
  TaskListState build({TaskParamsModel? initialParams}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (initialParams != null) state = state.copyWith(params: initialParams);
      fetchTaskList();
    });

    return TaskListState();
  }

  void fetchTaskList() async {
    final response = await ref
        .read(taskRepoProvider)
        .fetchTasks(params: state.params);
    if (!response.isSuccessful || response.result == null) {
      state = state.copyWith(
        list: AsyncValue.error(response.errorData, StackTrace.current),
      );
    } else {
      state = state.copyWith(
        list: AsyncValue.data(response.result!),
        params: state.params.copyWith(page: 2),
      );
    }
  }

  void filter(TaskParamsModel? params) async {
    if (params == null) {
      state = state.copyWith(params: TaskParamsModel(page: 1));
    } else {
      state = state.copyWith(
        params: state.params.copyWith(page: 1),
        list: AsyncValue.loading(),
      );
    }
    final response = await ref
        .read(taskRepoProvider)
        .fetchTasks(params: state.params);
    if (!response.isSuccessful) {
      state = state.copyWith(
        list: AsyncValue.error(response.errorData, StackTrace.current),
        isPageNotFound: false,
      );
    } else {
      state = state.copyWith(
        list: AsyncValue.data(response.result!),
        params: state.params.copyWith(page: 2),
      );
    }
  }

  void loadMore() async {
    if (state.list.isLoading ||
        state.list.isRefreshing ||
        state.list.isReloading ||
        state.isPageNotFound) {
      return;
    }

    state = state.copyWith(
      list: const AsyncValue<List<TaskModel>>.loading().copyWithPrevious(
        state.list,
      ),
    );

    final response = await ref
        .read(taskRepoProvider)
        .fetchTasks(params: state.params);
    if (!response.isSuccessful) {
      state = state.copyWith(
        list: AsyncValue.data([...?state.list.value]),
        isPageNotFound: true,
      );
    } else {
      state = state.copyWith(
        list: AsyncValue.data([...?state.list.value, ...?response.result]),
        params: state.params.copyWith(page: (state.params.page) + 1),
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(
      params: state.params.copyWith(page: 1),
      list: const AsyncValue.loading(),
    );
    final response = await ref
        .read(taskRepoProvider)
        .fetchTasks(params: state.params);
    if (response.isSuccessful) {
      state = state.copyWith(
        list: AsyncValue.data(response.result!),
        isPageNotFound: false,
      );
    } else {
      state = state.copyWith(
        list: AsyncValue.error(response.errorData, StackTrace.current),
      );
    }
  }

  void addTask(TaskModel model) {
    state = state.copyWith(
      list: AsyncValue.data([...?state.list.value, model]),
    );
  }
}

@riverpod
Future<ApiResponse<TaskModel>> createTask(Ref ref, TaskModel model) async {
  final response = await ref.read(taskRepoProvider).createTask(model);

  return response;
}
