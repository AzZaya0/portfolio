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
//-------------- Provider signuppProvider to access data from signup Provider----------------//
    final signuppProvider = Provider.of<SignupProvider>(context, listen: false);
    print('build');
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

//<------------------ Consumer wedget to rebuild  ----------------------------//
                    Consumer<SignupProvider>(
                        builder: (context, Snapshot, child) {
                      print('hellp');
                      return MyTextField(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Snapshot.eyeButtonSwitch();
                            },
                            child: Icon(Snapshot.obsecureTextPass
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          obscureText: Snapshot.obsecureTextPass,
                          controller: Snapshot.passCONtroller,
                          text: 'Password ',
                          top: Constraints.maxHeight * 0.05,
                          right: Constraints.maxWidth * 0.032,
                          left: Constraints.maxWidth * 0.032);
                    }),
//--------------------------------------------------------------------------->//

//<------------------ Consumer wedget to rebuild  --------------------------//
                    Consumer<SignupProvider>(
                        builder: (context, Snapshot, child) {
                      return MyTextField(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Snapshot.eyeButtonSwitchConformPass();
                            },
                            child: Icon(Snapshot.obsecureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          obscureText: Snapshot.obsecureText,
                          controller: Snapshot.confirmPassControl,
                          text: 'Confirm password ',
                          top: Constraints.maxHeight * 0.05,
                          right: Constraints.maxWidth * 0.032,
                          left: Constraints.maxWidth * 0.032);
                    }),
//--------------------------------------------------------------------------->//

                    MyButton(
                      myText: 'Signup',
                      bottom: Constraints.maxHeight * 0.05,
                      top: Constraints.maxHeight * 0.045,
                      left: Constraints.maxWidth * 0.03,
                      height: Constraints.maxHeight * 0.077,
                      width: Constraints.maxWidth * 0.86,
                      ontap: () {
                        //------------------------------------------------------->Button  SignUp with Email and Password
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
                          //----------------------------------------------------->Button Google Signin
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
