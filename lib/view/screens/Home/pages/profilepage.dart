import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/view/screens/loginScreen/elements/customButton.dart';
import 'package:portfolio/view/screens/loginScreen/elements/textField.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!; //for current user
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String? fields;

  @override
  @override
  Widget build(BuildContext context) {
    // firestore database
    CollectionReference users = FirebaseFirestore.instance.collection('users');
//update
    void updatedata() async {
      Container();
      try {
        await users.doc(user.email!).update({
          'username': usernameController.text.trim(),
          'email': emailController.text.trim(),
          'gender': genderController.text.trim(),
          'number': numberController.text.trim()
        });
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    }

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(user.email!).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Container(
                      margin:
                          EdgeInsets.only(left: constraints.maxWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.15,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: constraints.maxWidth * 0.27),
                            child: Container(
                              height: constraints.maxHeight * 0.18,
                              decoration: BoxDecoration(
                                  color: Color(0xff434343),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: ("$data['photoUrl']" == '')
                                      ? Image.asset(
                                          'lib/assets/images/person.png',
                                          scale: 0.5,
                                        )
                                      : Image.network(
                                          data['photoUrl'],
                                          scale: 1,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          MyTextField(
                              onChanged: (value) {},
                              controller: usernameController,
                              text: 'Username',
                              top: constraints.maxHeight * 0.05,
                              right: constraints.maxWidth * 0.05,
                              left: 0,
                              obscureText: false),
                          MyTextField(
                              controller: emailController,
                              text: 'Email',
                              top: constraints.maxHeight * 0.05,
                              right: constraints.maxWidth * 0.05,
                              left: 0,
                              obscureText: false),
                          MyTextField(
                              controller: genderController,
                              text: 'gender',
                              top: constraints.maxHeight * 0.05,
                              right: constraints.maxWidth * 0.05,
                              left: 0,
                              obscureText: false),
                          MyTextField(
                              controller: numberController,
                              text: 'number',
                              top: constraints.maxHeight * 0.05,
                              right: constraints.maxWidth * 0.05,
                              left: 0,
                              obscureText: false),
                          MyButton(
                              ontap: () {
                                setState(() {});

                                updatedata();
                              },
                              bottom: 0,
                              height: 60,
                              left: constraints.maxWidth * 0.01,
                              myText: 'Edit Profile',
                              width: constraints.maxWidth * 0.87,
                              top: constraints.maxHeight * 0.05)
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
                child: Container(child: const CircularProgressIndicator()));
          }
        }));
  }
}
