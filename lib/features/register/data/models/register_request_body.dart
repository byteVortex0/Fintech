import 'package:json_annotation/json_annotation.dart';

part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterUserRequestBody {
  final String email;
  final String password;

  RegisterUserRequestBody({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$RegisterUserRequestBodyToJson(this);
}
