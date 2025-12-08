import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required String name,
    required String profileImagePath,
    required String email,
  }) = _UserProfileModel;
}
