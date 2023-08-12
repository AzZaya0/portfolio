import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';
import 'package:portfolio/view/screens/loginScreen/elements/textField.dart';
import 'package:portfolio/view/screens/loginScreen/screens/forgotpassword.dart';
import 'package:portfolio/view/screens/loginScreen/screens/signupScreen.dart';
import 'package:portfolio/view/services/authService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameCOntroller = TextEditingController();
  final passController = TextEditingController();
  bool _obsecureText = true;

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameCOntroller.text, password: passController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showError(e.code);
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
                      text: 'Login',
                      fontSize: 64,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  MyTextField(
                    obscureText: false,
                    text: 'Username',
                    controller: usernameCOntroller,
                    left: Constraints.maxWidth * 0.032,
                    right: Constraints.maxWidth * 0.032,
                    top: Constraints.maxHeight * 0.135,
                  ),
                  MyTextField(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        },
                        child: _obsecureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    obscureText: _obsecureText,
                    text: 'Password',
                    controller: passController,
                    left: Constraints.maxWidth * 0.032,
                    right: Constraints.maxWidth * 0.032,
                    top: Constraints.maxHeight * 0.06,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: Constraints.maxHeight * 0.035,
                          left: Constraints.maxWidth * 0.5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: MyText(
                          text: 'Forgot Password?',
                          fontSize: 20,
                          color: Color(0xff7e7e7e),
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                  MyButton(
                    myText: 'Login',
                    ontap: signIn,
                    left: Constraints.maxWidth * 0.03,
                    top: Constraints.maxHeight * 0.018,
                    bottom: Constraints.maxHeight * 0.03,
                    height: Constraints.maxHeight * 0.077,
                    width: Constraints.maxWidth * 0.86,
                  ),
                  Center(
                    child: MyText(
                      fontWeight: FontWeight.normal,
                      text: 'or continue with',
                      fontSize: 24,
                      color: Color(0xff7e7e7e),
                    ),
                  ),
                  SizedBox(
                    height: Constraints.maxHeight * 0.03,
                  ),
                  Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        AuthService().signInWithGoogle();
                      },
                      child: Image.asset(
                        'lib/assets/icons/google.png',
                        height: Constraints.maxHeight * 0.08,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Constraints.maxHeight * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                            text: 'Don\'t have an account?',
                            color: Color(0xFF7e7e7e),
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignUp();
                            }));
                          },
                          child: MyText(
                              text: ' Signup',
                              color: Color(0xff03b44a),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}
