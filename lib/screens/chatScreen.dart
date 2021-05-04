import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:talk/constants/constants.dart';
import 'package:talk/provider/firestore_methods.dart';
import 'package:talk/widgets/myMsgTile.dart';
import 'package:talk/widgets/senderMsgTile.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    @required this.roomId,
    @required this.rID,
  });
  final String roomId;
  final String rID;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController = new TextEditingController();

  sendMesasage() async {
    if (msgController.text.isNotEmpty) {
      Map<String, dynamic> msg = {
        'message': msgController.text,
        'sender': Constants.myName,
        'time': DateTime.now(),
      };

      Map<String, dynamic> lstMsg = {
        'msg': msgController.text,
        'ltime': DateTime.now(),
      };

      DatabaseMethods().addMessage(widget.roomId, msg);
      DatabaseMethods().updateLastMsg(widget.roomId, lstMsg);
    }
  }

  bool isSendByMe(String name) {
    return name.compareTo(Constants.myName) == 0;
  }

  Future<String> getProfilePhoto() async {
    QuerySnapshot rSNap = await DatabaseMethods().getUserInfo(widget.rID);
    String url = rSNap.docs[0].get('imgURL').toString();
    return url;
  }

  @override
  void initState() {
    DatabaseMethods().getMessages(widget.roomId);
    super.initState();
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/image/bg.jpeg',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: kToolbarHeight * 1.5,
                color: Colors.black,
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: FutureBuilder(
                          future: getProfilePhoto(),
                          builder: (_, AsyncSnapshot<String> sn) {
                            if (!sn.hasData) {
                              return CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              );
                            }
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Image.network(
                                sn.data,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        radius: 24,
                      ),
                    ),
                    StreamBuilder(
                      stream: DatabaseMethods().getUserInfoForName(widget.rID),
                      builder: (_, uSnap) {
                        return uSnap.hasData
                            ? Container(
                                margin: EdgeInsets.only(
                                  left: 16,
                                ),
                                child: Text(
                                  '${uSnap.data.docs[0].get('name')}',
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            : Container();
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                flex: 1,
                child: StreamBuilder(
                  stream: DatabaseMethods().getMessages(widget.roomId),
                  builder: (_, msgSnapshot) {
                    return msgSnapshot.hasData
                        ? ListView.builder(
                            reverse: true,
                            itemCount: msgSnapshot.data.docs.length,
                            itemBuilder: (_, i) {
                              return isSendByMe(
                                msgSnapshot.data.docs[i]
                                    .get('sender')
                                    .toString(),
                              )
                                  ? MyMsgTile(
                                      msg: msgSnapshot.data.docs[i]
                                          .get('message')
                                          .toString(),
                                      time: DateFormat.Hm().format(
                                        DateTime.parse(
                                          msgSnapshot.data.docs[i]
                                              .get('time')
                                              .toDate()
                                              .toString(),
                                        ),
                                      ),
                                    )
                                  : SenderMsgTile(
                                      msg: msgSnapshot.data.docs[i]
                                          .get('message')
                                          .toString(),
                                      time: DateFormat.Hm().format(
                                        DateTime.parse(
                                          msgSnapshot.data.docs[i]
                                              .get('time')
                                              .toDate()
                                              .toString(),
                                        ),
                                      ),
                                    );
                            },
                          )
                        : Container();
                  },
                ),
              ),
              Container(
                height: 60,
                width: size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: TextField(
                          controller: msgController,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Type a message',
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.paperPlane),
                      onPressed: () {
                        sendMesasage();
                        setState(() {
                          msgController.text = '';
                        });
                        FocusScope.of(context).unfocus();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
