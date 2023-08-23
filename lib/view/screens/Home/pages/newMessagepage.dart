import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/Home/pages/chat.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({super.key});

  @override
  State<NewMessagePage> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(child: Scaffold(body: _buildUserList()));
  }

  //
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              decoration: BoxDecoration(
                  color: Color(0xff323232),
                  borderRadius: BorderRadius.circular(12)),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          height: 80,
                          width: 80,
                          color: Color(0xff525252),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    MyText(
                        text: '------------',
                        color: Color(0xff525252),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)
                  ],
                ),
              ));
        }
        if (snapshot.hasError) {
          return Text(
            'Error',
            style: TextStyle(color: Colors.white, fontSize: 28),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return _buildUserListItem(document);
          }).toList(),
        );
      },
    );
  }

//
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_firebaseAuth.currentUser!.email != data['email']) {
      return ListTile(onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      recieverphotoUrl: data['photoUrl'],
                      recieverEmail: data['email'],
                      recieverUsername: data['username'],
                    )));
      }, title: LayoutBuilder(builder: (context, Constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(Constraints.maxWidth * 0.02),
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
                              ? Image.asset('lib/assets/images/person.png',
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
            )
          ],
        );
      }));
    }
    return Container();
  }
}
