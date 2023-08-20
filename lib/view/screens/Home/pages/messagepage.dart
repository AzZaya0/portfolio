// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/view/screens/Home/database/getUsername.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

//--------------------Database------------------------\\
class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin<MessagePage> {
  bool get wantKeepAlive => false;
  final user = FirebaseAuth.instance.currentUser!;
  List<String> documentid = [];
  Future getDocid() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isNotEqualTo: user!.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              documentid.add(element.reference.id);
            }));
  }

//----------------The above code is to get The document id of every user from database----\\
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
