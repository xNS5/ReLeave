import "dart:io" as io;
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';



class User {
  int _id;
  String _firstName;
  String _lastName;
  String _birthDate;
  String _startDate;
  String _userName;
  Consumption _c;

  User(this._id, this._firstName, this._lastName, this._birthDate, this._userName, this._c);

  User.noReddit(this._id, this._firstName, this._lastName, this._birthDate, this._c);

  int get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get birthDate => _birthDate;

  String get startDate => _startDate;

  String get userName => _userName;

  Consumption get getConsumption => _c;


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
      this._firstName = " ";
    }
    else{
      this._firstName = name;
    }
  }

  /*
  * TODO: Make sure input string is some date format with separators. E.g. "12/12/2012" or to "01/01/2001"
  * */
  set birthDate(String date){
    if(date.length != 10){
      throw new FormatException("User: Unable to set birthdate");
    }
    this._birthDate = date;
  }

  set startDate(String date){
    if(date.length != 10){
      throw new FormatException("User: Unable to set startdate");
    }
    this._startDate = date;
  }

  set userName(String name){
    if(name.length <= 0){
      throw new FormatException("User: Unable to set username");
    }
    this._userName = name;
  }
}

class Journal{
  int _id;
  String _date;
  String _content;
  bool _posted;
  String _redditURL;

  Journal(this._id, this._date, this._content, this._posted, [this._redditURL]);

  String get date => _date;

  String get content => _content;

  CheckIn get checkin => checkin;

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

class Feelings{
  int _id;
  String _date;
  int _happy;
  int _sad;
  int _anxious;
  int _craving;
  int _frustrated;
  int _angry;

  Feelings(this._id, this._date, this._happy, this._sad, this._anxious, this._craving, this._frustrated, this._angry);

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

class CheckIn{
  int _id;
  String _date;
  bool _checkin;

  CheckIn(this._id, this._date, this._checkin);

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

class Consumption{
  int _id;
  String _consumptionMethod;
  int _amount;
  double _money;

  Consumption(this._id, this._consumptionMethod, this._amount, this._money);

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


class Sqlitedb {
  static Sqlitedb _instance = new Sqlitedb();

  factory Sqlitedb() => _instance;
  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initdb();
    return _db;
  }

  initdb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "releave.db");
    return (await openDatabase(path, version: 1));
  }
}




