import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/loginScreen/Providers/signupProvider.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';
import 'package:portfolio/view/screens/loginScreen/elements/textField.dart';

import 'package:portfolio/view/services/authService.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    //---------------------provider---------------------------//
    final signuppProvider = Provider.of<SignupProvider>(context, listen: false);
    return Scaffold(
      body: LayoutBuilder(builder: ((context, Constraints) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Container(
                margin: EdgeInsets.only(
                    top: Constraints.maxHeight * 0.065,
                    left: Constraints.maxWidth * 0.034,
                    right: Constraints.maxWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                        text: 'Sign up',
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w600),
                    MyTextField(
                        obscureText: false,
                        controller: signuppProvider.emaillController,
                        text: 'Email',
                        top: Constraints.maxHeight * 0.135,
                        right: Constraints.maxWidth * 0.032,
                        left: Constraints.maxWidth * 0.032),
                    MyTextField(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            signuppProvider.obsecuretext =
                                !signuppProvider.obsecuretext;
                          },
                          child: Icon(signuppProvider.obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        obscureText: signuppProvider.obsecuretext,
                        controller: signuppProvider.passCONtroller,
                        text: 'Password ',
                        top: Constraints.maxHeight * 0.05,
                        right: Constraints.maxWidth * 0.032,
                        left: Constraints.maxWidth * 0.032),
                    MyTextField(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            signuppProvider.obsecuretext =
                                !signuppProvider.obsecuretext;
                          },
                          child: Icon(signuppProvider.obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        obscureText: signuppProvider.obsecureText,
                        controller: signuppProvider.confirmPassControl,
                        text: 'Confirm password ',
                        top: Constraints.maxHeight * 0.05,
                        right: Constraints.maxWidth * 0.032,
                        left: Constraints.maxWidth * 0.032),
                    MyButton(
                      myText: 'Signup',
                      bottom: Constraints.maxHeight * 0.05,
                      top: Constraints.maxHeight * 0.045,
                      left: Constraints.maxWidth * 0.03,
                      height: Constraints.maxHeight * 0.077,
                      width: Constraints.maxWidth * 0.86,
                      ontap: () {
                        signuppProvider.SignUp(context);
                      },
                    ),
                    Center(
                      child: MyText(
                          text: 'or continue with',
                          color: Color(0xff7e7e7e),
                          fontSize: 24,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: Constraints.maxHeight * 0.03,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          AuthService().signInWithGoogle();
                        },
                        child: Image.asset(
                          'lib/assets/icons/google.png',
                          height: Constraints.maxHeight * 0.08,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      })),
    );
  }
}
