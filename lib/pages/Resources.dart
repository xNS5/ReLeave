import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';

class ResourcesMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Resource(title: 'Resources'),
    );
  }
}

class Resource extends StatefulWidget {
  Resource ({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resource> {
  Future<void> _showWarning() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Warning"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('If you are having a medical emergency'),
                  Text('Dial 911 immediately')
                ],
              ),
            ),
            actions: <Widget> [
              TextButton(
                child: Text("I understand"),
                onPressed: (){
                  Navigator.of(context).pop();
                }
              )
            ],
          );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
}
