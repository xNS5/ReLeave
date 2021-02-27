import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';


class SidebarLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: <Widget>[
        Home(),
        Sidebar(),
      ],
    )
    );
  }
}

