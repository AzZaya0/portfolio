import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  //---------------- variables with their functions -------------------------//

//------------------ Obsecure text functions --------------------------//
  bool _obsecuretext = true;
  bool get obsecuretext => _obsecuretext;
  bool _obsecureText = true;
  bool get obsecureText => _obsecureText;

  //-------------------------Variables to store user credentials--------------------------//

  final emailController = TextEditingController();
  TextEditingController get emaillController => emailController;
  final passController = TextEditingController();
  TextEditingController get passCONtroller => passController;
  final confirmPassController = TextEditingController();
  TextEditingController get confirmPassControl => confirmPassController;

  //------------------------ Function to signup -------------------//

  void SignUp(context) async {
    if (passController.text == confirmPassController.text) {
      try {
        UserCredential usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passController.text.trim());

        FirebaseFirestore.instance
            .collection('users')
            .doc(usercredential.user!.email)
            .set(
          {
            'email': emailController.text.trim(),
            'username': emailController.text.split('@')[0],
            'password': passController.text.trim(),
            'profession': '',
            'gender': '',
            'photoUrl': '',
            'number': '',
          },
        );

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        showwError(e.code);
      }
    } else {
      showwError('Password doesn\'t match');
    }
  }

  void showwError(String message, context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          );
        });
  }
}
