import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper {
   late Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    var dbPath = join(await getDatabasesPath(), "etrade.db");
    return await openDatabase(dbPath, version: 1, onCreate: createDb);
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }

  Future<List> getProducts() async {
    var db = await this.db;
    return await db.query("products");
  }

  Future<int>insert(Product product) async {
    var db = await this.db;
    var result = await db.insert("products", product.toMap());
  }
}
