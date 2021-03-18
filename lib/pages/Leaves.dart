import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:releave_app/lib.dart';

class Leaves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Post> leaves_posts = [];
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
  // final Future<List<Post>> posts;

  @override
  _LeavesState createState() => _LeavesState();
}

class _LeavesState extends State<LeavesHome> {
  // ignore: non_constant_identifier_names
  ScrollController _scrollController = new ScrollController();
  List<Post> posts;

  @override
  void initState() {
    super.initState();
    _fetch(10);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetch(int num) async {
    try {
       await LeavesPosts(num).then((subPosts) {
        if (subPosts != null) {
          posts = subPosts;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    Navigator.pop(context); //pop dialog
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
        itemCount: posts.length,
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
                    posts[index].title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text("u/" +
                      posts[index].author,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );


    //   FutureBuilder<List<Post>>(
    //   future: widget.posts,
    //   builder: (context, snapshot){
    //     if(snapshot.connectionState == ConnectionState){
    //       final posts = snapshot.data;
    //
    //     } else {
    //       return CircularProgressIndicator();
    //     }
    //   }
    // );
  }
}