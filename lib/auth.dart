import 'package:firebase_auth/firebase_auth.dart';
import 'package:revolt/models.dart';
import 'package:revolt/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

class Auth {
  static Future login(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future registerWithEmail(IUser myUser) async {
    try {
      var myauth = await _auth.createUserWithEmailAndPassword(
          email: myUser.email, password: myUser.password);
      _firebaseMessaging.getToken().then((token) {
        myUser.token = token;
        myUser.id = myauth.user.uid;
        myauth.user.updateProfile(displayName: myUser.userName);
        // firestore.collection('newusers').doc(myUser.email).set(myUser.asMap());
      });
      Services().users().save(myUser);
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      Future.delayed(Duration.zero, () {
        if (e.code == 'invalid-email') {
          return 'Error : Your Email is Not Valid';
        } else if (e.code == 'user-not-found') {
          return 'Error : User Not Found try again';
        } else if (e.code == 'wrong-password') {
          return 'Error : Your Password is wrong';
        }
        if (e.code == 'weak-password') {
          return 'Your Password is too Weak';
        } else if (e.code == 'email-already-in-use') {
          return 'Your E-Mail is used already try another or try to login anonim';
        }
      });
    } catch (e) {
      return e.toString();
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
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

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
