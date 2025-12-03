import 'package:fintech/core/service/firebase/firebase_error_handler.dart';
import 'package:fintech/core/service/firebase/firebase_result.dart';
import 'package:fintech/core/service/firebase/firebase_service.dart';
import 'package:fintech/features/register/data/models/create_user_request_body.dart';
import 'package:fintech/features/register/data/models/register_request_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class RegisterRepo {
  final FirebaseService _firebaseService;
  RegisterRepo(this._firebaseService);

  Future<FirebaseResult<UserCredential>> createUser(
    RegisterUserRequestBody user,
  ) async {
    try {
      UserCredential credential = await _firebaseService.createUser(user);
      return FirebaseResult.success(credential);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.failure(FirebaseErrorHandler.errorHandle(e.code));
    } catch (e) {
      return FirebaseResult.failure(e.toString());
    }
  }

  Future<FirebaseResult<String>> storeUser({
    required UserCredential user,
    required CreateUserRequestBody createUserRequestBody,
  }) async {
    try {
      await _firebaseService.storeUser(
        user: user,
        createUserRequestBody: createUserRequestBody,
      );
      return const FirebaseResult.success('Store User Successfully');
    } on firebase_core.FirebaseException catch (e) {
      return FirebaseResult.failure(e.message ?? 'User Not Stored');
    } catch (e) {
      return FirebaseResult.failure(e.toString());
    }
  }
}
