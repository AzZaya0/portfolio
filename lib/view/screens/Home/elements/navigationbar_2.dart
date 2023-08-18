// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:portfolio/view/screens/Home/pages/addpeoplepage.dart';
import 'package:portfolio/view/screens/Home/pages/homepage.dart';
import 'package:portfolio/view/screens/Home/pages/messagepage.dart';
import 'package:portfolio/view/screens/Home/pages/settingpage.dart';

class MyNavigationBar2 extends StatefulWidget {
  const MyNavigationBar2({super.key});

  @override
  State<MyNavigationBar2> createState() => _MyNavigationBar2State();
}

class _MyNavigationBar2State extends State<MyNavigationBar2> {
  @override
  int _pageIndex = 0;
  Color homecolor = Color(0xff03B44A);
  Color addcolor = Colors.white;
  Color messagecolor = Colors.white;
  Color settingcolor = Colors.white;
  late PageController _pageController;
  List<Widget> _pages = [
    const HomePage(),
    const AddPeoplePage(),
    const MessagePage(),
    const SettingPage()
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  void changepage(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      if (index == 0) {
        homecolor = Color(0xff03B44A);
        addcolor = Colors.white;
        messagecolor = Colors.white;
        settingcolor = Colors.white;
      }
      if (index == 1) {
        addcolor = Color(0xff03B44A);
        homecolor = Colors.white;

        messagecolor = Colors.white;
        settingcolor = Colors.white;
      }
      if (index == 2) {
        messagecolor = Color(0xff03B44A);
        homecolor = Colors.white;
        addcolor = Colors.white;
        settingcolor = Colors.white;
      }
      if (index == 3) {
        settingcolor = Color(0xff03B44A);
        homecolor = Colors.white;
        addcolor = Colors.white;
        messagecolor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return Stack(children: [
        PageView(
          controller: _pageController,
          children: _pages,
          physics: NeverScrollableScrollPhysics(),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: Constraints.maxHeight * 0.02,
              bottom: Constraints.maxHeight * 0.02,
              right: Constraints.maxWidth * 0.05,
              left: Constraints.maxWidth * 0.05),
          child: Align(
            alignment: Alignment(0, 1),
            child: Container(
              height: Constraints.maxHeight * 0.08,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Constraints.maxHeight * 0.032),
                color: Color(0xff323232),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      changepage(0);
                    },
                    child: Icon(
                      Icons.home,
                      color: homecolor,
                      size: Constraints.maxHeight * 0.05,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changepage(1);
                    },
                    child: Icon(Icons.group_add_sharp,
                        color: addcolor, size: Constraints.maxHeight * 0.05),
                  ),
                  GestureDetector(
                    onTap: () {
                      changepage(2);
                    },
                    child: Icon(
                      Icons.send,
                      color: messagecolor,
                      size: Constraints.maxHeight * 0.05,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changepage(3);
                    },
                    child: Icon(Icons.settings,
                        color: settingcolor,
                        size: Constraints.maxHeight * 0.05),
                  ),
                ],
              ),
            ),
          ),
        )
      ]);
    });
  }
}
