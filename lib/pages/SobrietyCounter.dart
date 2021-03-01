import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:releave_app/lib.dart';

/*
USAGE:
This should be imported:
  import 'SobrietyCounter.dart';


Then called in the AppBar:
  appBar: AppBar(
    title: Text(widget.title),
    actions: [
      SobrietyCounter(),
    ],
  ),

Currently it has nothing to set its value, but later
It will be connected to the DB and look up the number,
then set this value with setCount in the _SobrietyCounterState.
 */

class SobrietyCounter extends StatefulWidget {
  SobrietyCounter({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SobrietyCounterState createState() => _SobrietyCounterState();
}


class _SobrietyCounterState extends State<SobrietyCounter> {
  Timer timer;
  String soberCount = "";
  DateTime start, today;
  int difference = 0;

  void refresh() {
    SqlitedbHelper.db.getUser().then((user) {
      if (user.firstName != null) {
        try {
          today = new DateTime.now();
          start = new DateFormat("yyyy-mm-dd").parse(user.startDate);
          difference = today
              .difference(start)
              .inDays;
        } catch (e) {
          print("Sober Counter: Error with DateTime: " + e.toString());
        }
      }
        setState(() {
          soberCount = difference.toString();
        });
    });
  }
  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => refresh());
    // This is an example. The "setCount()" function will be called when it reads
    // from the database to appropriately set the number of sober days.
    // setCount(1);
    return Align(child: Padding(padding: EdgeInsets.only(right: 15), child: Text(
      "Days Sober: $soberCount",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
      ),
    )));
  }
}
