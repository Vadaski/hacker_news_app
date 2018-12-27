import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import './news_interface.dart';

const String _tableName = "Items";

class NewsDbProvider implements Source, Cache {
  Database _db;

  NewsDbProvider() {
    init();
  }

  //初始化db
  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "items.db");
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute('''
            CREATE TABLE $_tableName(
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
          ''');
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    final itemMap = await _db.query(
      "$_tableName",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (itemMap.length > 0) {
      return ItemModel.fromDb(itemMap.first);
    }

    return null;
  }

  //ConflictAlgorithm.ignore：当有重复的值被写入时忽略
  Future<int> addItem(ItemModel item) => _db.insert(
        _tableName,
        item.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore
      );

  //unused method
  @override
  Future<List<int>> fetchTopIds() => null;

  Future<int> clear(){
    return _db.delete("$_tableName");
  }
}

NewsDbProvider dbProvider = NewsDbProvider();
