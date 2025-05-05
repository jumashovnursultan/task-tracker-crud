import 'package:adhdo_it_mob/data/models/api_response.dart';
import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:dio/dio.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
import '../client/client.dart';

abstract final class TaskRepo {
  Future<ApiResponse<TaskModel>> createTask(TaskModel model);
  Future<ApiResponse<List<TaskModel>>> fetchTasks({TaskParamsModel? params});
}

base class TaskAPIRepo implements TaskRepo {
  const TaskAPIRepo({required ApiClient client}) : _client = client;
  final ApiClient _client;

  @override
  Future<ApiResponse<List<TaskModel>>> fetchTasks({
    TaskParamsModel? params,
  }) async {
    return ApiResponse(
      statusCode: 200,
      errorData: 'error data',
      result: [
        TaskModel(
          id: 1,
          title: 'Write a post for Instagram',
          date: DateTime.now(),
          durationInSeconds: 900,
          priority: 5,
        ),
        TaskModel(
          id: 1,
          title: 'Write a post for Instagram',
          date: DateTime.now(),
          durationInSeconds: 900,
          priority: 4,
        ),
        TaskModel(
          id: 1,
          title: 'Write a post for Instagram',
          date: DateTime.now(),
          durationInSeconds: 900,
          priority: 3,
        ),
        TaskModel(
          id: 1,
          title: 'Write a post for Instagram',
          date: DateTime.now(),
          durationInSeconds: 900,
          priority: 2,
        ),
        TaskModel(
          id: 1,
          title: 'Write a post for Instagram',
          date: DateTime.now(),
          durationInSeconds: 900,
          priority: 1,
        ),
        TaskModel(
          id: 1,
          title: 'Write a post for Instagram',
          date: DateTime.now(),
          durationInSeconds: 900,
          priority: 0,
        ),
        TaskModel(
          id: 1,
          title: 'Write a post for Instagram',
          date: DateTime.now(),
          durationInSeconds: 900,
          priority: 0,
          backgroundImage:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXj7QjMMoCdapfYvSvcJB0uMFg9j1av0zTdQ&s',
        ),
      ],
    );
    // return _client.get(
    //   '/tasks/task_list/',

    //   decoder: (data) => List.from(data.map((e) => TaskModel.fromJson(e))),
    // );
  }

  @override
  Future<ApiResponse<TaskModel>> createTask(TaskModel model) async {
    final data = {
      ...model.toMap(),
      if (model.imageFile != null)
        'image': await MultipartFile.fromFile(
          model.imageFile!.path,
          filename: model.imageFile!.path.split('/').last,
        ),
    };
    return await _client.post(
      '/tasks/task_create/',
      data: FormData.fromMap(data),
      decoder: (data) {
        return TaskModel.fromJson(data);
      },
    );
  }
}
