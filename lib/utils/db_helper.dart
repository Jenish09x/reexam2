import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reexam2/screen/bookmark/model/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper helper = DbHelper._();

  DbHelper._();
  Database? database;
  final String DB_NAME = "recipe.db";

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DB_NAME);
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        String queryProductTable = "CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT, recipe TEXT,Quantity TEXT,price Text)";
        db.execute(queryProductTable);
      },
    );
  }

  Future<void> addRecipe(BookmarkModel bookmarkModel) async {
    database = await checkDB();
    database!.insert("product", {
      "recipe":bookmarkModel.recipe,
      "Quantity":bookmarkModel.quantity,
      "price":bookmarkModel.price,
    });
  }

  Future<List<BookmarkModel>> getRecipe() async {
    database = await checkDB();
    String query = "SELECT * FROM product";
    List<Map> data = await database!.rawQuery(query, null);
    List<BookmarkModel> modelList =
    data.map((e) => BookmarkModel.mapToModel(e)).toList();
    return modelList;
  }

  Future<void> deleteRecipe({required String id}) async {
    database = await checkDB();
    database!.delete("product", where: "id=?", whereArgs: [id]);
  }
}
