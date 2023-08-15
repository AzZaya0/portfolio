import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/Home/pages/genderPage.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';
import 'package:portfolio/view/screens/loginScreen/elements/textField.dart';

import 'package:portfolio/view/services/authService.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  bool _obsecuretext = true;
  bool _obsecureText = true;

  void SignUp(Map<String, dynamic> data) async {
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
            'gender': '',
            'photoUrl': '',
            'number': '',
          },
        );

        // ignore: use_build_context_synchronously

        Navigator.pop(context);

        if (data['gender'] == '') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Gender(),
              ));
        }
      } on FirebaseAuthException catch (e) {
        showwError(e.code);
      }
    } else {
      showwError('Password doesn\'t match');
    }
  }

  void showwError(String message) {
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

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(user?.email!).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

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
                                controller: emailController,
                                text: 'Email',
                                top: Constraints.maxHeight * 0.135,
                                right: Constraints.maxWidth * 0.032,
                                left: Constraints.maxWidth * 0.032),
                            MyTextField(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _obsecuretext = !_obsecuretext;
                                  },
                                  child: Icon(_obsecuretext
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                obscureText: _obsecuretext,
                                controller: passController,
                                text: 'Password ',
                                top: Constraints.maxHeight * 0.05,
                                right: Constraints.maxWidth * 0.032,
                                left: Constraints.maxWidth * 0.032),
                            MyTextField(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _obsecureText = !_obsecureText;
                                  },
                                  child: Icon(_obsecureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                obscureText: _obsecureText,
                                controller: confirmPassController,
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
                                SignUp(data);
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
          return CircularProgressIndicator();
        }));
  }
}
