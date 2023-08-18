// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';
import 'package:portfolio/view/screens/loginScreen/elements/textField.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController EmailController = TextEditingController();

  Future _sendlink() async {
    try {
      //if the try catch is not working and throwing exceptation than it means
      //you havent use await keywoard
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
        setState(() {
          showError('Please provide a valid email address.');
        });
      }

      if (EmailController.text.trim() == '') {
        // if the Email is empty
        setState(() {
          showError('Enter your Email.');
        });
      }

      if (e.code.toString() == 'user-not-found') {
        //if There is no  User in the database
        setState(() {
          showError('User not found.');
        });
      }
    }
  }

  void showError(String errorMessage) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: ((context, Constraints) {
      return SingleChildScrollView(
          child: SafeArea(
              child: Container(
        margin: EdgeInsets.only(
            top: Constraints.maxHeight * 0.075,
            left: Constraints.maxWidth * 0.034,
            right: Constraints.maxWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
                text: "Provide your Email",
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w600),
            Padding(
              padding: EdgeInsets.only(
                top: Constraints.maxHeight * 0.024,
              ),
              child: MyText(
                  text:
                      'We will send you \npassword reset link on \nyour email',
                  color: Color(0xff7E7E7E),
                  fontSize: 24,
                  fontWeight: FontWeight.normal),
            ),
            MyTextField(
                controller: EmailController,
                text: 'Enter your Email',
                top: Constraints.maxHeight * 0.14,
                right: Constraints.maxWidth * 0.04,
                left: Constraints.maxWidth * 0.034,
                obscureText: false),
            MyButton(
              myText: 'Send Link',
              ontap: _sendlink,
              left: Constraints.maxWidth * 0.034,
              top: Constraints.maxHeight * 0.08,
              bottom: Constraints.maxHeight * 0.03,
              height: Constraints.maxHeight * 0.077,
              width: Constraints.maxWidth * 0.85,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: Constraints.maxHeight * 0.08),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff3d3d3d),
                    ),
                    child: Icon((Icons.arrow_back),
                        color: Colors.white, size: Constraints.maxWidth * 0.20),
                  ),
                ),
              ),
            )
          ],
        ),
      )));
    })));
  }
}
