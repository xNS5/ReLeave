import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';

class ResourcesMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Resource(title: 'Resources'),
    );
  }
}

class Resource extends StatefulWidget {
  Resource ({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          SobrietyCounter(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
}
