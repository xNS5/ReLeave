import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';


//a page (or route in flutter terminology) containing a consumption tracker
class ConsumptionTrackerMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConsumptionTrackerState();
  }
}

class ConsumptionTrackerState extends State<ConsumptionTrackerMain> {
  double totalConsumed;
  final usedTodayFieldController = TextEditingController();

  @override
  void initState()
  {
    super.initState();
    totalConsumed = fetchTotalUse();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text('Consumption Tracker'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //if avg spending and/or target savings are not in the DB, app should prompt user to input values
            TextField(
              controller: usedTodayFieldController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Amount used today'
              ),
            ),
            TextButton(
                onPressed: () {
                  updateUsedDay();
                  return AlertDialog(
                      content: Text('Your use today has been recorded')
                  );
                },
                child: Text('Save')
            ),
            //add scrolling list of previous days' usage stats
          ],
        ),
      ),
    );
  }

  void updateUsedDay(){
    //insert double.parse(usedTodayFieldController.text) into DB
  }


  double fetchTotalUse() {
    return 0; //placeholder, fetch from DB
  }
}

