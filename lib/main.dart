import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talk/constants/constants.dart';
import 'package:talk/provider/email_sign_in.dart';
import 'package:talk/provider/shared_pref.dart';
import 'package:talk/screens/home.dart';
import 'package:talk/screens/signIn.dart';
import 'package:talk/screens/tryHome.dart';
import 'package:talk/widgets/authChangesWrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return HomeScreen(
                u: FirebaseAuth.instance.currentUser,
              );
            }
            return SignInScreen();
          },
        ));
  }
}
