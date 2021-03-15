import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';
import 'package:fialogs/fialogs.dart';

class RedditSubmission extends StatelessWidget {
  TextEditingController title = new TextEditingController(),
      content = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Post'),
        actions: [
          SobrietyCounter(),
        ],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: Transform.translate(
          offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
          child:BottomAppBar(
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.cancel_outlined),
                    label: Text('Cancel')
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => {
                    [
                    successDialog(context,
                        "Posted to Reddit!",
                        "",
                      positiveButtonText: "OK",
                      positiveButtonAction: () {
                        Navigator.of(context).pop();
                      },
                      )
                    // Navigator.of(context).pop(),
                    // Navigator.of(context).pop(),
                    ]},
                  icon: Icon(Icons.send),
                  label: Text('Submit'),
                ),
              ],
            ),

          ),
      ),

        body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(border: Border.all()),
            child: TextField(
              controller: title,
              decoration: InputDecoration(hintText: 'Post Title'),
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                      hintText: 'What\'s on your mind?'),
                ),
              )
          ),
        ],
      ),
    );
  }
}



