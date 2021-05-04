import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSignInBtn extends StatelessWidget {
  const GoogleSignInBtn({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text('SignIn with',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          FaIcon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
          Spacer(),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 6,
              spreadRadius: 6,
            )
          ]),
    );
  }
}
