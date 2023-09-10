import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  late FirebaseAuth _firebaseAuth;

  AuthService({FirebaseAuth? instance}) {
    _firebaseAuth = instance ?? FirebaseAuth.instance;
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) {
      throw FirebaseAuthException(
        code: 'operation-cancelled',
        message: 'errors.cancelled'.tr(),
      );
    }

    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.cancelled) {
      throw FirebaseAuthException(
        code: 'operation-cancelled',
        message: 'errors.cancelled'.tr(),
      );
    }

    final OAuthCredential credential = FacebookAuthProvider.credential(
      loginResult.accessToken!.token,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (_firebaseAuth.currentUser?.emailVerified == false) {
      signOut();
      throw FirebaseAuthException(
        code: 'no-verified-email',
        message: 'errors.emailNotVerified'.tr(),
      );
    }
  }

  Future<void> signUp(String email, String password, String fullName) async {
    UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.updateDisplayName(fullName);
    await credential.user?.sendEmailVerification();

    if (credential.user != null) {
      signOut();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
