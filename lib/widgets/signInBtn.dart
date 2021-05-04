import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInBtn extends StatelessWidget {
  const SignInBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(
        bottom: 16,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Center(
        child: Text(
          'SignIn',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
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
