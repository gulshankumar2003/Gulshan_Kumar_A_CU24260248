import 'package:flutter/widgets.dart';
import 'db_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final rows=await (await DBHelper.openDB()).rawQuery('SELECT COUNT(*) AS total FROM students');
  print('Total Students: ${rows.first['total']}');
}