import 'package:flutter/widgets.dart';
import 'db_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DBHelper.openDB();
  await db.insert('students', {'name':'Rahul','roll':'101','course':'BCA'});
  print('Student inserted successfully');
}