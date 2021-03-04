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

  // THIS IS HOW YOU PULL FROM DB
  /*
  You must have library file included at the top (lib.dart)
  Then you can make DB queries
  Be careful that all datetimes are in the same format or there will be errors

  for more db methods, check db.dart, look here for how to insert data
  example of insertion in main.dart, user insertion. lines 12-17.

   */
  void refresh() {
    SqlitedbHelper.db.getUser().then((user) {
      if (user != null) {
        try {
          today = new DateTime.now();
          start = new DateFormat("yyyy-mm-dd").parse(user.startDate);
          difference = today
              .difference(start)
              .inDays;
          soberCount = difference.toString();
        } catch (e) {
          print("Sober Counter: Error with DateTime: " + e.toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => refresh());
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
