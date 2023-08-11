// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/Home/elements/Timeline%20Tiles%20Elements/myTimeLineTiles.dart';

import '../elements/Timeline Tiles Elements/TimelineChild.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

@override
class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> documentEmail = [];
  Future getDocEmail() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapchot) => snapchot.docs.forEach((element) {
              print(element.reference);
              documentEmail.add(element.reference.id);
            }));
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getDocEmail();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return SafeArea(
        child: Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Constraints.maxHeight * 0.1,
            ),
            Center(
              child: Container(
                height: Constraints.maxHeight * 0.18,
                decoration: BoxDecoration(
                    color: Color(0xff434343),
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: (user.photoURL == null)
                        ? Image.asset(
                            'lib/assets/images/person.png',
                            scale: 0.5,
                          )
                        : Image.network(
                            user.photoURL!,
                            scale: 0.5,
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
                  text: (user.displayName == null)
                      ? user.email!.split('@')[0]
                      : user!.displayName!.trim(),
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              margin: EdgeInsets.only(left: Constraints.maxWidth * 0.15),
              child: Column(
                children: [
                  // on the OnTap function of the Timeline Tiles just add navigation.push and navigate
                  MyTimeLineTiles(
                      isfirst: true,
                      islast: false,
                      endChild: TimelineChild(
                        text: 'CV / Resume',
                        ontap: () {},
                      )),
                  MyTimeLineTiles(
                      isfirst: false,
                      islast: false,
                      endChild: TimelineChild(
                        ontap: () {},
                        text: 'Project',
                      )),
                  MyTimeLineTiles(
                      isfirst: false,
                      islast: true,
                      endChild: TimelineChild(
                        ontap: () {},
                        text: 'Socials',
                      )),
                ],
              ),
            ),
          ],
        )),
      );
    });
  }
}
