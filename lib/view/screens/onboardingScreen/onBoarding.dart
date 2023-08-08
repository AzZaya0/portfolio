import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';
import 'package:portfolio/view/screens/loginScreen/screens/loginScreen.dart';
import 'package:portfolio/view/screens/onboardingScreen/onBoardingContent.dart';
import 'package:portfolio/view/services/authPage.dart';

import 'onBoardingData.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentpage = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: currentpage);
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentpage = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, Constraints) => Container(
            margin: EdgeInsets.only(
                left: Constraints.maxWidth * 0.05,
                right: Constraints.maxWidth * 0.03,
                top: Constraints.maxHeight * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: demo_data.length,
                    controller: _pageController,
                    itemBuilder: (context, index) => OnboardingContent(
                      description: demo_data[index].description,
                      image: demo_data[index].image,
                      title: demo_data[index].title,
                    ),
                  ),
                ),
                MyButton(
                    ontap: () {
                      currentpage == 2
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthPage()))
                          : _pageController.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease);
                    },
                    bottom: Constraints.maxHeight * 0.03,
                    height: Constraints.maxHeight * 0.077,
                    left: Constraints.maxWidth * 0.01,
                    myText: 'Next',
                    width: Constraints.maxWidth * 0.86,
                    top: Constraints.minHeight * 0.018)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
