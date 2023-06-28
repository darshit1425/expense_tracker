import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  Database? database;

  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await createDB();
    }
  }

  Future<Database> createDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "abc.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE incoexp(id INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT,amount TEXT,notes TEXT,paytypes TEXT,status INTEGER,date TEXT,time TEXT)";

        String uary1 =
            "CREATE TABLE cate (id INTEGER PRIMARY KEY AUTOINCREMENT , cate TEXT)";
        db.execute(query);
        db.execute(uary1);
      },
    );
  }

  void insertData({
    required category,
    required amount,
    required notes,
    required paytypes,
    required status,
    required date,
    required time,
  }) async {
    database = await checkDB();
    database!.insert("incoexp", {
      "category": category,
      "amount": amount,
      "notes": notes,
      "paytypes": paytypes,
      "status": status,
      "date": date,
      "time": time,
    });
  }

  Future<List<Map>> ReadData() async {
    database = await checkDB();

    String query = "SELECT * FROM incoexp";
    List<Map> list = await database!.rawQuery(query);
    print("${list}");
    return list;
  }

  Future<List<Map<String, Object?>>> FilterData({required status}) {
    String quary = "SELECT * FROM incoexp WHERE status=$status";
    return database!.rawQuery(quary);
  }

  Future<void> deleteData({required id}) async {
    database = await checkDB();
    database!.delete("incoexp", where: "id=?", whereArgs: [id]);
  }

//     update

  void updateData({
    required id,
    required amount,
    required notes,
    required paytypes,
    required category,
    required status,
    required time,
    required date,
  }) {
    database!.update(
      "incoexp",
      {
        "category": category,
        "amount": amount,
        "notes": notes,
        "paytypes": paytypes,
        "status": status,
        "date": date,
        "time": time,
      },
      whereArgs: [id],
      where: "id=?",
    );
  }
}
