import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';

class LeavesPost extends StatefulWidget {
  const LeavesPost({Key key, this.title, this.post}) : super(key: key);
  final String title;
  final Post post;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<LeavesPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text(widget.title),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                 width: MediaQuery.of(context).size.width,
                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                 decoration: BoxDecoration(border: Border.all(), color: Colors.white),
                 alignment: Alignment.topLeft,
                 child: Column(
                   children: [
                     Align(
                       alignment: Alignment.topLeft,
                       child: Text(
                         "${widget.post.title}",
                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                       ),
                     ),
                     Align(
                       alignment: Alignment.topLeft,
                       child: Text(
                         " u/${widget.post.author} ",
                         style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                       ),
                     ),
                   ],
                 ),
               ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.white,),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    " ${widget.post.selftext} ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ),
          ],
        ));
  }
}
