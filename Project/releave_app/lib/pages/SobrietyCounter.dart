import 'package:flutter/material.dart';

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
  String soberCount = "Unset";

  setCount(int newCount) {
    setState(() {
      soberCount = newCount.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
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
