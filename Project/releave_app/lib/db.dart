import "dart:io" as io;
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class User {
  final int id;
  final String firstName;
  final String lastName;
  final String birthDate;
  String startDate;
  final String userName;
  final Consumption c;

  User(this.id, this.firstName, this.lastName, this.birthDate, this.userName, this.c);
}

class Journal{
  final int id;
  final String date;
  final JournalContent content;
  final Feelings feelings;
  final CheckIn status;
  final bool toReddit;
  final String redditURL;

  Journal(this.id, this.date, this.content, this.feelings, this.status, this.toReddit, this.redditURL);
}

class Feelings{
  final int id;
  final int happy;
  final int sad;
  final int anxious;
  final int craving;
  final int frustrated;
  final int angry;

  Feelings(this.id, this.happy, this.sad, this.anxious, this.craving, this.frustrated, this.angry);
}

class CheckIn{
  final int id;
  final String date;
  final bool checkin;

  CheckIn(this.id, this.date, this.checkin);
}

class JournalContent{
  final int id;
  final String currentDate;
  final String textContent;

  JournalContent(this.id, this.currentDate, this.textContent);
}

class Consumption{
  final String consumptionMethod;
  final int amount;
  final double money;

  Consumption(this.consumptionMethod, this.amount, this.money);
}



class Sqlitedb {
  static final Sqlitedb _instance = new Sqlitedb();

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




