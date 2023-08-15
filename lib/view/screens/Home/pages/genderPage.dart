import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';

import '../elements/genderTile.dart';

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, Constraints) => Container(
                margin: EdgeInsets.only(
                    left: Constraints.maxWidth * 0.04,
                    right: Constraints.maxWidth * 0.04,
                    top: Constraints.maxHeight * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                        text: 'Gender',
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: Constraints.maxHeight * 0.02,
                    ),
                    MyText(
                        text: 'Select your gender.',
                        color: Color(0xff7e7e7e),
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: Constraints.maxHeight * 0.10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GenderTile(
                            ontap: () {},
                            image: 'lib/assets/images/male.png',
                            text: 'Male',
                            height: Constraints.maxHeight * 0.24,
                            width: Constraints.maxWidth * 0.42,
                            top: Constraints.maxHeight * 0.02,
                            bottom: Constraints.maxHeight * 0.04),
                        GenderTile(
                            ontap: () {},
                            image: 'lib/assets/images/female.png',
                            text: 'Female',
                            height: Constraints.maxHeight * 0.24,
                            width: Constraints.maxWidth * 0.42,
                            top: Constraints.maxHeight * 0.02,
                            bottom: Constraints.maxHeight * 0.04),
                      ],
                    ),
                    Center(
                      child: GenderTile(
                          ontap: () {},
                          image: 'lib/assets/images/others.png',
                          text: 'Others',
                          height: Constraints.maxHeight * 0.24,
                          width: Constraints.maxWidth * 0.42,
                          top: Constraints.maxHeight * 0.02,
                          bottom: Constraints.maxHeight * 0.04),
                    ),
                  ],
                ),
              )),
    );
  }
}
