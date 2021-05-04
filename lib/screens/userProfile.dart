import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk/constants/constants.dart';
import 'package:talk/provider/email_sign_in.dart';
import 'package:talk/provider/firestore_methods.dart';
import 'package:talk/provider/shared_pref.dart';
import 'package:talk/widgets/updateUsername.dart';
import 'package:talk/widgets/usernameTextField.dart';

class UserProfile extends StatefulWidget {
  UserProfile({@required this.u});
  final User u;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File _image;
  bool _isFetching = true;
  bool _isImageUpdating = false;
  String imgSrc = '';
  TextEditingController usernamecontroller;
  Future<String> getProfilePhoto(String rID) async {
    QuerySnapshot rSNap = await DatabaseMethods().getUserInfo(rID);
    String url = rSNap.docs[0].get('imgURL').toString();
    return url;
  }

  pickImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> updateProfilePhoto() async {
    setState(() {
      _isImageUpdating = true;
    });
    await pickImage();
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(widget.u.uid + '.jpg');

    //await ref.delete();
    await ref.putFile(_image);
    imgSrc = await ref.getDownloadURL();
    setState(() {
      _isImageUpdating = false;
    });

    Map<String, dynamic> imgURL = {
      'imgURL': imgSrc,
    };

    await DatabaseMethods().updateUserPhoto(widget.u.uid, imgURL);
  }

  // updateUsername() {
  //   Map<String, dynamic> uName = {
  //     'name': usernamecontroller.text.trim(),
  //   };
  //   DatabaseMethods().updateUserName(widget.u.uid, uName);
  // }

  getUserNameAndPhoto() async {
    QuerySnapshot uSnap = await DatabaseMethods().getUserInfo(widget.u.uid);

    imgSrc = uSnap.docs[0].get('imgURL');
    usernamecontroller.text = uSnap.docs[0].get('name');

    setState(() {
      _isFetching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    usernamecontroller = TextEditingController();
    getUserNameAndPhoto();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isFetching
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              height: size.height,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 32,
                    ),
                    child: _isImageUpdating
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: 120,
                            height: 120,
                            child: Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black,
                                  ),
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.black,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Image.network(
                                imgSrc,
                                width: 140,
                                height: 140,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await updateProfilePhoto();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Profile Photo Updated Successfully')));
                    },
                    child: Container(
                      width: 140,
                      height: 60,
                      margin: EdgeInsets.only(
                        top: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Update',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: 24,
                    ),
                    child: Text(
                      'Username',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  UpdateUsernameTextField(
                    usernamecontroller,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await DatabaseMethods().updateUserName(
                          widget.u.uid, usernamecontroller.text.trim());
                      await deleteUserNameFromPhone();
                      Constants.myName =
                          await getUserNameFromPhone(widget.u.uid);

                      await saveUsernametoPhone(usernamecontroller.text.trim());

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Username Updated Successfully')));
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Update',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      signOut();
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          'SignOut',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
