// ignore_for_file: non_constant_identifier_names
//import section
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/elements/myText.dart';
import 'package:portfolio/view/screens/Home/elements/profileTile.dart';
import 'package:portfolio/view/screens/Home/pages/genderPage.dart';

//----------- main clas ProfilePage-------------\\
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
//----------- Veriable and Instance Declarations.--------------------------\\
  final user = FirebaseAuth.instance.currentUser!; //for current user
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String? fields;
  final String userfield = 'Username';
  final String proffield = 'Profession';
  final String genderfield = 'Gender';
  final String numfield = 'Number';
  File? _image;

//-----------------------------------------------------------------------------\\
//---------------------------------Function Image picker from device --------------------------------------------\\
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imagetemporary = File(image.path);
    final croppedimage = await ImageCropper().cropImage(
        sourcePath: imagetemporary.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (croppedimage == null) {
      return;
    }
    setState(() {
      imageCache.clear();
      this._image = File(croppedimage!.path);
    });
  }

//-----------------------------------------------------------------------------\\
//-----------------------------------------------------------------------------\\
  @override
  @override
  Widget build(BuildContext context) {
    //------------------ Function to edit profile (Update with Alert box)-------------------\\
    String NewValue = '';
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> editprofile(
        String Field, double boxheight, double boxwidth) async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          backgroundColor: Color(0xff666666),
          title: MyText(
              text:
                  Field, //------------------------- This field is for the name of each alert box------------\\
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600),
          content: TextField(
            onChanged: (value) {
              NewValue = value;
            },
            keyboardType:
                Field == 'Number' ? TextInputType.number : TextInputType.text,
            autofocus: true,
          ),
          actions: [
//------------------------------ Cancel button of alert box starts ----------------------------------\\
            Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      height: boxheight,
                      width: boxwidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color(0xff03b44a)),
                      child: Center(
                        child: MyText(
                          text: "Cancel",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                )),

//--------------------------- Cancel button of alert box closed.-------------------------------\\

            //--------------------------- Done button Startss .-------------------------------\\

            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(NewValue),
                  child: Container(
                      height: boxheight,
                      width: boxwidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xff03b44a)),
                      child: Center(
                        child: MyText(
                          text: "Done",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                )),
          ],
        ),
      );
// ------------------------------- Code for Firestore Database  update----------------------------------------------\\
      if (NewValue.trim().length > 0) {
        //update only if there is value in textfield
        await users
            .doc(user.email!)
            .update({Field.toLowerCase(): NewValue.trim()});
        setState(() {});
      }
    }

//-------------------------------------------------------------------------------------------\\
//--------------------------------------------- Futue Builder to Fetch data (data) -------------------\\
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(user.email!).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
//--------------------------------------------------------------------------------- Scaffold startss(main body)----\\
            return Scaffold(
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//------------------------------------------------- Sized box to manage the open space above the profile image =>
                        SizedBox(
                          height: constraints.maxHeight * 0.09,
                        ),
//-------------------------------------------------------------------------------------------\\
//--------------------------------------------- Profile Image starts ----------------------------------------------\\
                        Center(
                          child: GestureDetector(
                            onTap: getImage,
                            child: Container(
                              height: constraints.maxHeight * 0.18,
                              decoration: BoxDecoration(
                                  color: const Color(0xff434343),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: _image != null
                                        ? Image.file(
                                            _image!,
                                            scale: 1,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset(
                                            'lib/assets/images/person.png',
                                            scale: 0.5,
                                          )
                                    // child: ("$data['photoUrl']" == '')
                                    //     ? Image.asset(
                                    //         'lib/assets/images/person.png',
                                    //         scale: 0.5,
                                    //       )
                                    //     : Image.network(
                                    //         data['photoUrl'],
                                    //         scale: 1,
                                    ),
                              ),
                            ),
                          ),
                        ),

//-------------------------------------------------------------------------------------------------------------\\
//----------------------------------------- Username filed starts --------------------------------------------------\\
                        Padding(
                          padding: EdgeInsets.only(
                              top: constraints.maxHeight * 0.05,
                              left: constraints.maxWidth * 0.05,
                              right: constraints.maxWidth * 0.05),
                          child: ProfileTiles(
                              onPressed: () => editprofile(
                                  userfield,
                                  constraints.maxHeight * 0.05,
                                  constraints.maxWidth * 0.3),
                              height: constraints.maxHeight * 0.08,
                              Field: userfield,
                              Value: data['username']),
                        ),
//-------------------------------------------------------------------------------------------\\
//----------------------------------------- Profession Field Starts --------------------------------------------------\\
                        Padding(
                          padding: EdgeInsets.only(
                              top: constraints.maxHeight * 0.05,
                              left: constraints.maxWidth * 0.05,
                              right: constraints.maxWidth * 0.05),
                          child: ProfileTiles(
                              onPressed: () => editprofile(
                                  proffield,
                                  constraints.maxHeight * 0.05,
                                  constraints.maxWidth * 0.3),
                              height: constraints.maxHeight * 0.08,
                              Field: proffield,
                              Value: data['profession'] ?? ''),
                        ),
//-------------------------------------------------------------------------------------------\\
//--------------------------------------------- Gender field starts ----------------------------------------------\\
                        Padding(
                          padding: EdgeInsets.only(
                              top: constraints.maxHeight * 0.05,
                              left: constraints.maxWidth * 0.05,
                              right: constraints.maxWidth * 0.05),
                          child: ProfileTiles(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Gender();
                                }));
                              },
                              height: constraints.maxHeight * 0.08,
                              Field: genderfield,
                              Value: data['gender'] ?? ''),
                        ),
//-------------------------------------------------------------------------------------------\\
//----------------------------------------- Number field starts --------------------------------------------------\\
                        Padding(
                          padding: EdgeInsets.only(
                              top: constraints.maxHeight * 0.05,
                              left: constraints.maxWidth * 0.05,
                              right: constraints.maxWidth * 0.05),
                          child: ProfileTiles(
                              onPressed: () => editprofile(
                                  numfield,
                                  constraints.maxHeight * 0.05,
                                  constraints.maxWidth * 0.3),
                              height: constraints.maxHeight * 0.08,
                              Field: numfield,
                              Value: data['number'] ?? ''),
                        ),
//-------------------------------------------------------------------------------------------\\
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
//------------------------------------------- Return what to show before fatching Data ------------------------------------------------\\
            return Center(
                child: Container(child: const CircularProgressIndicator()));
          }
        }));
  }
}
