// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/loginScreen/Providers/fotgotpassProvider.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';
import 'package:portfolio/view/screens/loginScreen/elements/textField.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
//-------------------------------- Provider added --------------------------------------\\
    final forgotprovider =
        Provider.of<ForgotpassProvider>(context, listen: false);
//----------------------------------------------------------------------\\
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
//-------------------------------- Text --------------------------------------\\
            MyText(
                text: "Provide your Email",
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w600),
//-------------------------------- Text --------------------------------------\\
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
//-------------------------------- TextField for Email  -----------------------------\\

            MyTextField(
                controller: forgotprovider.EmailController,
                text: 'Enter your Email',
                top: Constraints.maxHeight * 0.14,
                right: Constraints.maxWidth * 0.04,
                left: Constraints.maxWidth * 0.034,
                obscureText: false),

//-------------------------------- Button --------------------------------------\\
            MyButton(
              myText: 'Send Link',
              ontap: () {
                //---------------------------------------------------------------> Button Email
                forgotprovider.sendlink(context);
              },
              left: Constraints.maxWidth * 0.034,
              top: Constraints.maxHeight * 0.08,
              bottom: Constraints.maxHeight * 0.03,
              height: Constraints.maxHeight * 0.077,
              width: Constraints.maxWidth * 0.85,
            ),
//-------------------------------- Back Button --------------------------------------\\

            Center(
              child: Padding(
                padding: EdgeInsets.only(top: Constraints.maxHeight * 0.08),
                child: GestureDetector(
                  onTap: () {
                    //------------------------------------------------------------->Button Back
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
//-----------------------------------------------------------------------------\\
          ],
        ),
      )));
    })));
  }
}
