import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:talk/constants/constants.dart';
import 'package:talk/provider/email_sign_in.dart';
import 'package:talk/provider/firestore_methods.dart';
import 'package:talk/provider/shared_pref.dart';
import 'package:talk/screens/chatScreen.dart';
import 'package:talk/screens/searchScreen.dart';
import 'package:talk/widgets/chatTile.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({this.u});
  final User u;
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool isFetching = true;

  String getRecieverName(List<dynamic> u, String myName) {
    String rname = 'gjjbjbjb';
    u.forEach((element) {
      String s = element.toString();
      if (s.compareTo(myName) != 0) {
        rname = s;
      }
    });

    return rname;
  }

  void getName() async {
    // if ((widget.u.displayName == null || widget.u.displayName.isEmpty) &&
    //     (Constants.myName == null || Constants.myName.isEmpty)) {
    //   Constants.myName = await getUserNameFromPhone(widget.u.uid);
    //   print('${Constants.myName} this is saved');
    // }
    // if (Constants.myName == null || Constants.myName.isEmpty) {
    //   Constants.myName = widget.u.displayName;
    // }
    if (Constants.myName == null || Constants.myName.isEmpty) {
      Constants.myName = await getUserNameFromPhone(widget.u.uid);
      print(Constants.myName);
    }

    setState(() {
      isFetching = false;
    });
  }

  void getNameandPhoto() async {
    Constants.myName = widget.u.displayName;
    Constants.myImage = widget.u.photoURL;

    if (Constants.myName == null || Constants.myName.isEmpty) {
      Constants.myName = await getUserNameFromPhone(widget.u.uid);
      print('${Constants.myName} this is saved');
    }

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isFetching = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //getName();
  }

  @override
  void initState() {
    super.initState();
    getName();
    print('${Constants.myName} this is saved 2');
    print(isFetching);
  }

  String getRecieverUID(List<dynamic> u, String myID) {
    String rID = 'ugugug';
    u.forEach((element) {
      String s = element.toString();
      if (s.compareTo(myID) != 0) {
        rID = s;
      }
    });

    return rID;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isFetching
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          )
        : Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: DatabaseMethods().getAllChats(widget.u.uid),
                builder: (_, chatSnapshot) {
                  return chatSnapshot.hasData
                      ? chatSnapshot.data.docs.length > 0
                          ? ListView.builder(
                              itemCount: chatSnapshot.data.docs.length,
                              itemBuilder: (_, i) {
                                return GestureDetector(
                                  onTap: () {
                                    String rID = getRecieverUID(
                                        chatSnapshot.data.docs[i].get('users'),
                                        widget.u.uid);
                                    String chatRoomId =
                                        DatabaseMethods.getChatId(
                                      widget.u.uid,
                                      rID,
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                          roomId: chatRoomId,
                                          rID: getRecieverUID(
                                              chatSnapshot.data.docs[i]
                                                  .get('users'),
                                              widget.u.uid),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ChatTile(
                                    lstMsg:
                                        chatSnapshot.data.docs[i].get('msg'),
                                    size: size,
                                    rID: getRecieverUID(
                                        chatSnapshot.data.docs[i].get('users'),
                                        widget.u.uid),
                                    time: DateFormat.Hm().format(DateTime.parse(
                                        chatSnapshot.data.docs[i]
                                            .get('ltime')
                                            .toDate()
                                            .toString())),
                                  ),
                                );
                              })
                          : Center(
                              child: Container(
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.sadTear,
                                      color: Colors.black54,
                                      size: 70,
                                    ),
                                    Text(
                                      'Everyone misses you',
                                      style: GoogleFonts.lato(
                                        color: Colors.black54,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            )
                      : Center(
                          child: Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            ),
                          ),
                        );
                },
              ))
            ],
          );
  }
}
