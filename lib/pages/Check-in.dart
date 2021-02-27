import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:releave_app/lib.dart';

// ignore: camel_case_types
class CheckInMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckIn(title: 'Check In'),
    );
  }
}

class CheckIn extends StatefulWidget {
  CheckIn({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  double rating;
  bool abstained = false;
  final logController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    logController.dispose();
    super.dispose();
  }

  Widget rateBar() {
    return RatingBar.builder(
      initialRating: 2.5,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rate) {
        setState(() {
          rating = rate;
        });
      },
      updateOnDrag: true,
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
            // SizedBox(
            //   height: 40.0,
            // ),
            Text(
              "Did you refrain from using cannabis?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
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
            SizedBox(height: 40),
            Text(
                "How are you feeling?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
            ),
            rateBar(),
            Expanded(
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
            ),
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
                      content: Text("Normally, this would submit. For now, I will demo that it can retrieve the recorded data.\n\nabstained: " + abstained.toString() + "\n\nlog:\n" + logController.text + "\n\nrating: " + rating.toString() + "/5"),
                    );
                  },
                );
              },
              tooltip: 'Check in!',
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }



}
