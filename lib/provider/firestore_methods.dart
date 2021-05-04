import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  static getChatId(String u1, String u2) {
    if (u1.compareTo(u2) == 1) {
      return u1 + u2;
    } else {
      return u2 + u1;
    }
  }

  Stream<QuerySnapshot> getAllChats(myID) {
    var str = FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: myID)
        .snapshots();

    // print(str);

    return str;
  }

  Stream<QuerySnapshot> getUserInfoForName(uID) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: uID)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(uID) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: uID)
        .get();
  }

  Future<void> updateUserPhoto(uID, imgURL) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .update(imgURL);
  }

  Future<void> updateUserName(uID, uName) async {
    Map<String, dynamic> u = {'name': uName};
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .update(u);
  }

  searchByName(String name) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .get();
  }

  createChat(chatRoom, roomId) async {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(roomId)
        .set(chatRoom)
        .catchError((e) {
      print(e.toString());
    });
  }

  updateLastMsg(roomId, msg) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(roomId)
        .update(msg);
  }

  addMessage(roomId, msg) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .add(msg);
  }

  getMessages(roomID) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(roomID)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<bool> checkChatExist(String docID) async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance.doc("chats/$docID").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkGoogleUserExist(String uID) async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance.doc("users/$uID").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }
}
