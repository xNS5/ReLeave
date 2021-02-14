import 'package:flutter/material.dart';
import 'main.dart';

// ignore: camel_case_types
class resourcesMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Resources(title: 'Resources'),
    );
  }
}

class Resources extends StatefulWidget {
  Resources({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ResourceState createState() => _ResourceState();

}

class _ResourceState extends State<Resources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
}
