import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';
import 'package:intl/intl.dart';


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

    return CheckInLog(title: 'Check In', feelings: args.feelings, abstained: args.abstained,);
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
  _CheckInLogState({this.feelings, this.abstained});
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
      resizeToAvoidBottomInset: false,
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
                submitCheckIn(this.abstained, this.feelings, logController.text);
                _confirmToast(context);
                Navigator.pop(context);
                Navigator.pop(context);
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

  void submitCheckIn(abstained, feelings, note) {
    print(note);
    CheckInData ins_check = CheckInData.Data((new DateTime.now()).toString(), abstained);
    SqlitedbHelper.db.insertCheckin(ins_check).then((status){
      if(status){
        print("CheckIn inserted into database");
      }
    });
    Feelings ins_feels = Feelings.Data((new DateTime.now()).toString(), feelings["Happy"].toInt(), feelings["Sad"].toInt(), feelings["Anxious"].toInt(), feelings["Craving"].toInt(), feelings["Frustration"].toInt(), feelings["Angry"].toInt());
    SqlitedbHelper.db.insertFeeling(ins_feels).then((status) {
      if (status) {
        print("Feelings inserted into database");
      }
    });
    Journal ins_journal = Journal.Data(ins_check.id, (new DateTime.now()).toString(), note, 0, "");
    SqlitedbHelper.db.insertJournal(ins_journal).then((status) {
      if (status) {
        print("Journal inserted into database");
      }
    });
  }

  void _confirmToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Checked in!'),
      ),
    );
  }

}
