import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static Future<Database> openDB()=>openDatabase(join(await getDatabasesPath(),'q16.db'),version:1,
    onCreate:(db,v) async=>db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,course TEXT)'));
  static Future<int> insert(Map<String,Object?> data) async=>(await openDB()).insert('students',data);
  static Future<List<Map<String,Object?>>> read() async=>(await openDB()).query('students');
  static Future<int> update(int id,String name) async=>(await openDB()).update('students',{'name':name},where:'id = ?',whereArgs:[id]);
  static Future<int> delete(int id) async=>(await openDB()).delete('students',where:'id = ?',whereArgs:[id]);
}
Future<void> main() async { WidgetsFlutterBinding.ensureInitialized(); await DatabaseHelper.insert({'name':'Rahul','roll':'101','course':'BCA'}); print(await DatabaseHelper.read()); }