import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyMsgTile extends StatelessWidget {
  MyMsgTile({@required this.msg, this.time});
  final String msg, time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(
            bottom: 16,
            left: 16,
            right: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '$msg\n\n',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 20,
                  )),
              TextSpan(
                  text: time,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 14,
                  ))
            ]),
          )),
    );
  }
}
