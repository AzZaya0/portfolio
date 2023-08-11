import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, Constraints) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                        ontap: () {
                          FirebaseAuth.instance.signOut();
                          GoogleSignIn().signOut();
                        },
                        bottom: Constraints.maxHeight * 0.90,
                        height: Constraints.maxHeight * 0.05,
                        left: Constraints.maxWidth * 0.03,
                        myText: 'SignOut',
                        width: Constraints.maxWidth,
                        top: 2)
                  ],
                ),
              )),
    );
  }
}
