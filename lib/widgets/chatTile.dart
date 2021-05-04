import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk/provider/firestore_methods.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key key,
    @required this.lstMsg,
    @required this.time,
    @required this.rID,
    this.size,
  }) : super(key: key);

  final String lstMsg;
  final String time;
  final Size size;
  final String rID;

  Future<String> getProfilePhoto(String rID) async {
    QuerySnapshot rSNap = await DatabaseMethods().getUserInfo(rID);
    String url = rSNap.docs[0].get('imgURL').toString();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseMethods().getUserInfoForName(rID),
      builder: (_, uSnap) {
        return uSnap.hasData
            ? Container(
                height: size.height * 0.11,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 8,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            uSnap.data.docs[0].get('imgURL').toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                        radius: 32,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                              ),
                              child: Text(
                                  uSnap.data.docs[0].get('name').toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Container(
                                width: double.infinity,
                                child: Text(lstMsg,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 20,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 16,
                        top: 16,
                      ),
                      child: Text(
                        '$time',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
// FutureBuilder(
//                           future: getProfilePhoto(rID),
//                           builder: (_, AsyncSnapshot<String> sn) {
//                             if (!sn.hasData) {
//                               return CircularProgressIndicator(
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.white),
//                               );
//                             }
//                             return ClipRRect(
//                               borderRadius: BorderRadius.circular(30),
//                               child: Image.network(
//                                 sn.data,
//                                 fit: BoxFit.fill,
//                               ),
//                             );
//                           },
//                         ),