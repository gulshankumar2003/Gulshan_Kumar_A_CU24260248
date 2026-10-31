import 'package:flutter/widgets.dart';
import 'db_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DBHelper.openDB();
  await db.rawInsert('INSERT INTO students(name,roll,course) VALUES(?,?,?)',['Aman','102','BCA']);
  print('Record inserted');
}