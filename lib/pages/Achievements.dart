import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';

class AchievementsMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Achievement(title: 'Achievements'),
    );
  }
}

class Achievement extends StatefulWidget {
  Achievement({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AchievementState createState() => _AchievementState();

}

class _AchievementState extends State<Achievement> {

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
