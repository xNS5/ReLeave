import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';

class Sidebar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User user = new User();
    SqlitedbHelper.db.getUser().then((u){
      if(u != null) {
        user = u;
      }
    });
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child:Text(
                'ReLeave',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Home()))},
            ),
            ListTile(
              title: Text('Notes'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => NotesMain()))},
            ),
            ListTile(
              title: Text('Check-in (temp)'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => CheckInMain()))},
            ),
            ListTile(
              title: Text('Sobriety Counter (Temp)'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => SobrietyCounter()))},
            ),
            ListTile(
              title: Text('ConsumptionTracker (Temp)'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumptionTrackerMain()))},
            ),
            ListTile(
              title: Text('Achievements'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementsMain()))},
            ),
            ListTile(
              title: Text('Goals'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => GoalsMain()))},
            ),
            ListTile(
              title: Text('Resources'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ResourcesMain()))},
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      );
    }
  }