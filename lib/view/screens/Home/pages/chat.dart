import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserName'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: Alignment(0, 1),
        child: Container(
          height: 70,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white12),
          alignment: Alignment(0, 0),
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
