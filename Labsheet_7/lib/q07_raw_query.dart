import 'package:flutter/widgets.dart';
import 'db_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final rows = await (await DBHelper.openDB()).rawQuery('SELECT * FROM students');
  print(rows);
}