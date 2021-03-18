import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:releave_app/lib.dart';

class Leaves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LeavesHome(title: '/r/Leaves'),
    );
  }
}


class LeavesHome extends StatefulWidget {
  LeavesHome({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _LeavesState createState() => _LeavesState();
}

class _LeavesState extends State<LeavesHome>{
  // ignore: non_constant_identifier_names
  static List<Post> leaves_posts = [];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState(){
    super.initState();
    fetch(10);
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          SobrietyCounter(),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: leaves_posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                height: 150,
                constraints: BoxConstraints.tightFor(height: 95.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    leaves_posts[index].title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text("u/"+
                    leaves_posts[index].author,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  fetch(int num) async{
    try {
      leaves_posts = await LeavesPosts(num);
    }catch(e){
      print(e.toString());
    }
  }

  getPosts(int num){
    fetch(num);
  }
  
}

