import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/forgotpassword.dart';
import '../screens/signupScreen.dart';

class LoginProvider with ChangeNotifier {
  //---------------- variables with their functions -------------------------//
//--------------------------------Function of Obsecure Text--------------------------//
  bool _obsecureText = true;
  bool get obsecureText => _obsecureText;
  void eyeButtonSwitch() {
    _obsecureText = !_obsecureText;
    notifyListeners();
  }

  //--------------------------------------------------------------------//
//----------------------Veriables to store user crediantials -------------------//
//-----------------------Functions to logIn user with Crediantials ------------------------------------//
  final TextEditingController _usernameCOntroller = TextEditingController();
  TextEditingController get usernameCOntroller => _usernameCOntroller;
  final TextEditingController _passController = TextEditingController();
  TextEditingController get passController => _passController;

  void signIn(context) async {
    //This Function is to login user with Email and Password
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameCOntroller.text, password: passController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showError(e.code, context);
    }
  }

  void showError(String errorMessage, context) {
// This Function is to show Dialoug to user if Any Problem occures during login
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

//---------------------------- [Navigations ]---------------------------------//
//-------------------------------------------------------------------------------------------\\
//----------------------Navigate to ForgotPassword page ---------------------------\\
  void toForgotPassPage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ForgotPasswordPage();
    }));
  }

//----------------------Navigate to SignUp page ---------------------------\\
  void toSignupPage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SignUp();
    }));
  }
//-------------------------------------------------------------------------------//
}
