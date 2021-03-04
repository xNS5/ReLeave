import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:releave_app/lib.dart';


// ignore: camel_case_types
class CheckInLogMain extends StatelessWidget {

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

    final CheckInPassData args = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckInLog(title: 'Check In', feelings: args.feelings, abstained: args.abstained,),
    );
  }
}

class CheckInLog extends StatefulWidget {
  CheckInLog({Key key, this.title, this.feelings, this.abstained}) : super(key: key);
  final String title;
  final Map feelings;
  final bool abstained;
  @override
  _CheckInLogState createState() => _CheckInLogState(feelings: this.feelings, abstained: this.abstained);
}

class _CheckInLogState extends State<CheckInLog> {
  @override
  _CheckInLogState({Key key, this.feelings, this.abstained});
  final Map feelings;
  final bool abstained;
  final logController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    logController.dispose();
    super.dispose();
  }

  Widget noteField() {
    return Expanded(
      child: TextField(
        controller: logController,
        minLines: null,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Record some thoughts',
        ),
      ),
    );
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
              "Record some thoughts (Optional)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            noteField(),
            SizedBox(height: 20),
            FloatingActionButton(
              // When the user presses the button, show an alert dialog containing the
              // text that the user has entered into the text field.
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the user has entered by using the
                      // TextEditingController.
                      content: Text("Normally, this would submit. For now, I will demo that it can retrieve the recorded data.\n\nAbstained: " + this.abstained.toString() + "\n\nFeelings:\n" + this.feelings.toString()),
                    );
                  },
                );
              },
              tooltip: 'Check in!',
              child: Icon(Icons.arrow_forward),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }



}
