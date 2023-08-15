// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:portfolio/elements/myText.dart';

class ProfileTiles extends StatelessWidget {
  String Field;
  String Value;
  double height;
  void Function()? onPressed;
  ProfileTiles({
    Key? key,
    required this.Field,
    required this.Value,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: MyText(
              text: Field,
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.normal),
        ),
        Container(
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xff323232)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: MyText(
                    text: Value,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onPressed,
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
