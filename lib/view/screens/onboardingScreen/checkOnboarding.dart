import 'package:flutter/material.dart';
import 'package:portfolio/view/screens/onboardingScreen/onBoarding.dart';
import 'package:portfolio/view/services/authPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOnBoarding extends StatefulWidget {
  const CheckOnBoarding({super.key});
  void savedata(bool onboardingdata) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('onboarding', onboardingdata);
  }

  void readdata(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? value = pref.getBool('onboarding');
    if (value != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoarding()));
    }
    ;
  }

  @override
  State<CheckOnBoarding> createState() => _CheckOnBoardingState();
}

class _CheckOnBoardingState extends State<CheckOnBoarding> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckOnBoarding().readdata(context);
  }

  //shared prefrances code to check the user is new or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment(0, 0),
        child: Image.asset(
          'lib/assets/images/ic_launcherCircular.png',
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
