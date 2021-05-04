import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk/provider/firestore_methods.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    Key key,
    @required this.name,
    @required this.email,
    @required this.rID,
    this.size,
  }) : super(key: key);

  final String name;
  final String email;
  final String rID;
  final Size size;

  Future<String> getProfilePhoto(String rID) async {
    QuerySnapshot rSNap = await DatabaseMethods().getUserInfo(rID);
    String url = rSNap.docs[0].get('imgURL').toString();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.1,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 16,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: FutureBuilder(
                future: getProfilePhoto(rID),
                builder: (_, AsyncSnapshot<String> sn) {
                  if (!sn.hasData) {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    );
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      sn.data,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              radius: 32,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 32,
                    ),
                    child: Text(name,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(email,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                  ),
                ),
              ],
            ),
          ),
          // Spacer(),
          // Container(
          //   child: IconButton(
          //     icon: FaIcon(
          //       FontAwesomeIcons.arrowRight,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {

          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
