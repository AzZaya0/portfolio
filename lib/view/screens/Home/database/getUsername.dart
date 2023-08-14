import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/Home/pages/chat.dart';

class GetUsername extends StatelessWidget {
  String documentids;
  GetUsername({super.key, required this.documentids});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return
        // Firestore code starts to read data
        FutureBuilder<DocumentSnapshot>(
            future: users.doc(documentids).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return
                    //main decoration page
                    LayoutBuilder(builder: (context, Constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Constraints.maxWidth * 0.02),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                          recieverphotoUrl: data['photoUrl'],
                                          recieverEmail: data['email'],
                                          recieverUsername: data['username'],
                                        )));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff323232),
                                  borderRadius: BorderRadius.circular(12)),
                              height: Constraints.maxWidth * 0.25,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: ("${data['photoUrl']}" == '')
                                          ? Image.asset(
                                              'lib/assets/images/person.png',
                                              scale: 1.0)
                                          : Image.network('${data['photoUrl']}',
                                              scale: 1.0),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    MyText(
                                        text: data['username'],
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)
                                  ],
                                ),
                              )),
                        ),
                      )
                    ],
                  );
                });
              }
              return MyText(
                  text: 'Loading.....',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.normal);
            }));
  }
}
