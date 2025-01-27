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
  LeavesHome({Key key, this.title, this.posts}) : super(key: key);
  final String title;
  final Future<List<Post>> posts;

  @override
  _LeavesState createState() => _LeavesState();
}

class _LeavesState extends State<LeavesHome> {
  // ignore: non_constant_identifier_names
  ScrollController _scrollController = new ScrollController();
  Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = _fetch(30);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<Post>> _fetch(int num) async {
    try {
      return await LeavesPosts(num);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: posts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: Colors.grey,
              drawer: Sidebar(),
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
          final posts = snapshot.data ?? <Post>[];
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
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          height: 150,
                          constraints: BoxConstraints.tightFor(height: 95.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(
                              posts[index].title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "u/" + posts[index].author,
                              style: TextStyle(fontSize: 17),
                            ),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute( builder: (context) => LeavesPost(key: UniqueKey(),title: widget.title, post: posts[index])));
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  ),
          //     floatingActionButton: FloatingActionButton(
          //     onPressed: (){
          //       setState(() {
          //       });
          //
          //     },
          //       child: const Icon(Icons.refresh),
          //       backgroundColor: Colors.black
          // ),
          );
        }
      },
    );
  }
}
