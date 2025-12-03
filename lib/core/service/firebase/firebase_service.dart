import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintech/core/service/firebase/firebase_constants.dart';
import 'package:fintech/features/login/data/models/login_request_body.dart';
import 'package:fintech/features/register/data/models/create_user_request_body.dart';
import 'package:fintech/features/register/data/models/register_request_body.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> createUser(
    RegisterUserRequestBody registerUserRequestBody,
  ) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: registerUserRequestBody.email,
      password: registerUserRequestBody.password,
    );
    return credential;
  }

  Future<void> storeUser({
    required UserCredential user,
    required CreateUserRequestBody createUserRequestBody,
  }) async {
    final users = _firestore.collection(FirebaseConstants.users);
    await users.doc(user.user!.uid).set(createUserRequestBody.toJson());
  }

  Future<UserCredential> login(LoginUserRequestBody loginRequestBody) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: loginRequestBody.email,
      password: loginRequestBody.password,
    );
    return credential;
  }
}
