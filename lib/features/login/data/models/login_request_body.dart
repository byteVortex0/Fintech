import 'package:json_annotation/json_annotation.dart';

part 'login_request_body.g.dart';

@JsonSerializable()
class LoginUserRequestBody {
  final String email;
  final String password;

  LoginUserRequestBody({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginUserRequestBodyToJson(this);
}
