import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khatam_counter/services/database.dart';
import 'package:khatam_counter/user.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(user.uid, user.displayName, user.email) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Observable<FirebaseUser> userr;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService(){
    userr = Observable(_auth.onAuthStateChanged);

    profile = userr.switchMap((FirebaseUser u) {
      if (u != null){
        return _firestore
        .collection('user')
        .document(u.uid)
        .snapshots()
        .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    updateUserData(user);
    loading.add(false);
    await DatabaseService(uid: user.uid).updateData(12, 1, 2, 5);
    return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _firestore.collection("user").document(user.uid);
    
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);

  }

  void signOut(){
    _auth.signOut();
  }
}

final AuthService authService = AuthService();