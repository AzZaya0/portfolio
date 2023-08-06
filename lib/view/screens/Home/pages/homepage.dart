import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/Home/elements/Timeline%20Tiles%20Elements/projectTimelineChild.dart';
import 'package:portfolio/view/screens/Home/elements/Timeline%20Tiles%20Elements/socialsTimelineChild.dart';
import 'package:portfolio/view/screens/Home/elements/myTimeLineTiles.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../elements/Timeline Tiles Elements/cvTimelineChild.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return SafeArea(
        child: Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Constraints.maxHeight * 0.15,
            ),
            Center(
              child: Container(
                height: Constraints.maxHeight * 0.2,
                decoration: BoxDecoration(
                    color: Color(0xff434343),
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'lib/assets/images/Mask group (1).png',
                      height: Constraints.maxHeight * 0.17,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyText(
                  text: "Flutter Developer",
                  color: Color(0xffB1B1B1),
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: MyText(
                  text: "Mr.Timsina",
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              margin: EdgeInsets.only(left: Constraints.maxWidth * 0.15),
              child: Column(
                children: [
                  MyTimeLineTiles(
                      isfirst: true,
                      islast: false,
                      endChild: CVTimelineChild()),
                  MyTimeLineTiles(
                      isfirst: false,
                      islast: false,
                      endChild: ProjectTimelineChild()),
                  MyTimeLineTiles(
                      isfirst: false,
                      islast: true,
                      endChild: SocialTimelineChild()),
                ],
              ),
            )
          ],
        )),
      );
    });
  }
}
