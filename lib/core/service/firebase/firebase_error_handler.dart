class FirebaseErrorHandler {
  static String errorHandle(String error) {
    switch (error) {
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      default:
        return 'Check your internet connection';
    }
  }
}
