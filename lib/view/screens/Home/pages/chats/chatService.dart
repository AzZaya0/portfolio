import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/view/screens/Home/model/messageMode.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message

  Future<void> sendMessage(String receiverEmail, String message) async {
    // current user information

    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    MessageModel newMessage = MessageModel(
      senderEmail: currentUserEmail,
      receiverEmail: receiverEmail,
      message: message,
      timestamp: timestamp,
    );

// construct chatroom id for current user and receiver id <sorted to ensure uniqueness>
    List<String> ids = [currentUserEmail, receiverEmail];
    ids.sort();
    String chatRoomId = ids.join("_");
// add new message to database

    await _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // Get message

  Stream<QuerySnapshot> getMessages(String useremail, String otherUserEmail) {
    //construct chatroom id

    List<String> ids = [useremail, otherUserEmail];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
