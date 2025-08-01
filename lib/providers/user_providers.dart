import 'package:adhdo_it_mob/providers/client_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:adhdo_it_mob/data/models/token.dart';
import 'package:adhdo_it_mob/data/models/user_model.dart';
import 'package:adhdo_it_mob/providers/dependencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/storage/local_storage.dart';

part 'user_providers.g.dart';
part 'user_providers.freezed.dart';

enum AuthStatus {
  authenticated,
  unauthenticated;

  bool get isAuth => this == authenticated;
  bool get isUnauth => this == unauthenticated;
}

@freezed
abstract class UserState with _$UserState {
  factory UserState({
    @Default(AuthStatus.unauthenticated) AuthStatus authStatus,
    @Default(AsyncValue.loading()) final AsyncValue<UserModel> userProfile,
  }) = _UserState;

  factory UserState.initial() => UserState();
}

@riverpod
class User extends _$User {
  LocalStorage get localStorage => ref.read(localStorageProvider);

  @override
  UserState build() {
    ref.listen(clientErrorProvider, (prev, next) {
      if (next.isUnauthorized && state.authStatus.isAuth) {
        unauthenticate();
      }
    });
    if (localStorage.token != null) {
      // fetchUserProfile();
    }

    return UserState(
      authStatus:
          localStorage.token != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
    );
  }

  void authenticate(Token token) {
    localStorage.token = token;
    state = state.copyWith(authStatus: AuthStatus.authenticated);
    // ref.read(createFCMProvider);
  }

  void unauthenticate() {
    localStorage.token = null;
    localStorage.authSkipped = false;
    state = state.copyWith(authStatus: AuthStatus.unauthenticated);
    // ref.read(deleteFCMProvider);
  }

  Future<void> fetchUserProfile() async {
    // final response = await ref.read(userRepoProvider).fetchUserProfile();

    // if (response.isSuccessful) {
    //   state = state.copyWith(userProfile: AsyncValue.data(response.result!));
    // } else {
    //   state = state.copyWith(
    //     userProfile: AsyncValue.error(
    //       response.errorData.toString(),
    //       StackTrace.current,
    //     ),
    //   );
    // }
  }
}
