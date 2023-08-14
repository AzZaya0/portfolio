// ignore_for_file: public_member_api_docs, sort_constructors_first, no_logic_in_create_state
import 'package:flutter/material.dart';

import 'package:portfolio/elements/myText.dart';

class ChatPage extends StatefulWidget {
  String recieverEmail;
  String? recieverUsername;
  String? recieverphotoUrl;
  ChatPage(
      {Key? key,
      required this.recieverEmail,
      required this.recieverUsername,
      required this.recieverphotoUrl})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState(
      recieverUsername: recieverUsername, recieverphotoUrl: recieverphotoUrl);
}

class _ChatPageState extends State<ChatPage> {
  String? recieverUsername;
  String? recieverphotoUrl;
  _ChatPageState(
      {required this.recieverUsername, required this.recieverphotoUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: (recieverphotoUrl == '')
                  ? Image.asset(
                      'lib/assets/images/person.png',
                      height: 50,
                    )
                  : Image.network(
                      recieverphotoUrl!,
                      height: 50,
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(recieverUsername!)
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: const Alignment(0, 1),
        child: Container(
          height: 70,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white12),
          alignment: const Alignment(0, 0),
          child: MyText(
              text: 'text here',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
