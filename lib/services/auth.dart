import 'package:bucketlist/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth;

  Auth({FirebaseAuth firebaseAuth})
      : this._auth = firebaseAuth == null ? FirebaseAuth.instance : firebaseAuth;

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future<User> getUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user == null ? null : _userFromFirebaseUser(user);
  }

  Future<User> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> handleSignOut() async {
    return Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    return User(firebaseUser.uid, firebaseUser.displayName);
  }
}