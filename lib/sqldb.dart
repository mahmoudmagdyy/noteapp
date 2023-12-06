import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();

    String path = join(databasePath, 'mahmoud.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion)async {
    await db.execute("ALTER TABLE notes ADD COLUMN title TEXT ");
    print("onUpgrade===========");
  }

  _onCreate(Database db, int version) async {

    Batch batch=db.batch();
     batch.execute(''' 
    CREATE TABLE "notes"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL ,
    "note" TEXT NOT NULL ,
    "color" TEXT NOT NULL
    )
    ''');
    batch.execute(''' 
    CREATE TABLE "students"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL 
    )
    ''');
   await batch.commit();
    print("Create Database and table========");
  }

  // SELECT
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  // INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

// UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

// DELETE

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
 // delete all database
  deleteDataBase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mahmoud.db');
    await deleteDatabase(path);
  }


  ////////////////////////////////////////////////new in sql ///////////////////////////////////////
  ///////////اختصارااات افضل
  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }
  insert(String table,Map<String,Object?>values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table,values);
    return response;
  }
  update(String table ,Map<String,Object?>values,String ?myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table,values,where: myWhere);
    return response;
  }
  delete(String table ,myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table,where:myWhere );
    return response;
  }
}
