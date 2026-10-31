import 'package:flutter/widgets.dart';
import 'db_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await (await DBHelper.openDB()).update('students',{'name':'Amit'},where:'roll = ?',whereArgs:['101']);
  print('Student updated');
}