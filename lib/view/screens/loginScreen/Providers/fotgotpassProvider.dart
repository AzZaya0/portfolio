// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotpassProvider with ChangeNotifier {
//----------------------------- Veriables --------------------------------\\
  TextEditingController _EmailController = TextEditingController();
  TextEditingController get EmailController => _EmailController;
//----------------------------------------------------------------------------\\
  Future sendlink(context) async {
    try {
      //if the try catch is not working and throwing exceptation than it means------\\
      //you havent use await keywoard----------------------------------------------\\
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: EmailController.text.trim())
          .then((value) => showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Center(
                    child: Text(
                      'Reset Link Send! Please Check Your Mail',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                );
              }));
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == 'invalid-email') {
        //if the email is not valid

        showError('Please provide a valid email address.', context);
      }

      if (EmailController.text.trim() == '') {
        // if the Email is empty-------------------------------------------------\\

        showError('Enter your Email.', context);
      }

      if (e.code.toString() == 'user-not-found') {
        //if There is no  User in the database
        showError('User not found.', context);
      }
    }
  }

  void showError(String errorMessage, context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Center(
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          );
        });
  }
}
