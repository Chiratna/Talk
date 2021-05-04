// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:talk/constants/constants.dart';
// import 'package:talk/provider/email_sign_in.dart';
// import 'package:talk/provider/firestore_methods.dart';
// import 'package:talk/provider/shared_pref.dart';
// import 'package:talk/screens/chatScreen.dart';
// import 'package:talk/screens/searchScreen.dart';
// import 'package:talk/widgets/chatTile.dart';

// class Home extends StatefulWidget {
//   Home({this.u});
//   final User u;
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool isFetching = true;
//   int _selectedIndex = 0;
//   String getRecieverName(List<dynamic> u, String myName) {
//     String rname = 'gjjbjbjb';
//     u.forEach((element) {
//       String s = element.toString();
//       if (s.compareTo(myName) != 0) {
//         rname = s;
//       }
//     });

//     return rname;
//   }

//   void getNameandPhoto() async {
//     Constants.myName = widget.u.displayName;
//     Constants.myImage = widget.u.photoURL;

//     if (Constants.myName == null || Constants.myName.isEmpty) {
//       Constants.myName = await getUserNameFromPhone(widget.u.uid);
//       print('${Constants.myName} this is saved');
//     }

//     await Future.delayed(Duration(seconds: 2));
//     setState(() {
//       isFetching = false;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     //getName();
//   }

//   @override
//   void initState() {
//     super.initState();
//     getNameandPhoto();
//     print('${Constants.myName} this is saved 2');
//     print(isFetching);
//   }

//   String getRecieverUID(List<dynamic> u, String myID) {
//     String rID = 'ugugug';
//     u.forEach((element) {
//       String s = element.toString();
//       if (s.compareTo(myID) != 0) {
//         rID = s;
//       }
//     });

//     return rID;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           elevation: 0,
//           toolbarHeight: 80,
//           title: Text(
//             'Messages',
//             style: GoogleFonts.lato(
//               fontSize: 26,
//               color: Colors.white,
//             ),
//           ),
//           actions: [
//             IconButton(
//                 icon: FaIcon(
//                   FontAwesomeIcons.search,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (_) =>
//                           SearchScreen(widget.u.uid, Constants.myName),
//                     ),
//                   );
//                 }),
//             IconButton(
//                 icon: FaIcon(
//                   FontAwesomeIcons.signOutAlt,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   signOut();
//                 }),
//           ],
//         ),
//         bottomNavigationBar: BottomNavyBar(
//           selectedIndex: _selectedIndex,
//           onItemSelected: (i) {
//             setState(() {
//               _selectedIndex = i;
//             });
//           },
//           items: [
//             BottomNavyBarItem(
//               icon: FaIcon(FontAwesomeIcons.envelopeOpenText),
//               title: Text('Messages'),
//               activeColor: Colors.black,
//               inactiveColor: Colors.black,
//             ),
//             BottomNavyBarItem(
//               icon: FaIcon(FontAwesomeIcons.search),
//               title: Text('Search'),
//               activeColor: Colors.black,
//               inactiveColor: Colors.black,
//             ),
//             BottomNavyBarItem(
//               icon: FaIcon(FontAwesomeIcons.user),
//               title: Text('Profile'),
//               activeColor: Colors.black,
//               inactiveColor: Colors.black,
//             )
//           ],
//         ),
//         body: isFetching
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Column(
//                 children: [
//                   Expanded(
//                       child: StreamBuilder(
//                     stream: DatabaseMethods().getAllChats(widget.u.uid),
//                     builder: (_, chatSnapshot) {
//                       return chatSnapshot.hasData
//                           ? ListView.builder(
//                               itemCount: chatSnapshot.data.docs.length,
//                               itemBuilder: (_, i) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     String rID = getRecieverUID(
//                                         chatSnapshot.data.docs[i].get('users'),
//                                         widget.u.uid);
//                                     String chatRoomId =
//                                         DatabaseMethods.getChatId(
//                                       widget.u.uid,
//                                       rID,
//                                     );
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (_) => ChatScreen(
//                                           roomId: chatRoomId,
//                                          // name: getRecieverName(
//                                              // chatSnapshot.data.docs[i]
//                                                  // .get('userNames'),
//                                             //  Constants.myName),
//                                           rID: getRecieverUID(
//                                               chatSnapshot.data.docs[i]
//                                                   .get('users'),
//                                               widget.u.uid),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: ChatTile(
//                                     email: chatSnapshot.data.docs[i].get('msg'),
//                                     name: getRecieverName(
//                                         chatSnapshot.data.docs[i]
//                                             .get('userNames'),
//                                         Constants.myName),
//                                     size: size,
//                                     rID: getRecieverUID(
//                                         chatSnapshot.data.docs[i].get('users'),
//                                         widget.u.uid),
//                                     time: DateFormat.Hm().format(DateTime.parse(
//                                         chatSnapshot.data.docs[i]
//                                             .get('ltime')
//                                             .toDate()
//                                             .toString())),
//                                   ),
//                                 );
//                               })
//                           : Container();
//                     },
//                   ))
//                 ],
//               )
//         // body: CustomScrollView(
//         //   slivers: [
//         //     // SliverToBoxAdapter(
//         //     //   child: Container(
//         //     //     height: size.height * 0.3,
//         //     //     decoration: BoxDecoration(
//         //     //       color: Colors.black,
//         //     //       borderRadius: BorderRadius.only(
//         //     //         bottomLeft: Radius.circular(32),
//         //     //         bottomRight: Radius.circular(32),
//         //     //       ),
//         //     //     ),
//         //     //     child: Column(
//         //     //       children: [
//         //     //         Container(
//         //     //           alignment: Alignment.topLeft,
//         //     //           margin: EdgeInsets.only(
//         //     //             top: 32,
//         //     //             left: 16,
//         //     //           ),
//         //     //           child: Text(
//         //     //             'Favourites',
//         //     //             style: GoogleFonts.lato(
//         //     //               fontSize: 24,
//         //     //               color: Colors.white,
//         //     //             ),
//         //     //           ),
//         //     //         ),
//         //     //         Expanded(
//         //     //           child: ListView.builder(
//         //     //             itemBuilder: (_, i) {
//         //     //               return Container(
//         //     //                 height: 70,
//         //     //                 // color: Colors.white,
//         //     //                 margin: EdgeInsets.symmetric(horizontal: 16),
//         //     //                 child: CircleAvatar(
//         //     //                   radius: 32,
//         //     //                   child: FlutterLogo(),
//         //     //                 ),
//         //     //               );
//         //     //             },
//         //     //             scrollDirection: Axis.horizontal,
//         //     //             physics: BouncingScrollPhysics(),
//         //     //             itemCount: 6,
//         //     //           ),
//         //     //         )
//         //     //       ],
//         //     //     ),
//         //     //   ),
//         //     // )
//         //     ChatRoom(
//         //       size: size,
//         //       uid: widget.uid,
//         //     )
//         //   ],
//         // ),
//         );
//   }
// }

// // class ChatRoom extends StatelessWidget {
// //   const ChatRoom({
// //     Key key,
// //     @required this.size,
// //     @required this.uid,
// //   }) : super(key: key);

// //   final Size size;
// //   final String uid;

// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder(
// //         stream: DatabaseMethods().getAllChats(uid),
// //         builder: (_, chatSnapshot) {
// //           return chatSnapshot.hasData
// //               ? SliverList(
// //                   delegate: SliverChildBuilderDelegate(
// //                     (_, i) {
// //                       return Container(
// //                         width: size.width,
// //                         height: 100,
// //                         margin: EdgeInsets.symmetric(
// //                           horizontal: 16,
// //                           vertical: 8,
// //                         ),
// //                         decoration: BoxDecoration(
// //                           color: Colors.grey[300],
// //                           boxShadow: [
// //                             BoxShadow(
// //                               blurRadius: 6,
// //                               color: Colors.grey[400],
// //                             )
// //                           ],
// //                           borderRadius: BorderRadius.all(Radius.circular(32)),
// //                         ),
// //                       );
// //                     },
// //                     childCount: chatSnapshot.data.docs.length,
// //                   ),
// //                 )
// //               : SliverToBoxAdapter(child: Container());
// //         });
// //   }
// // }
