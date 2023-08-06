import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';

class ProjectTimelineChild extends StatelessWidget {
  const ProjectTimelineChild({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        return Padding(
          padding: EdgeInsets.only(
              left: Constraints.maxWidth * 0.05,
              right: Constraints.maxWidth * 0.2),
          child: GestureDetector(
            onTap: () {},
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
                text: 'Project',
              )),
            ),
          ),
        );
      },
    );
  }
}
