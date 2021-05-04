import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk/provider/firestore_methods.dart';
import 'package:talk/screens/chatScreen.dart';
import 'package:talk/widgets/searchContainer.dart';
import 'package:talk/widgets/searchTile.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen(this.myId, this.myName);
  final myId;
  final myName;
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearching = false;
  bool haveUserSearched = false;
  QuerySnapshot searchResult;
  TextEditingController name = new TextEditingController();
  initiateSearch() async {
    if (name.text.isNotEmpty) {
      setState(() {
        isSearching = true;
      });
      await DatabaseMethods().searchByName(name.text).then((snapshot) {
        searchResult = snapshot;
        print("${searchResult.docs.length}");

        setState(() {
          isSearching = false;
          haveUserSearched = true;
        });
      });
    }
  }

  sendMessage(String rID, String name) async {
    String chatRoomID = DatabaseMethods.getChatId(widget.myId, rID);
    List<String> users = [widget.myId, rID];

    Map<String, dynamic> chatRoom = {
      'msg': '',
      'ltime': DateTime.now(),
      'users': users,
    };
    bool isExisting = await DatabaseMethods().checkChatExist(chatRoomID);
    if (!isExisting) DatabaseMethods().createChat(chatRoom, chatRoomID);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          roomId: chatRoomID,
          rID: rID,
        ),
      ),
    );
  }

  Widget userList(Size size) {
    return haveUserSearched
        ? searchResult.docs.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: searchResult.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      sendMessage(searchResult.docs[index].get('id'),
                          searchResult.docs[index].get('name'));
                    },
                    child: SearchTile(
                      name: searchResult.docs[index].get('name'),
                      email: searchResult.docs[index].get('email'),
                      size: size,
                      rID: searchResult.docs[index].get('id'),
                    ),
                  );
                })
            : Container(
                margin: EdgeInsets.only(
                  top: 32,
                ),
                child: Text(
                  'No users found',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              height: 64,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      child: TextField(
                        controller: name,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  isSearching
                      ? Container(
                          margin: EdgeInsets.only(
                            left: 8,
                            right: 32,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.cut,
                            color: Colors.black,
                          ),
                        )
                      : Container(),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                initiateSearch();
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 8,
                  right: 32,
                ),
                child: FaIcon(
                  FontAwesomeIcons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        haveUserSearched
            ? Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                  left: 16,
                  top: 8,
                  bottom: 8,
                ),
                child: Text(
                  'Search Results',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(),
        userList(s),
      ],
    );
  }
}
