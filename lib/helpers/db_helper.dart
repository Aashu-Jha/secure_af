import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static String tableName = 'pass_cards';

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT, accountID TEXT, username TEXT, password TEXT, website TEXT, notes TEXT, other TEXT)');
    }, version: 1);
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(tableName, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    return db.query(tableName);
  }

  static Future<void> delete(String id) async {
    final db = await DBHelper.database();
    await db.delete(tableName, where: 'id = ?', whereArgs: [id] );
    return ;
  }

  static Future<List<Map<String, dynamic>>> getSingleData(String id) async {
    final db = await DBHelper.database();
    return db.query(tableName, where: 'id = ?', whereArgs: [id]);
  }

}

