import "dart:io";
import "package:path/path.dart";
import 'package:releave_app/lib.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:sprintf/sprintf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';



/*
* User class
* First name, last name: first and last name of the user
* birthDate: their birthday
* startDate: the date they started their journey to sobriety
* userName: reddit username
* consumption: consumption method, average expense, average quantity consumed
* */
class User {
  int _id;
  String _firstName;
  String _lastName;
  String _birthdate;
  String _startdate;
  String _username;
  String _consumptionMethod;
  int _amount;
  double _money;

  User();

  User.data(this._firstName, this._lastName, this._birthdate, this._startdate, [this._username]);

  User.consumption(this._consumptionMethod, this._amount, this._money);

  int get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get birthDate => _birthdate;

  String get startDate => _startdate;

  String get userName => _username;

  String get consumption => _consumptionMethod;

  int get amount => _amount;

  double get money => _money;

  set id(int i){
    if(i != 0){
      this._id = i;
    }
  }

  set consumptionMethod(String method){
    this._consumptionMethod = method;
  }

  set consumptionAmount(int amount){
    this._amount = amount;
  }

  set moneySpent(double money){
    this._money = money;
  }


  /*
  * Both first name and last name check for name lengths less than the known world records.
  * */
  set firstName(String name){
    if(name.length <= 0){
      this._firstName = " ";
    } else {
      this._firstName = name;
    }
  }

  set lastName(String name){
    if(name.isEmpty){
      this._lastName = " ";
    }
    else{
      this._lastName = name;
    }
  }

  /*
  * TODO: Make sure input string is some date format with separators. E.g. "12/12/2012" or to "01/01/2001"
  * */
  set birthDate(String date){
    if(date.length != 10){
      throw new FormatException("User: Unable to set birthdate");
    }
    this._birthdate = date;
  }

  set startDate(String date){
    if(date.length != 10){
      throw new FormatException("User: Unable to set startdate");
    }
    this._startdate = date;
  }

  set userName(String name){
    if(name.length <= 0){
      throw new FormatException("User: Unable to set username");
    }
    this._username = name;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['birthdate'] = _birthdate;
    map['startdate'] = _startdate;
    map['username'] = _username;
    map['consumptionMethod'] = _consumptionMethod;
    map['consumptionAmount'] = _amount;
    map['consumptionExpense'] = _money;

    return map;
  }

  User.fromMap(Map<String, dynamic> map){
    if(map != null){
      this._id = map['id'];
      this._firstName = map['firstName'];
      this._lastName = map['lastName'];
      this._birthdate = map['birthdate'];
      this._startdate = map['startdate'];
      this._username = map['username'];
      this._consumptionMethod = map['consumptionMethod'];
      this._amount = map['consumptionAmount'];
      this._money = map['consumptionExpense'];
    }
  }
}

/*
* Journal class
* date: date saved
* content: text content
* posted: posted to Reddit
* redditURL: URL of reddit post
* */
class Journal{
  int _id;
  String _date;
  String _content;
  String _title;
  int _posted;
  String _redditURL;

  Journal();

  Journal.Data(this._id, this._date, this._content, this._title, this._posted, [this._redditURL]);

  Journal.Content(this._date, this._content, this._posted, [this._redditURL]);

  int get id => _id;

  String get date => _date;

  String get content => _content;

  String get title => _title;

  CheckInData get checkin => checkin;

  bool get posted => (_posted == 1) ? true : false;

  String get redditUrl => _redditURL;

  set id(int i){
    if(i != 0){
      this._id = i;
    }
  }

  set entryDate(String date){
    if(date.length != 10){
      throw new FormatException("Journal: unable to set entry date");
    }
    this._date = date;
  }

  set content(String content){
    this._content = content;
  }

  set title(String title){
    this._title = title;
  }

  set setPosted(bool status){
    this._posted = (status == true) ? 1 : 0;
  }

  set setUrl(String url){
    this._redditURL = url;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['date'] = _date;
    map['content'] = _content;
    map['title'] = _title;
    map['posted'] = _posted;
    map['url'] = _redditURL;
    return map;
  }

  Journal.fromMap(Map<String, dynamic> map){
    if(map != null){
      this._id = map['id'];
      this._date = map['date'];
      this._content = map['content'];
      this._title = map['title'];
      this._posted = map['posted'];
      this._redditURL = map['url'];
    }
  }

}


/*
* Feelings class
* date: date saved
* happy: Happiness rating 1-10
* sad: Sadness rating 1-10
* anxious: Anxiety rating 1-10
* craving: Craving rating 1-10
* frustrated: Frustration rating 1-10
* angry: Anger rating 1-10
* */
class Feelings{
  int _id;
  String _date;
  int _happy;
  int _sad;
  int _anxious;
  int _craving;
  int _frustrated;
  int _angry;

  Feelings();

  Feelings.Data(this._date, this._happy, this._sad, this._anxious, this._craving, this._frustrated, this._angry);

  int get id => _id;

  String get date => _date;

  int get happy => _happy;

  int get sad => _sad;

  int get anxious => _anxious;

  int get craving => _craving;

  int get frustrated => _frustrated;

  int get angry => _angry;

  set id(int i){
    if(i > 0){
      this._id = i;
    }
  }

  set date(String date){
    if(date.length != 10){
      throw new FormatException("Feelings: unable to set date");
    }
    this._date = date;
  }

  set happy(int h){
    this._happy = h;
  }

  set sad(int s){
    this._sad = s;
  }

  set anxious(int a){
    this._anxious = a;
  }

  set craving(int c){
    this._craving = c;
  }

  set frustration(int f){
    this._frustrated = f;
  }

  set angry(int a) {
    this._angry = a;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['date'] = _date;
    map['happy'] = _happy;
    map['sad'] = _sad;
    map['anxious'] = _anxious;
    map['frustrated'] = _frustrated;
    map['angry'] = _angry;
    map['craving'] = _craving;

    return map;
  }

  Feelings.fromMap(Map<String, dynamic> map){
    if(map != null){
      this._date = map['date'];
      this._happy = map['happy'];
      this._sad = map['sad'];
      this._anxious = map['anxious'];
      this._frustrated = map['frustrated'];
      this._angry = map['angry'];
      this._craving = map['craving'];
    }
  }

}

/*
* Check-in class
* date: date checked in
* checkin: the status of their check-in
* */
class CheckInData{
  int _id;
  String _date;
  bool _checkin;

  CheckInData();

  CheckInData.Data(this._date, this._checkin);

  int get id => _id;

  String get date => _date;

  bool get checkin => _checkin;

  set id(int i){
    if(i > 0){
      this._id = i;
    }
  }

  set date(String date){
    if(date.length != 10){
      throw new FormatException("Check-In: unable to set check-in date");
    }
    this._date = date;
  }

  set checkIn(bool status){
    this._checkin = status;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['date'] = _date;
    map['checkin'] = (_checkin == true) ? 1 : 0;
    return map;
  }

  CheckInData.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._date = map['date'];
    this._checkin = map['checkin'];
  }
}

/*
* Goal class
* title: title of the user goal
* goalType: type of goal
* consumptionMethod: how the user consumes. Might be able to get from the consumption object/table
* goalConsumptionAmount: how much they wish to refrain from consuming
* money: how much they want to save
* */
class Goal{
  /*
  * 3 types of goals:
  * 1. Duration. I want to make it to [date] without consuming
  * 2. Quantity. I want to not smoke [quantity] [method]
  * 3. Money. I want to save [money]
  * */
  int _id;
  String _title;
  String _goalType;
  String _consumptionMethod;
  int _goalConsumptionAmount;
  double _goalMoney;

  Goal();

  Goal.Data(this._title, this._goalType, [this._consumptionMethod, this._goalConsumptionAmount, this._goalMoney]);

  int get id => _id;

  String get title => _title;

  String get goalType => _goalType;

  String get consumptionMethod => _consumptionMethod;

  int get goalAmount => _goalConsumptionAmount;

  double get goalMoney => _goalMoney;

  set id(int i){
    if(i > 0){
      this._id = i;
    }
  }

  set title(String title){
    if(title.length == 0){
      this._title = " ";
    }
    this._title = title;
  }

  set goalType(String goal){
    this._goalType = goal;
  }

  set consumptionMethod(String consume){
    this._consumptionMethod = consume;
  }

  set consumptionAmount(int amount){
    this._goalConsumptionAmount = amount;
  }

  set goalMoney(double money){
    this._goalMoney = money;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = this._title;
    map['goaltype'] = this._goalType;
    map['consumptionMethod'] = this._goalType;
    map['goalAmount'] = this._goalConsumptionAmount;
    map['goalSaved'] = this._goalMoney;
  }

  Goal.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._goalType = map['goaltype'];
    this._consumptionMethod = map['consumptionMethod'];
    this._goalConsumptionAmount = map['goalAmount'];
    this._goalMoney = map['goalSaved'];
  }
}

class AchievementData{
  int _id;
  String _date;
  String _goalType;
  String _title;
  String _description;
  int _threshold;
  int _achieved;
  String _iconName;

  AchievementData();
  AchievementData.Data(this._date, this._goalType, this._title, this._description, this._threshold, this._achieved, this._iconName);

  int get id => _id;

  String get date => _date;

  String get goalType => _goalType;

  String get title => _title;

  String get description => _description;

  int get threshold => _threshold;

  bool get achieved => (_achieved == 1) ? true : false;

  String get iconName => _iconName;

  set id(int i){
    if(i > 0){
      this._id = i;
    }
  }

  set date(String date){
    if(date != null && date.length == 10)
      this._date = date;
  }

  set goalType(String type){
    if(type != null && type.length > 0){
      this._goalType = type;
    }
  }

  set title(String title){
    if(title != null && title.length > 0){
      this._title = title;
    }
  }

  set description(String description){
    if(description != null && description.length > 0){
      this._description = description;
    }
  }

  set threshold(int threshold){
    this._threshold = threshold;
  }

  set achieved(bool status){
      this._achieved = (status == true) ? 1 : 0;
  }

  set iconName(String name){
    if(name != null && name.length > 0){
      this._iconName = name;
    }
  }


  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['id'] = this._id;
    map['date'] = this._date;
    map['goaltype'] = this._goalType;
    map['title'] = this._title;
    map['description'] = this._description;
    map['threshold'] = this._threshold;
    map['achieved'] = this._achieved;
    map['iconname'] = this._iconName;
    return map;
  }

  AchievementData.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._date = map['date'];
    this._goalType = map['goaltype'];
    this._title = map['title'];
    this._description = map['description'];
    this._threshold = map['threshold'];
    this._achieved = map['achieved'];
    this._iconName = map['iconname'];
  }

}


class SqlitedbHelper {
  SqlitedbHelper._();
  static final SqlitedbHelper db = SqlitedbHelper._();
  Database _database;

  Future<Database> get database async {
    if (_database == null) {

      _database = await _createDB();
      // _setupAchievements(_database);
      // await _database.execute("ATTACH DATABASE 'db/releave_achievements.db' AS achData");
      // await _database.execute("INSERT INTO 'releave.db'.achievement SELECT * FROM achData.achievement");
    }
    return _database;
  }


  Future<Database> _getAchDB(Database db) async {
    String achPath = join((await getDatabasesPath()), "achievement_data.db");
    var achExists = await databaseExists(achPath);
    if (!achExists) {
      // will only happen on first call
      print("Creating new copy from asset.");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(achPath)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "db/releave_achievements.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(achPath).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
    // open the database
    return await openDatabase(achPath, readOnly: true);
  }


  void _setupAchievements(Database db) async {
    String achPath = join((await getDatabasesPath()), "achievement_data.db");
    var achExists = await databaseExists(achPath);
    if (!achExists) {
      // will only happen on first call
      print("Creating new copy from asset.");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(achPath)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "db/releave_achievements.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(achPath).writeAsBytes(bytes, flush: true);
      Database achDB = await openDatabase(achPath, readOnly: true);
    }
  }

  Future<Database> _createDB() async {

    String path = join((await getDatabasesPath()), "releave.db");
    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE user('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'firstName TEXT, '
              'lastName TEXT, '
              'birthdate TEXT, '
              'startdate TEXT, '
              'username TEXT, '
              'consumptionMethod TEXT, '
              'consumptionAmount INTEGER, '
              'consumptionExpense REAL) ');
          await db.execute('CREATE TABLE journal('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'date TEXT, '
              'content TEXT, '
              'posted INTEGER, '
              'title TEXT, '
              'url TEXT)');
          await db.execute('CREATE TABLE feeling('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'date TEXT, '
              'happy INTEGER, '
              'sad INTEGER, '
              'anxious INTEGER, '
              'frustrated INTEGER, '
              'angry INTEGER, '
              'craving INTEGER)');
          await db.execute('CREATE TABLE checkin('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'date TEXT, '
              'checkin INTEGER)');
          await db.execute('CREATE TABLE goal('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title TEXT, '
              'goaltype TEXT, '
              'consumptionMethod TEXT, '
              'goalAmount INTEGER, '
              'goalSaved REAL)');
          await db.execute('CREATE TABLE achievement('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'date TEXT, '
              'goaltype TEXT, '
              'title TEXT, '
              'description TEXT, '
              'threshold INTEGER, '
              'achieved INTEGER, '
              'iconname TEXT)');
        }
    );
  }

/*
* Retrieval methods
* */
  Future<User> getUser() async{
    try {
      final db = await database;
      var user = await db.rawQuery("SELECT * FROM user WHERE id = 1");
      return new User.fromMap(user.first);
    }catch (e){
      print("Error getting user from database: "+ e.toString());
    }
    return null;
  }

  Future<List> getJournal() async{
    final db = await database;
    try{
      var entries = await db.query('journal');
      return entries.toList();
    } catch (e){
      print("Error getting journal entries: " + e.toString());
    }
    return null;
  }

  Future<List> getFeelings(String date) async{
    final db = await database;
    try{
      var f = await db.query('feeling', where: 'date = ?', whereArgs: [date] );
      return f.toList();
    }catch (e){
      print("Error getting feelings for $date:" + e.toString());
    }
    return null;
  }

  Future<CheckInData> getCheckin(String date) async{
    final db = await database;
    try{
      var c = await db.query('checkin', where: 'date = ?', whereArgs: [date]);
      if(c != null){
        return new CheckInData.fromMap(c.first);
      }
    }catch (e){
      print("Error getting check-in for $date:" + e.toString());
    }
    return null;

  }

  Future<List> getGoal() async{
    final db = await database;
    try{
      List<Goal> list = new List<Goal>();
      var goals = await db.query('goal');
      return goals.toList();
    }catch(e){
      print("Error getting goals: " + e.toString());
    }
    return null;
  }

  Future<List> getAchievements() async{
    try{
      final db = await database;
      var achievements = await db.query('achievement');
      return achievements.toList();
    } catch (e){
      print("Error getting achievements: " + e.toString());
    }
    return null;
  }

  Future<List> getAchievementsType(String type) async{
    try{
      final db = await database;
      var achievements = await db.query('achievement', where: 'goaltype = $type');
      return achievements.toList();
    } catch (e){
      print("Error getting achievements by type $type: " + e.toString());
    }
    return null;
  }

  Future<List> getUnAchieved() async{
    try{
      final db = await database;
      var achievements = await db.query('achievement', where: 'achieved = ?', whereArgs: [0]);
      return achievements.toList();
    } catch (e){
      print("Error getting un-achieved: " + e.toString());
    }
    return null;
  }

  Future<List> getUnAchievedType(String type) async{
    try{
      final db = await database;
      var achievements = await db.query('achievement', where: 'goaltype = $type AND achieved = ?', whereArgs: [0]);
      return achievements.toList();
    } catch (e){
      print("Error getting un-achieved by type $type: " + e.toString());
    }
    return null;
  }

/*
* Insert methods
* */

  Future<bool> insertUser(User user) async{
    final db = await database;
    try {
      user.id = await db.insert('user', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e){
      print("Error inserting user into database: " + e.toString());
    }
    return false;
  }

  Future<bool> insertJournal(Journal entry) async{
    final db = await database;
    try{
      entry.id = await db.insert('journal', entry.toMap());
      return true;
    } catch (e){
      print("Error inserting into journal entry into database: " + e.toString());
    }
    return false;
  }

  Future<bool> insertFeeling(Feelings feels) async{

    try{
      final db = await database;
      if(feels != null){
        feels.id = await db.insert('feeling', feels.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
        return true;
      }
    } catch (e){
      print("Error inserting feeling into database: " + e.toString());
    }
    return false;
  }

  Future<bool> insertCheckin(CheckInData check) async{
    try {
      final db = await database;
      check.id = await db.insert('checkin', check.toMap());
      return true;
    } catch (e){
      print("Error inserting check-in into database: " + e.toString());
    }
    return false;
  }

  Future<bool> insertGoal(Goal goal) async{
    try{
      final db = await database;
      goal.id = await db.insert('goal', goal.toMap());
      return true;
    }catch(e){
      print("Unable to insert goal into database: " + e.toString());
    }
    return false;
  }

  Future<bool> insertAchievement(AchievementData a) async{
    try{
      final db = await database;
      a.id = await db.insert('achievement', a.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    }catch(e){
      print("Unable to insert achievement into database: " + e.toString());
    }
    return false;
  }


  /*
  * Update methods
  * */
  Future<bool> updateUser(User user) async{
    try{
      final db = await database;
      await db.update('user', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
      print(await db.query('user'));
      return true;
    } catch (e){
      print("Error updating user: " + e.toString());
    }
    return false;
  }

  Future<bool> updateJournal(Journal entry) async{
    try{
      final db = await database;
      await db.update('journal', entry.toMap(), where: 'id = ?', whereArgs: [entry.id]);
      print(await db.query('journal'));
      return true;
    } catch (e){
      print("Error updating journal: " + e.toString());
    }
    return false;
  }

  Future<bool> updateFeeling(Feelings feels) async{
    try{
      final db = await database;
      await db.update('feeling', feels.toMap(), where: 'date = ?', whereArgs: [feels.date]);
      return true;
    } catch(e){
      print("Error updating feeling: " + e.toString());
    }
    return false;
  }

  Future<bool> updateCheckin(CheckInData check) async{
    try{
      final db = await database;
      await db.update('checkin', check.toMap(), where: 'date = ?', whereArgs: [check.date]);
      return true;
    } catch (e){
      print("Error updating check-in: " + e.toString());
    }
    return false;
  }

  Future<bool> updateGoal(Goal goal) async{
    try{
      final db = await database;
      await db.update('goal', goal.toMap(), where: 'id = ?', whereArgs: [goal.id]);
      return true;
    } catch (e){
      print("Error updating goal: " + e.toString());
    }
    return false;
  }

  Future<bool> updateAchievement(AchievementData achievement) async{
    try{
      final db = await database;
      await db.update('achievement', achievement.toMap(), where: 'id = ?', whereArgs: [achievement.id]);
      return true;
    } catch (e){
      print("Error updating goal: " + e.toString());
    }
    return false;
  }

/*
* Delete methods
* */
  Future<bool> deleteUser() async{
    final db = await database;
    try{
      await db.delete('user', where: 'id = ?', whereArgs: [1]);
      return true;
    } catch (e){
      print("Unable to delete user: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteJournalEntry(Journal entry) async{
    final db = await database;
    try{
      await db.delete('journal', where: 'id = ?', whereArgs: [entry.id]);
      return true;
    } catch (e){
      print("Unable to delete journal entry: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteFeeling(Feelings feels) async{
    final db = await database;
    try{
      await db.delete('feeling', where: 'date = ?', whereArgs: [feels.date]);
      return true;
    } catch(e){
      print("Unable to delete feeling: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteGoal(Goal goal) async{
    final db = await database;
    try{
      await db.delete('goal', where: 'id = ?', whereArgs: [goal.id]);
      return true;
    } catch(e){
      print("Unable to delete goal: " + e.toString());
    }
    return false;
  }
}




