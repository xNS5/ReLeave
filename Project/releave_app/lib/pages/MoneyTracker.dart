import 'package:flutter/material.dart';

//a page (or route in flutter terminology) containing a money tracker
class MoneyTrackerMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoneyTrackerState();
  }
}

class MoneyTrackerState extends State<MoneyTrackerMain> {
  double savedMoney = 0;
  double target = 50; //example
  double progress = 0;

  @override
  void initState()
  {
    super.initState();
    savedMoney = fetchSavedMoney();
    target = fetchTarget();
    progress = savedMoney/target;
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Tracker'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //text showing money saved
            Text("Saved $savedMoney so far!"),
            //progress bar visualizing the savings (out of a user-defined value, like x / y)
            LinearProgressIndicator(
              backgroundColor: Color(0xffeceff4),
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff2e3440)),
              value: progress,
            ),

            //if avg spending and/or target savings are not in the DB, app should prompt user to input values
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Savings Goal'
              ),
            ),
            TextButton(
              onPressed: () {
                updateSaveTarget();
                return AlertDialog(
                  content: Text('Your savings goal has been recorded!')
                );
              },
              child: Text('Save')
            ),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Average Daily Spending'
              ),
            ),
            TextButton(
              onPressed: () {
                updateSaveRate();
                return AlertDialog(
                    content: Text('Your average daily spending has been recorded!')
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void updateSaveRate(){
    //insert double.parse(avgSavingsFieldController.text) into DB
  }

  void updateSaveTarget(){
    //insert double.parse(targetFieldController.text) into DB
  }


  double fetchSavedMoney() {
    double avgSpent = 0; //placeholder, fetch from DB
    double daysSober = 0; //placeholder, fetch from DB
    return avgSpent * daysSober;
  }

  double fetchTarget() {
    double fetched = 50; // placeholder, access DB to get this value
    return fetched;
  }
}

