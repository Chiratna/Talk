// import 'package:flutter/material.dart';

// class MsgItem extends StatelessWidget {
//   MsgItem({this.name, this.lstMsg, this.time});
//   final String name, lstMsg, time;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.all(8),
//       title: Text(
//         '$name',
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       subtitle: Text(
//         '$lstMsg',
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           color: Colors.grey[700],
//         ),
//       ),
//       leading: CircleAvatar(
//         backgroundColor: Colors.red[300],
//         radius: 32,
//       ),
//       trailing: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text('$time'),
//       ),
//     );
//   }
// }
