import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sobriety Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
        home: CalMain(title: 'Sobriety Calendar'));
  }

}

class CalMain extends StatefulWidget {
  CalMain({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalMain> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}

