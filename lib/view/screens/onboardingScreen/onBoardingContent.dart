import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';

class OnboardingContent extends StatelessWidget {
  final String title, image, description;
  OnboardingContent({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
              text: title,
              color: Colors.white,
              fontSize: 62,
              fontWeight: FontWeight.w800),
          Spacer(),
          Center(
            child: Image.asset(
              image,
              height: Constraints.maxHeight * 0.4,
            ),
          ),
          Spacer(),
          MyText(
              text: description,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal),
          Spacer()
        ],
      ),
    );
  }
}
