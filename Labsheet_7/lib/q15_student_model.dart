import 'package:flutter/widgets.dart';
import 'db_helper.dart';
class Student {
  final int? id; final String name,roll,course;
  Student(this.name,this.roll,this.course,{this.id});
  Map<String,Object?> toMap()=>{'name':name,'roll':roll,'course':course};
  factory Student.fromMap(Map<String,Object?> m)=>Student(m['name'] as String,m['roll'] as String,m['course'] as String,id:m['id'] as int?);
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db=await DBHelper.openDB(); await db.insert('students',Student('Rahul','101','BCA').toMap());
  final rows=await db.query('students',where:'roll = ?',whereArgs:['101'],limit:1);
  if(rows.isNotEmpty){final s=Student.fromMap(rows.first);print('${s.name}\n${s.roll}\n${s.course}');}
}