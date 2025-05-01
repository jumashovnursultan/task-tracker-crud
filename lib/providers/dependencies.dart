import 'package:adhdo_it_mob/data/client/client.dart';
import 'package:adhdo_it_mob/data/repo/user_repo.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/config.dart';

import '../data/storage/local_storage.dart';

final localStorageProvider = Provider((ref) => LocalStorage());

final dioProvider = Provider(
  (ref) => Dio(BaseOptions(baseUrl: Constants.baseUrl)),
);

final apiClientProvider = Provider(
  (ref) =>
      ApiClient(Constants.baseUrl, storage: ref.read(localStorageProvider)),
);

final userRepoProvider = Provider<UserRepo>((ref) {
  return UserAPIRepo(client: ref.watch(apiClientProvider));
});
