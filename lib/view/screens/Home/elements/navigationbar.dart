// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:portfolio/view/screens/Home/pages/addpeoplepage.dart';
import 'package:portfolio/view/screens/Home/pages/homepage.dart';
import 'package:portfolio/view/screens/Home/pages/messagepage.dart';
import 'package:portfolio/view/screens/Home/pages/settingpage.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  int _pageIndex = 0;
  List<Widget> _pages = [
    HomePage(),
    AddPeoplePage(),
    MessagePage(),
    SettingPage()
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return Stack(children: [
        _pages.elementAt(_pageIndex),
        Padding(
          padding: EdgeInsets.only(
              top: Constraints.maxHeight * 0.02,
              right: Constraints.maxWidth * 0.05,
              left: Constraints.maxWidth * 0.05),
          child: Align(
              alignment: Alignment(0, 1),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(Constraints.maxHeight * 0.032)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xff323232),
                  currentIndex: _pageIndex,
                  selectedItemColor: Color(0xff03B44A),
                  unselectedItemColor: Colors.white,
                  onTap: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          size: Constraints.maxHeight * 0.04,
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.group_add_sharp,
                          size: Constraints.maxHeight * 0.04,
                        ),
                        label: 'Peoples'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.send,
                          size: Constraints.maxHeight * 0.04,
                        ),
                        label: 'Message'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.settings,
                          size: Constraints.maxHeight * 0.04,
                        ),
                        label: 'settings')
                  ],
                ),
              )),
        )
      ]);
    });
  }
}
