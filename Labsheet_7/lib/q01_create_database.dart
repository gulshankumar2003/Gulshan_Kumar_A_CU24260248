import 'package:flutter/widgets.dart';
import 'db_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.openDB();
  print('Database created successfully');
}