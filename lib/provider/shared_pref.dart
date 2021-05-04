import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk/constants/constants.dart';
import 'package:talk/provider/firestore_methods.dart';

saveUsernametoPhone(String name) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.setString(NAME_KEY, name);
}

saveUserProfilePhoto(String imgURL) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.setString(IMG_KEY, imgURL);
}

Future<bool> deleteUserNameFromPhone() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove(NAME_KEY);
}

Future<bool> deleteUserPhotoFromPhone() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove(IMG_KEY);
}

Future<String> getUserNameFromPhone(uID) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.containsKey(NAME_KEY)) {
    return pref.getString(NAME_KEY);
  } else {
    QuerySnapshot usnap = await DatabaseMethods().getUserInfo(uID);
    bool v = await saveUsernametoPhone(usnap.docs[0].get('name').toString());

    if (v) {
      return pref.getString(NAME_KEY);
    } else {
      return '';
    }
  }
}

Future<String> getUserPhotoFromPhone(uID) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.containsKey(IMG_KEY)) {
    return pref.getString(IMG_KEY);
  } else {
    QuerySnapshot usnap = await DatabaseMethods().getUserInfo(uID);
    bool v = await saveUserProfilePhoto(usnap.docs[0].get('imgURL').toString());

    if (v) {
      return pref.getString(IMG_KEY);
    } else {
      return '';
    }
  }
}
