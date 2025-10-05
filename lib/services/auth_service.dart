import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ──────────────────────────────
  // Save user info to Firestore
  // ──────────────────────────────
  Future<void> _saveUserToFirestore(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);

    final userDoc = await userRef.get();
    if (!userDoc.exists) {
      await userRef.set({
        'uid': user.uid,
        'name': user.displayName ?? '',
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // ──────────────────────────────
  // Email Registration
  // ──────────────────────────────
  Future<User?> registerWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await cred.user!.updateDisplayName(name);
      await _saveUserToFirestore(cred.user!);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // ──────────────────────────────
  // Email Login
  // ──────────────────────────────
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // ──────────────────────────────
  // Google Sign-In
  // ──────────────────────────────
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // User canceled login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential cred = await _auth.signInWithCredential(credential);
      await _saveUserToFirestore(cred.user!);

      return cred.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // ──────────────────────────────
  // Logout
  // ──────────────────────────────
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  // ──────────────────────────────
  // Auth State Listener
  // ──────────────────────────────
  Stream<User?> get userStream => _auth.authStateChanges();
}
