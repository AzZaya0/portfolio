// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTiles extends StatelessWidget {
  bool isfirst;
  bool islast;
  Widget endChild;
  MyTimeLineTiles({
    Key? key,
    required this.isfirst,
    required this.islast,
    required this.endChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: TimelineTile(
        isFirst: isfirst,
        isLast: islast,
        beforeLineStyle: LineStyle(color: Color(0xffff1493)),
        indicatorStyle: IndicatorStyle(
            width: 25,
            color: Color(0xff03B44A),
            iconStyle: IconStyle(iconData: Icons.circle, color: Colors.white)),
        endChild: endChild,
      ),
    );
  }
}
