import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';

class AddPeoplePage extends StatefulWidget {
  const AddPeoplePage({super.key});

  @override
  State<AddPeoplePage> createState() => _AddPeoplePageState();
}

class _AddPeoplePageState extends State<AddPeoplePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(user.email!).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: ("${data['photoUrl']}" == '')
                        ? Image.asset('lib/assets/images/person.png',
                            scale: 1.0)
                        : Image.network('${data['photoUrl']}', scale: 1.0),
                  ),
                  MyText(
                      text: '${data['username']}',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal)
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        }));
  }
}
