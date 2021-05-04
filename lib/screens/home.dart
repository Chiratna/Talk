import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk/constants/constants.dart';
import 'package:talk/provider/email_sign_in.dart';
import 'package:talk/screens/messageScreen.dart';
import 'package:talk/screens/searchScreen.dart';
import 'package:talk/screens/userProfile.dart';
import 'package:talk/widgets/msgHeading.dart';
import 'package:talk/widgets/msgItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.u});
  final User u;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController _pageController;
  List<String> appBarTitle = [
    'Messages',
    'Search User',
    'Profile',
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          _selectedIndex == 0
              ? IconButton(
                  icon: Icon(
                    Icons.power_settings_new_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    signOut();
                  })
              : Container(),
        ],
        toolbarHeight: 80,
        title: Text(
          appBarTitle.elementAt(_selectedIndex),
          style: GoogleFonts.lato(
            fontSize: 26,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (i) {
          setState(() {
            _selectedIndex = i;
            _pageController.animateToPage(i,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
        items: [
          BottomNavyBarItem(
            icon: FaIcon(FontAwesomeIcons.envelopeOpenText),
            title: Text('Messages'),
            activeColor: Colors.black,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            title: Text('Search'),
            activeColor: Colors.black,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            title: Text('Profile'),
            activeColor: Colors.black,
            inactiveColor: Colors.black,
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: [
          MessageScreen(
            u: widget.u,
          ),
          SearchScreen(widget.u.uid, Constants.myName),
          UserProfile(
            u: widget.u,
          ),
        ],
      ),
    );
  }
}
