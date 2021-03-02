import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = new User.data("Michael", "Kennedy", "11/06/1997", "2021-01-01", "ReLeave-Dev");
    SqlitedbHelper.db.insertUser(user).then((status){
      if(status){
        print("User inserted into database");
      }
    });
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
    );
  }
}
