import 'package:firebase_auth/firebase_auth.dart';

/// LoginRepository handles Firebase authentication operations
/// Provides email/password sign-in functionality
class LoginRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Sign in with email and password
  /// Throws exception if authentication fails
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('User not found after sign-in');
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  /// Handle Firebase auth exceptions and return user-friendly messages
  String _handleAuthException(FirebaseAuthException e) {
    return switch (e.code) {
      'user-not-found' =>
        'No account found with this email. Please register first.',
      'wrong-password' => 'Incorrect password. Please try again.',
      'invalid-email' => 'Please enter a valid email address.',
      'user-disabled' => 'This account has been disabled.',
      'too-many-requests' => 'Too many login attempts. Please try again later.',
      'network-request-failed' =>
        'Network error. Please check your connection.',
      _ => 'Login failed: ${e.message ?? e.code}',
    };
  }
}
