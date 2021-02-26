import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';
import 'package:sqflite/sqflite.dart';


User t = new User();
void main() async {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User u = new User();
    u.firstName = "Michael";
    u.lastName = "Kennedy";
    SqlitedbHelper.db.insert(u).then((user) => t = user);
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'ReLeave'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage>{
  @override
  void initState(){
    super.initState();

    SqlitedbHelper.db.getUser().then((user) {
      print(user.firstName);
    });
  }

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
    );
  }
}
