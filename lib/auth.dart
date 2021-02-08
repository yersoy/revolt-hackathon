import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revolt/models.dart';
import 'package:revolt/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseMessaging _messaging = new FirebaseMessaging();

class Auth {
  static Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<AppUser> registerWithEmail(AppUser user) {
    return _auth
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((credential) {
      return _messaging.getToken().then((token) {
        user.id = credential.user.uid;
        user.token = token;
        credential.user.updateProfile(displayName: user.displayName);

        return Services().users().save(user);
      });
    });
  }

  static Future<UserCredential> signInWithGoogle(AppUser user) {
    // Trigger the authentication flow
    GoogleSignIn()
        .signIn()
        .then((account) => account.authentication)
        .then((auth) {
      final credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken);

      return FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((credential) => credential.user)
          .then((ouser) {
        if (ouser == null) {
          return null;
        }

        _messaging.getToken().then((token) {
          final user = AppUser(
              id: ouser.uid,
              firstName: ouser.displayName,
              email: ouser.email,
              token: token);
          _auth.currentUser.updateProfile(displayName: user.userName);

          return Services().users().save(user);
        });
      });
    });
  }

  static User getUserCredentials() {
    return _auth.currentUser;
  }

  static Future userSignOut() {
    return _auth.signOut();
  }
}
