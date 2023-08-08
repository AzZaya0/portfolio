// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:portfolio/elements/myText.dart';

class TimelineChild extends StatelessWidget {
  final void Function()? ontap;
  final String? text;
  const TimelineChild({
    Key? key,
    required this.ontap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        return Padding(
          padding: EdgeInsets.only(
              left: Constraints.maxWidth * 0.05,
              right: Constraints.maxWidth * 0.2),
          child: GestureDetector(
            onTap: ontap,
            child: Container(
              height: Constraints.maxHeight * 0.55,
              decoration: BoxDecoration(
                  color: Color(0xff323232),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: MyText(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                text: text!,
              )),
            ),
          ),
        );
      },
    );
  }
}
