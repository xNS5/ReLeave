import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:releave_app/lib.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class BarChartModel {
  String emotion;
  int val;
  final charts.Color color;

  BarChartModel({
    this.emotion,
    this.val,
    this.color,
  });
}



class NoteViewMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final j = ModalRoute.of(context).settings.arguments;
    return NoteView(title: 'Notes', journal: j);
  }
}

class NoteView extends StatefulWidget {
  NoteView({Key key, this.title, this.journal}) : super(key: key);
  final String title;
  final Map<String, dynamic> journal;
  @override
  _NoteViewState createState() => _NoteViewState();

}

class _NoteViewState extends State<NoteView> {

  var feelings;
  List<BarChartModel> graphData = [];

  @override
  void initState() {
    super.initState();
    SqlitedbHelper.db.getFeelings(widget.journal["date"]).then((f) {
      if (f != null) {
        try {
          setState(() {
            if (f.length > 0) {
              this.feelings = f[0];
              for (List e in [["happy", Colors.orangeAccent], ["sad", Colors.blueAccent], ["anxious", Colors.pinkAccent], ["frustrated", Colors.deepOrangeAccent], ["angry", Colors.red], ["craving", Colors.lightGreen], ["lonely", Colors.blueGrey]]) {
                graphData.add(
                  BarChartModel(
                    emotion: e[0],
                    val: this.feelings[e[0]],
                    color: charts.ColorUtil.fromDartColor(e[1]),
                  )
                );
              }
            }

          });
        } catch (e) {
          print("Read DB: Error retrieving journals: " + e.toString());
        }
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
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Container(height: 50, child: Row(
              children: <Widget>[
                Expanded(
                  flex:6,
                  child: Text(
                    widget.journal["title"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                Expanded(
                  flex:4,
                  child: Text(
                    DateFormat("(MM-dd-yyyy)").format(DateTime.parse(widget.journal["date"])).toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),),
            SizedBox(height:10),
            abstainedMessage(),
            SizedBox(height: 20),
            feelingGraph(),
            SizedBox(height: 20),
            journalText(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }


  Widget journalText() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.journal["content"],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
        ),),
      ),
    );
  }

  Widget abstainedMessage() {
    if (feelings == null || feelings.length == 0) {
      return Text("");
    }
    else {
      return Text(
        "Abstained from using: " + feelings['abstained'].toString(),
        style: TextStyle(
          fontSize: 16,
        ),
      );
    }
  }

  Widget feelingGraph() {
    if (feelings == null || feelings.length == 0) {
      return Text("Loading feelings graph...");
    }
    else {
      List<charts.Series<BarChartModel, String>> series = [
        charts.Series(
            id: "Feelings",
            data: this.graphData,
            domainFn: (BarChartModel series, _) => series.emotion,
            measureFn: (BarChartModel series, _) => series.val,
            colorFn: (BarChartModel series, _) => series.color),
      ];
      return FractionallySizedBox(
        alignment: Alignment.topCenter,
          widthFactor: 0.95,
          child: Container(
              height: 300,
              child: charts.BarChart(
                series,
                animate: false,
                primaryMeasureAxis: new charts.NumericAxisSpec(
                  tickProviderSpec:
                    new charts.StaticNumericTickProviderSpec(<charts.TickSpec<int>>[
                      new charts.TickSpec(0),
                      new charts.TickSpec(20),
                      new charts.TickSpec(40),
                      new charts.TickSpec(60),
                      new charts.TickSpec(80),
                      new charts.TickSpec(100),
                    ])
                ),
      )));
    }
  }

}
