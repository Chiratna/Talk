import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SenderMsgTile extends StatelessWidget {
  SenderMsgTile({
    @required this.msg,
    @required this.time,
  });
  final String msg, time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(
            bottom: 16,
            left: 8,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$msg\n\n',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: '$time',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
