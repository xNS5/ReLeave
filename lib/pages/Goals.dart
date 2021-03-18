import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';

class GoalsMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GoalHome(title: 'Goals'),
    );
  }
}

class GoalHome extends StatefulWidget {
  GoalHome({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<GoalHome> {

  final nameFieldController = TextEditingController();
  final amountFieldController = TextEditingController();
  var isSelected = [true, false, false];
  List<Map<String, dynamic>> allGoals = null;

  @override
  void initState() {
    super.initState();
    SqlitedbHelper.db.getGoal().then((theGoals) {
      if(theGoals != null) {
        try {
          setState((){
            this.allGoals = theGoals;
          });
        } catch (e) {
          print("Read DB: failed to fetch goals");
        }
      } else {
        //dummy data for testing
        print("using dummy goal data");
        theGoals = new List<Map<String, dynamic>>();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          SobrietyCounter(),
        ],
      ),


      //displaying goals:
      //fetching this from DB:
      /*
      Map<String, dynamic> toMap(){
        var map = Map<String, dynamic>();
        map['id'] = this._id;
        map['title'] = this._title;
        map['goaltype'] = this._goalType;
        map['consumptionMethod'] = this._goalType;
        map['goalAmount'] = this._goalConsumptionAmount;
        map['goalSaved'] = this._goalMoney;
      }
       */

      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Align(
                alignment: Alignment.center,
                child: Text('Create a new goal', style: TextStyle(fontSize: 30)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: TextField(
                controller: nameFieldController,
                decoration: InputDecoration(
                  //border: InputBorder.none,
                    hintText: 'Goal Name'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: amountFieldController,
                decoration: InputDecoration(
                  //border: InputBorder.none,
                    hintText: 'Amount'
                ),
              ),
            ),
            // Switch to signify whether goal is of type money or amount
            Align(
              alignment: Alignment.center,
              child: ToggleButtons(
                children: <Widget>[
                  Icon(Icons.monetization_on_outlined),
                  Icon(Icons.smoke_free),
                  Icon(Icons.date_range),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () {
                    insertNewGoal();
                    return AlertDialog(
                        content: Text('New goal saved!')
                    );
                  },
                  child: Text('Save', style: TextStyle(fontSize: 25))
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
              child: Text('Current Goals', style: TextStyle(fontSize: 30)),
            ),
            //scrolling list of goals (partially implemented)
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: allGoals == null ? 0 : allGoals.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  //color: ,
                  child: Column(
                      children: [
                        Text(allGoals[index]['title']),
                        //the other fields of the goals
                        //progress bar
                      ]
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }


  void insertNewGoal() async {
    Goal toInsert = new Goal();
    String goalType;
    if(isSelected[0]) {
       goalType = 'money';
       toInsert = new Goal.Data(nameFieldController.text, goalType, goalType, new DateTime.now().toString(), 0, double.parse(amountFieldController.text));
     } else if(isSelected[1]) {
      goalType = 'amount';
      toInsert = new Goal.Data(nameFieldController.text, goalType, goalType, new DateTime.now().toString(), int.parse(amountFieldController.text), 0.0);
    } else if(isSelected[2]) {
      goalType = 'duration';
      DateTime due = new DateTime.now().add(Duration(days: int.parse(amountFieldController.text)));
      toInsert = new Goal.Data(nameFieldController.text, goalType, goalType, due.toString() , 0, 0.0);
    }

    await SqlitedbHelper.db.insertGoal(toInsert).then((status) {
      if(status){
        nameFieldController.clear();
        amountFieldController.clear();
        print("Goal inserted!");
      } else {
        print("Failed to insert goal");
      }
    });
  }
}
