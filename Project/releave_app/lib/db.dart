import "dart:io";
import "package:path/path.dart";
import 'package:releave_app/lib.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';



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
  // String _birthDate;
  // String _startDate;
  // String _userName;
  // Consumption _c;

  User();

  User.data(this._firstName, this._lastName);

  int get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  // String get birthDate => _birthDate;
  //
  // String get startDate => _startDate;
  //
  // String get userName => _userName;

  // Consumption get getConsumption => _c;


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
  // set birthDate(String date){
  //   if(date.length != 10){
  //     throw new FormatException("User: Unable to set birthdate");
  //   }
  //   this._birthDate = date;
  // }
  //
  // set startDate(String date){
  //   if(date.length != 10){
  //     throw new FormatException("User: Unable to set startdate");
  //   }
  //   this._startDate = date;
  // }
  //
  // set userName(String name){
  //   if(name.length <= 0){
  //     throw new FormatException("User: Unable to set username");
  //   }
  //   this._userName = name;
  // }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(_id != null) {
      map['id'] = 1;
    }
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    // map['birth-date'] = _birthDate;
    // map['start-date'] = _startDate;
    // map['username'] = _userName;
    // map['consumption-method'] = _c._consumptionMethod;
    // map['consumption-amount'] = _c._amount;
    // map['consumption-spent'] = _c._money;

    return map;
  }

  User.fromMap(Map<String, dynamic> map){
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    // this._birthDate = map['birth-date'];
    // this._startDate = map['start-date'];
    // this._userName = map['username'];
    // this._c._consumptionMethod = map['consumption-method'];
    // this._c._amount = map['consumption-amount'];
    // this._c._money = map['consumption-spent'];
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
  bool _posted;
  String _redditURL;

  Journal();

  Journal.Data(this._id, this._date, this._content, this._posted, [this._redditURL]);

  String get date => _date;

  String get content => _content;

  CheckInData get checkin => checkin;

  bool get posted => _posted;

  String get redditUrl => _redditURL;

  set entryDate(String date){
    if(date.length != 10){
      throw new FormatException("Journal: unable to set entrydate");
    }
    this._date = date;
  }

  set content(String content){
    this._content = content;
  }

  set setPosted(bool status){
    this._posted = status;
  }

  set setUrl(String url){
    this._redditURL = url;
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

  Feelings.Data(this._id, this._date, this._happy, this._sad, this._anxious, this._craving, this._frustrated, this._angry);

  String get date => _date;

  int get happy => _happy;

  int get sad => _sad;

  int get anxious => _anxious;

  int get craving => _craving;

  int get frustrated => _frustrated;

  int get angry => _angry;

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

  CheckInData.Data(this._id, this._date, this._checkin);

  String get date => _date;

  bool get checkin => _checkin;

  set date(String date){
    if(date.length != 10){
      throw new FormatException("Check-In: unable to set check-in date");
    }
    this._date = date;
  }

  set checkIn(bool status){
    this._checkin = status;
  }
}

/*
* Consumption class
* consumption method: how the user consumed cannabis
* amount: amount consumed on average (grams)
* money: average money spent on cannabis
* */
class Consumption{
  String _consumptionMethod;
  int _amount;
  double _money;

  Consumption();

  Consumption.Data(this._consumptionMethod, this._amount, this._money);

  String get consumption => _consumptionMethod;

  int get amount => _amount;

  double get money => _money;

  set consumptionMethod(String method){
    this._consumptionMethod = method;
  }

  set consumptionAmount(int amount){
    this._amount = amount;
  }

  set moneySpent(double money){
    this._money = money;
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
  int _id;
  String _title;
  /*
  * 3 types of goals:
  * 1. Duration. I want to make it to [date] without consuming
  * 2. Time. I want to not smoke [quantity] [method]
  * 3. Money. I want to save [money]
  * */
  String _goalType;
  String _consumptionMethod;
  int _goalConsumptionAmount;
  double _goalMoney;

  Goal();

  Goal.Data(this._id, this._title, this._goalType, [this._consumptionMethod, this._goalConsumptionAmount, this._goalMoney]);

  String get title => _title;

  String get goalType => _goalType;

  String get consumptionMethod => _consumptionMethod;

  int get goalAmount => _goalConsumptionAmount;

  double get goalMoney => _goalMoney;

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
}


class SqlitedbHelper {
  SqlitedbHelper._();
  static final SqlitedbHelper db = SqlitedbHelper._();
  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _createDB();
    }
    return _database;
  }

  Future<Database> _createDB() async {
    String path = join((await getDatabasesPath()), "releave.db");
    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE user('
              'id INTEGER PRIMARY KEY,'
              'firstName TEXT,'
              'lastName TEXT)');
        }
    );
  }

//Retrieve

  Future<User> getUser() async{
    final db = await database;
    var user = await db.rawQuery('SELECT * FROM user');
    if(user.length > 0){
      return new User.fromMap(user.last);
    }
    return null;
  }

//Update

  Future<User> insert(User user) async{
    final db = await database;
    user._id = await db.insert("user", user.toMap());
    return user;
  }


//Delete
}




