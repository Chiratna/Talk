import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talk/constants/constants.dart';
import 'package:talk/models/User.dart';
import 'package:talk/provider/firestore_methods.dart';
import 'package:talk/provider/shared_pref.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();
MyUser _fromFirebaseUser(User u) {
  return u != null
      ? MyUser(email: u.email, name: u.displayName, id: u.uid)
      : null;
}

Future<MyUser> signIn(String email, String pwd, BuildContext context) async {
  try {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pwd);
    QuerySnapshot usnap =
        await DatabaseMethods().getUserInfo(credential.user.uid);
    bool v = await saveUsernametoPhone(usnap.docs[0].get('name').toString());
    //await saveUserProfilePhoto(usnap.docs[0].get('imgURL').toString());
    return _fromFirebaseUser(credential.user);
  } on FirebaseAuthException catch (e) {
    String err = e.message;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(err),
      backgroundColor: Colors.red,
    ));
    return null;
  }
}

Future<MyUser> signUp(String email, String pwd, String name, File img) async {
  bool v = await saveUsernametoPhone(name);
  print('$v is result of save');
  try {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pwd);

    MyUser u = _fromFirebaseUser(credential.user);
    u.name = name;
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(credential.user.uid + '.jpg');

    await ref.putFile(img);
    String s = await ref.getDownloadURL();
    //await saveUserProfilePhoto(s);
    await FirebaseFirestore.instance.collection('users').doc(u.id).set({
      'email': u.email,
      'id': u.id,
      'name': u.name,
      'imgURL': s,
    });
    return u;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future googlelogin() async {
  final user = await googleSignIn.signIn();

  if (user != null) {
    final googleAuth = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      UserCredential uCred =
          await _firebaseAuth.signInWithCredential(credential);
      MyUser u = _fromFirebaseUser((uCred.user));
      bool checkAlreadyExists =
          await DatabaseMethods().checkGoogleUserExist(uCred.user.uid);

      if (!checkAlreadyExists) {
        await FirebaseFirestore.instance.collection('users').doc(u.id).set({
          'email': u.email,
          'id': u.id,
          'name': u.name,
          'imgURL': uCred.user.photoURL,
        });
      }
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

Future signOut() async {
  User user = _firebaseAuth.currentUser;
  Constants.myName = null;
  await deleteUserNameFromPhone();

  if (user.providerData[0].providerId == 'google.com')
    await googleSignIn.disconnect();

  await _firebaseAuth.signOut();
}
