// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:portfolio/elements/myText.dart';

class GenderTile extends StatelessWidget {
  String image;
  String text;
  double height;
  double width;
  double top;
  double bottom;
  void Function()? ontap;

  GenderTile({
    Key? key,
    required this.image,
    required this.text,
    required this.height,
    required this.width,
    required this.top,
    required this.bottom,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Color(0xff323232),
              borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: GestureDetector(
              onTap: ontap,
              child: Image.asset(
                image,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: top, bottom: bottom),
          child: MyText(
              text: text,
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w800),
        )
      ],
    );
  }
}
