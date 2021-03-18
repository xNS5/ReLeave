import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:releave_app/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//a page (or route in flutter terminology) containing a consumption tracker
class ConsumptionTrackerMain extends StatefulWidget {
  ConsumptionTrackerMain({Key key}) : super(key: key);
  final String title = 'Tracker';
  @override
  State<StatefulWidget> createState() {
    return ConsumptionTrackerState();
  }
}

class ConsumptionTrackerState extends State<ConsumptionTrackerMain> {
  Future<User> user;
  String method, title;
  int consumptionAmount;
  double dollars;


  @override
  void initState()
  {
    super.initState();
    user = _getUser();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user,
      builder: (context, snapshot){
        if(snapshot.data == null){
          return Scaffold(
              backgroundColor: Colors.grey,
              appBar: AppBar(
                title: Text(widget.title),
                actions: [
                  SobrietyCounter(),
                ],
              ),
              body: Dialog(
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Text("Loading"),
                  ],
                ),
              )
          );
        } else if (snapshot.hasError) {
          return new Text("Snapshot has error: ${snapshot.error}");
        } else {
          String how;
          final User u = snapshot.data ?? new User();
          final String consumptionMethod = u.consumption;
          int amount = u.amount;
          double money = u.money;
          DateTime today = new DateTime.now();
          DateTime start = new DateFormat("yyyy-mm-dd").parse(u.startDate);
          int difference = (today.difference(start).inDays) ~/ 7;
          amount *= difference;
          money *= difference;

          if(consumptionMethod.toLowerCase() == "bong"){
            how = "bong hits";
          } else if(consumptionMethod.toLowerCase() == "joint"){
            how = "joints";
          } else if(consumptionMethod.toLowerCase() == "edible"){
            how = "edibles";
          }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(border: Border.all(), color: Colors.white),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "You've refrained from consuming: $amount $how\r\n",
                      style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(border: Border.all(), color: Colors.white),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "You have saved: \$$money over $difference weeks\r\n",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ],
              ),
              ),
            );
        }
      },
    );
  }


  Future<User> _getUser() async{
      try{
        return await SqlitedbHelper.db.getUser();
      }catch(e){
        print("ConsumptionTracker: Can't get user: ${e.toString()}");
        Navigator.pop(context);
      }
      return null;
  }
}

