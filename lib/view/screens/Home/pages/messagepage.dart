// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/view/screens/Home/database/getUsername.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<String> documentid = [];
  Future getDocid() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              documentid.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: LayoutBuilder(builder: (context, Constraints) {
        return Container(
          margin: EdgeInsets.only(bottom: Constraints.maxHeight * 0.11),
          child: FutureBuilder(
              future: getDocid(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: documentid.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Center(
                        child: GetUsername(
                          documentids: documentid[index],
                        ),
                      ));
                    });
              }),
        );
      }),
    ));
  }
}
