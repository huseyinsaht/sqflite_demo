import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper {

  Future<Database> get db async {
    return await initializeDb();
  }

  Future<Database> initializeDb() async {
    var dbPath = join(await getDatabasesPath(), "etrade.db");
    return await openDatabase(dbPath, version: 1, onCreate: createDb);
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }

  Future<List<Product>> getProducts() async {
    var db = await this.db;
    var result =  await db.query("products");
    return List.generate(result.length, (i){
      return Product.fromObject(result[i]);
    });
  }

  Future<int> insert(Product product) async {
    print("=============== INSERTING ");
    var db = await this.db;     
    return await db.insert("products", product.toMap());
  }

  Future<int> delete(int id) async {
    var db = await this.db;
    return await db.rawDelete("delete from products where id= $id");
  }

  Future<int> update(Product product) async {
    var db = await this.db;
    return await db.update("products", product.toMap(), where: "id=?", whereArgs: [product.id]);
  }
}
