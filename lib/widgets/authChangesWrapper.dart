// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:talk/provider/email_sign_in.dart';
// import 'package:talk/screens/home.dart';
// import 'package:talk/screens/signIn.dart';
// import 'package:talk/screens/tryHome.dart';

// class AuthChangesWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Home(
//             u: FirebaseAuth.instance.currentUser,
//           );
//         } else {
//           return SignInScreen();
//         }
//       },
//     );
//   }
// }
