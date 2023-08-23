// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderEmail;
  final String receiverEmail;
  final String message;
  final Timestamp timestamp;
  MessageModel({
    required this.senderEmail,
    required this.receiverEmail,
    required this.message,
    required this.timestamp,
  });

  // convert to map

  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
