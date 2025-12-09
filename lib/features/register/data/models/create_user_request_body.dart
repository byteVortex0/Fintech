import 'package:json_annotation/json_annotation.dart';

part 'create_user_request_body.g.dart';

@JsonSerializable()
class CreateUserRequestBody {
  final String uid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  CreateUserRequestBody({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  factory CreateUserRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestBodyToJson(this);
}
