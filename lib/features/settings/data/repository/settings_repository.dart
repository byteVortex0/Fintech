import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fintech/features/settings/data/models/user_profile_model.dart';

/// Settings Repository for Firestore operations
/// Handles fetching user profile data from Firestore
class SettingsRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SettingsRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  /// Get current user profile from Firestore
  /// Fetches data from users collection using current user's UID
  Future<UserProfileModel> getUserProfile() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        // Return default profile if document doesn't exist
        final displayName = currentUser.displayName ?? 'User';
        final nameParts = displayName.split(' ');
        return UserProfileModel(
          firstName: nameParts.isNotEmpty ? nameParts[0] : 'User',
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          profileImagePath: currentUser.photoURL ?? '',
          email: currentUser.email ?? '',
        );
      }

      // Map Firestore document to UserProfileModel
      final data = userDoc.data();
      final displayName =
          data?['firstName'] ?? currentUser.displayName ?? 'User';
      final lastName = data?['lastName'] ?? '';
      return UserProfileModel(
        firstName: displayName,
        lastName: lastName,
        profileImagePath:
            data?['profileImagePath'] ?? currentUser.photoURL ?? '',
        email: data?['email'] ?? currentUser.email ?? '',
      );
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }
}
