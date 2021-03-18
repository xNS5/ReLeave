import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';
import 'package:releave_app/pages/RedditSubmission.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    setUser();
  }

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
              child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
              MaterialButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => RedditSubmission()));},
              child: Text("Community\nCheck-In"),
              color: Colors.blue,
              splashColor: Colors.lightBlueAccent,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
              shape: CircleBorder(),
              ),
              MaterialButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CheckInMain()));},
              child: Text("Personal\nCheck-In"),
              color: Colors.green,
              splashColor: Colors.lightGreenAccent,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
              shape: CircleBorder(),
              ),
              ]
              ),
              )
          );
    }
  }

  addUser(User user) async{
    SqlitedbHelper.db.insertUser(user).then((status){
      if(status){
        print("User inserted into database");
      }
    });
  }

  setUser(){
    addUser(new User.data("Michael", "Kennedy", "11/06/1997", "2021-01-01", "ReLeave-Dev"));
  }

