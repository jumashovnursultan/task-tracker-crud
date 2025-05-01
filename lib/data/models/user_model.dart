import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({
    int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'last_name') String? surname,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'sign_type') String? signType,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toMap() {
    return {
      if (name != null) 'name': name,
      if (surname != null) 'last_name': surname,
      if (email != null) 'email': email,
    };
  }
}
