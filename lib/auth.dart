import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revolt/models.dart';
import 'package:revolt/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

class Auth {
  static Future<AppUser> login(String email, String password) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (value.user.uid.isNotEmpty) {}
    });
  }

  static Future<AppUser> registerWithEmail(AppUser user, context) {
    return _auth
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((credential) {
      return _firebaseMessaging.getToken().then((token) {
        user.id = credential.user.uid;
        user.token = token;
        credential.user.updateProfile(displayName: user.displayName);

        return Services().users().save(user);
      });
    });
  }

  static Future<UserCredential> signInWithGoogle(context, AppUser user) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AppUser _iuser = new AppUser();

    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      if (value.user != null) {
        _firebaseMessaging.getToken().then((token) {
          _iuser.token = token;
          _iuser.id = value.user.uid;
          _auth.currentUser.updateProfile(displayName: _iuser.userName);
        });
        Services().users().save(_iuser);
        Navigator.pushNamedAndRemoveUntil(
            context, "/dashboard", (route) => false);
      }
    });
  }

  static User getUserCredentials() {
    return _auth.currentUser;
  }
}
