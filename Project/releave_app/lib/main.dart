import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';
import 'package:sqflite/sqflite.dart';


User t = new User();
User q = new User();
void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User u = new User.data("Michael", "Kennedy", "11/06/1997", "02/18/2021");
    if(t.firstName == null){
      u.consumptionMethod = "Bong";
      u.moneySpent = 100.00;
      u.consumptionAmount = 10;
      SqlitedbHelper.db.insertUser(u).then((user) => t = user);
    }
    SqlitedbHelper.db.getUser().then((user) {
      if(user != null){
        q = user;
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
