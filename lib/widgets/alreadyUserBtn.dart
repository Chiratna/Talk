import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlreadyUserBtn extends StatelessWidget {
  const AlreadyUserBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 32),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Already have an account? ',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 16,
                )),
            TextSpan(
                text: 'SignIn',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))
          ]),
        ));
  }
}
