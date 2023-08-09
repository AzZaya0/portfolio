import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gauth = await guser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken, idToken: gauth.idToken);

    FirebaseFirestore.instance.collection('users').doc(guser.email).set(
      {
        'email': guser.email,
        'username': guser.email.split('@')[0],
        'gender': '',
        'photoUrl': guser.photoUrl,
        'number': '',
      },
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
