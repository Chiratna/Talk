import 'package:flutter/material.dart';

class MsgHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
          left: 16,
          top: 16,
          bottom: 16,
        ),
        alignment: Alignment.topLeft,
        child: Text(
          'Messages',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
