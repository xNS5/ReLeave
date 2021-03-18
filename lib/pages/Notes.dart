import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:releave_app/lib.dart';


class NotesMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Note(title: 'Notes');
  }
}

class Note extends StatefulWidget {
  Note({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _NoteState createState() => _NoteState();

}

class _NoteState extends State<Note> {

  bool descending = true;
  var sortedJournals = [];

  @override
  void initState() {
    super.initState();
    pullJournal();
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
        child: notesList(),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget notesList() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: (2*sortedJournals.length) - (sortedJournals.length % 2),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;

          return noteRow(sortedJournals[index][0]);
        }
    );
  }


  Widget noteRow(j) {
    return ListTile(
      title: Text(
        j["title"] + DateFormat("    (MM-dd-yyyy)").format(DateTime.parse(j["date"])).toString(),
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        openJournal(j);
      }
    );
  }

  void openJournal(j) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => NoteViewMain(),
        settings: RouteSettings(
            arguments: j
        )
    ));
  }

  pullEntries() async{
    SqlitedbHelper.db.getJournal().then((journal) {
      if (journal != null) {
        try {
          setState(() {
            var temp_array = [];
            for (final j in journal) {
              temp_array.add([j, j["date"]]);
            }
            temp_array.sort((a, b) {
              var aDate = a[1];
              var bDate = b[1];
              if (descending) {
                return bDate.compareTo(aDate);
              }
              return aDate.compareTo(bDate);
            });
            sortedJournals = temp_array;
          });
        } catch (e) {
          print("Read DB: Error retrieving journals: " + e.toString());
        }
      }
    });
  }

  pullJournal(){
    pullEntries();
  }


}
