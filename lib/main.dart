import 'package:flutter/material.dart';
import 'package:portfolio/view/screens/loginScreen/screens/loginScreen.dart';
import 'package:portfolio/view/screens/onboardingScreen/onBoarding.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    theme: ThemeData(scaffoldBackgroundColor: Colors.black),
    debugShowCheckedModeBanner: false,
    home: OnBoarding(),
  ));
}
