import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';


class CheckInPassData {
  final Map feelings;
  final bool abstained;
  CheckInPassData(this.feelings, this.abstained);
}


// ignore: camel_case_types
class CheckInMain extends StatelessWidget {

  int pullUser(){
    DateTime start, today;
    int difference = 0;
    SqlitedbHelper.db.getUser().then((user){
      if(user != null){
        try{
          print("User pulled from database: " + user.toMap().toString());
          start = DateTime.parse(user.startDate);
          today = new DateTime.now();
          difference = today.difference(start).inDays;
        } catch(e){
          print("Error with DateTime: " + e.toString());
        }
      }
    });
    print(difference);
    return difference;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CheckIn(title: 'Check In');
  }
}

class CheckIn extends StatefulWidget {
  CheckIn({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  var feelings = {"Happy": 50.0, "Sad": 50.0, "Anxious": 50.0, "Craving": 50.0, "Frustration": 50.0, "Angry": 50.0, "Lonely": 50.0};
  bool abstained = false;



  Widget feelingSlider(fName, activeColor, inactiveColor,tColor, oColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Text(fName, textAlign: TextAlign.left,),
        ),
        SliderTheme(
          data: sThemeData(activeColor, inactiveColor,tColor, oColor),
          child: Slider(
            min: 0,
            max: 100,
            value: feelings[fName],
            onChanged: (value) {
              setState(() {
                feelings[fName] = value;
              });
            },
          ),
        ),
    ],);
  }

  SliderThemeData sThemeData(activeColor, inactiveColor,tColor, oColor) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: activeColor,
      inactiveTrackColor: inactiveColor,
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: tColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayColor: oColor,
      overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
    );
  }

  Widget allSliders() {
    return Expanded(child: Container(child: Column(
        children: <Widget>[
          feelingSlider("Happy", Colors.blue[700], Colors.blue[100], Colors.blueAccent, Colors.blue.withAlpha(32)),
          feelingSlider("Sad", Colors.blue[700], Colors.blue[100], Colors.blueAccent, Colors.blue.withAlpha(32)),
          feelingSlider("Anxious", Colors.blue[700], Colors.blue[100], Colors.blueAccent, Colors.blue.withAlpha(32)),
          feelingSlider("Craving", Colors.blue[700], Colors.blue[100], Colors.blueAccent, Colors.blue.withAlpha(32)),
          feelingSlider("Frustration", Colors.blue[700], Colors.blue[100], Colors.blueAccent, Colors.blue.withAlpha(32)),
          feelingSlider("Angry", Colors.blue[700], Colors.blue[100], Colors.blueAccent, Colors.blue.withAlpha(32)),
          feelingSlider("Lonely", Colors.blue[700], Colors.blue[100], Colors.blueAccent, Colors.blue.withAlpha(32)),
        ],
    )));
  }


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
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              "Did you refrain from using cannabis?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Transform.scale(
              scale: 2.0,
              child: Checkbox(
                  value: this.abstained,
                  onChanged: (bool value) {
                    setState(() {
                      this.abstained = value;
                    });
                  }
              ),
            ),
            SizedBox(height: 10),
            Text(
                "How are you feeling?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
            ),
            SizedBox(height: 10),
            allSliders(),
            FloatingActionButton(
              // When the user presses the button, show an alert dialog containing the
              // text that the user has entered into the text field.
              onPressed: () => {Navigator.push(context, MaterialPageRoute(
                builder: (context) => CheckInLogMain(),
                settings: RouteSettings(
                  arguments: CheckInPassData(feelings, abstained)
              )))},
              tooltip: 'Next step',
              child: Icon(Icons.arrow_forward),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }

}





