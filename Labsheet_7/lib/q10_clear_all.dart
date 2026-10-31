import 'package:flutter/widgets.dart';
import 'db_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await (await DBHelper.openDB()).delete('students');
  print('All records deleted');
}