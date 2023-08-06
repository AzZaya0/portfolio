import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, Constraints) => Container(
                margin: EdgeInsets.only(
                  left: Constraints.maxWidth * 0.05,
                  right: Constraints.maxWidth * 0.03,
                  top: Constraints.maxHeight * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // top section
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              text: 'Create\n Your  Portfolio',
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w800),
                          Spacer(),
                          Center(
                            child: Image.asset(
                              'lib/assets/images/person.png',
                              height: Constraints.maxHeight * 0.4,
                            ),
                          ),
                          Spacer(),
                          MyText(
                              text:
                                  'No need to worry about \nMaking your new website',
                              color: Color(0xff7e7e7e),
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                          Spacer()
                        ],
                      ),
                    ),
                    // button section
                    Expanded(
                        flex: 1,
                        child: MyButton(
                          myText: 'Next',
                          ontap: null,
                          left: Constraints.maxWidth * 0.03,
                          top: Constraints.maxHeight * 0.018,
                          bottom: Constraints.maxHeight * 0.03,
                          height: Constraints.maxHeight * 0.077,
                          width: Constraints.maxWidth * 0.86,
                        ))
                  ],
                ),
              )),
    );
  }
}
