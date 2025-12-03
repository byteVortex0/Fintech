import 'package:fintech/core/service/firebase/firebase_error_handler.dart';
import 'package:fintech/core/service/firebase/firebase_result.dart';
import 'package:fintech/core/service/firebase/firebase_service.dart';
import 'package:fintech/features/login/data/models/login_request_body.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  final FirebaseService _firebaseService;
  LoginRepo(this._firebaseService);

  Future<FirebaseResult<UserCredential>> login(
    LoginUserRequestBody loginRequestBody,
  ) async {
    try {
      UserCredential credential = await _firebaseService.login(
        loginRequestBody,
      );
      return FirebaseResult.success(credential);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.failure(FirebaseErrorHandler.errorHandle(e.code));
    } catch (e) {
      return FirebaseResult.failure(e.toString());
    }
  }
}
