import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Color(0x2596be),
          ),
        ),
        Container(
          width: 35,
          height: 110,
        ),
      ],

    );
  }
}