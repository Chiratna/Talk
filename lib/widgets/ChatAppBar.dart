import 'package:flutter/material.dart';

class ChatAppBar extends PreferredSize {
  final Widget child;
  final double height;

  ChatAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.black,
      alignment: Alignment.center,
      child: child,
    );
  }
}
