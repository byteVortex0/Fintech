import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fintech/features/settings/data/models/user_profile_model.dart';

/// Settings Repository for Firestore operations
/// Handles fetching user profile data from Firestore
class SettingsRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SettingsRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Get current user profile from Firestore
  /// Fetches data from users collection using current user's UID
  Future<UserProfileModel> getUserProfile() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (!userDoc.exists) {
        // Return default profile if document doesn't exist
        return UserProfileModel(
          name: currentUser.displayName ?? 'User',
          profileImagePath: currentUser.photoURL ?? '',
          email: currentUser.email ?? '',
        );
      }

      // Map Firestore document to UserProfileModel
      return UserProfileModel(
        name: userDoc['name'] ?? currentUser.displayName ?? 'User',
        profileImagePath: userDoc['profileImagePath'] ?? '',
        email: userDoc['email'] ?? currentUser.email ?? '',
      );
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }
}
