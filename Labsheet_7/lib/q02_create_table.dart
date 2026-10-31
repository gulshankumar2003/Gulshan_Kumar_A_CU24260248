import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase(join(await getDatabasesPath(), 'q2.db'),
    version: 1, onCreate: (db, v) async => db.execute(
      'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, roll TEXT, course TEXT)'));
  print('Students table created');
}