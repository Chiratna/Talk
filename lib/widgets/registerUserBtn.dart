import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterUserBtn extends StatelessWidget {
  const RegisterUserBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Don\'t have an account? ',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
              )),
          TextSpan(
              text: 'SignUp',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}
