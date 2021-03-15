import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';

class AchievementsMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // This creates dummy achievement data for us to work with.
    // remove later once we have a real achievement generator.
    for (int i = 0; i < 10; i++) {
      AchievementData ins_ach = new AchievementData.Data("3/7/2021", "goaltype0", "achievement" + i.toString(), "Test Description, here is where the app tells the user the conditions to unlock.", 5, 0, "star_border");
      if (i == 4) {
        ins_ach.achieved = true;
      }
      if (i == 6) {
        ins_ach.iconName = "adjust";
      }
      SqlitedbHelper.db.insertAchievement(ins_ach).then((status){
        if(status){
          print("Achievement " + i.toString() + " inserted into database");
        }
      });
    }

    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Achievement(title: 'Achievements'),
    );
  }
}

class Achievement extends StatefulWidget {
  Achievement({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AchievementState createState() => _AchievementState();

}

class _AchievementState extends State<Achievement> {

  List<Map<String, dynamic>> achList = null;
  Map<String, dynamic> hlAch = null;
  String hlDesc = "none";
  IconData hlIco = Icons.star_border;

  Map<String, IconData> icoMap = {
    "star_border": Icons.star_border,
    "adjust": Icons.adjust,
  };

  @override
  void initState() {
    SqlitedbHelper.db.getAchievements().then((ach) {
      if (ach != null) {
        try {
          setState(() {
            this.achList = ach;
            this.hlAch = ach[0];
          });
        } catch (e) {
          print("Read DB: Error retrieving achievements: " + e.toString());
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
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          highlightedAchievementTile(),
          SizedBox(height: 40),
          Expanded(child: achievementGrid()),
        ],
      ),
    );
  }

  Column highlightedAchievementTile() {
    if (this.hlAch == null) {
      return Column();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          Text(
            this.hlAch["title"],
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          achievementTile(this.hlAch, this.hlIco, includeTitle: false),
          Text(
              this.hlAch["description"],
              textAlign: TextAlign.center,
          ),
      ],
    );
  }

  GridView achievementGrid() {
    return GridView.count(
      crossAxisCount: 3,
      children: achievementTileList(this.achList),
    );
  }

  Icon achievementIcon(icoData) {
    return Icon(
      icoData,
      size: 35.0,
    );
  }

  RawMaterialButton achievementButton(ach, ico) {
    if (ach["achieved"] == 0) {
      return RawMaterialButton(
        onPressed: () {
          setState(() {
            this.hlAch = ach;
            this.hlIco = ico;
          });
        },
        elevation: 2.0,
        fillColor: Colors.white,
        child: achievementIcon(ico),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      );
    }
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          this.hlAch = ach;
          this.hlIco = ico;
        });
      },
      elevation: 2.0,
      fillColor: Colors.blue,
      child: achievementIcon(ico),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );

  }

  Column achievementTile(ach, ico, {includeTitle = true}) {
    return Column(children: <Widget>[
        achievementButton(ach, ico),
        Text((() {
          if(includeTitle) {
            return ach["title"];
          }
          return "";
        })()),
    ],);
  }

  List<Widget> achievementTileList(achList) {
    if (this.achList == null) {
      return List.empty();
    }
    return List.generate(achList.length, (index) {
      return Center(
        child: achievementTile(achList[index], this.icoMap[achList[index]["iconname"]]),
      );
    });
  }
}



