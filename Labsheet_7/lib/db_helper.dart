import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> openDB() => openDatabase(
    join(await getDatabasesPath(), 'student.db'),
    version: 1,
    onCreate: (db, version) async => db.execute(
      'CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, roll TEXT, course TEXT)',
    ),
  );
}
