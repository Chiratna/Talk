import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchContainer extends StatelessWidget {
  SearchContainer({this.name});
  final TextEditingController name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(32)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 16,
              right: 8,
            ),
            child: FaIcon(
              FontAwesomeIcons.search,
              color: Colors.black,
            ),
          ),
          Expanded(
            // margin: EdgeInsets.symmetric(horizontal: 8),
            // width: size.width,
            child: TextField(
              controller: name,
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 24,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Search',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
