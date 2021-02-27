import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';

class JourneyMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journey',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Path(title: 'Journey'),
    );
  }
}

class Path extends StatefulWidget {
  Path({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PathState createState() => _PathState();

}

class _PathState extends State<Path> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
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
