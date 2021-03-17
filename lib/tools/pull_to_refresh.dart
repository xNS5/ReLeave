import 'dart:io';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(refreshMain());

// ignore: camel_case_types
class refreshMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _PullToRefreshExample(),
    );
  }
}

class _PullToRefreshExample extends StatefulWidget {
  @override
  _PullToRefreshExampleState createState() => _PullToRefreshExampleState();

}

class _PullToRefreshExampleState extends State<_PullToRefreshExample> {
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    list = List.generate(3, (i) => "Item $i");
    super.initState();
    random = Random();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      list = List.generate(random.nextInt(10), (i) => "Item $i");
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pull to refresh"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: ListView.builder(
          itemCount: list?.length,
          itemBuilder: (context, i) => ListTile(
            title: Text(list[i]),
          ),
        ),
        onRefresh: refreshList,
      ),
    );
  }


}