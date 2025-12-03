class FirebaseErrorHandler {
  static String errorHandle(String error) {
    switch (error) {
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'user-not-found':
        return 'The email address is not valid.';
      case 'wrong-password':
        return 'The password is invalid.';
      default:
        return 'Check your internet connection';
    }
  }
}
