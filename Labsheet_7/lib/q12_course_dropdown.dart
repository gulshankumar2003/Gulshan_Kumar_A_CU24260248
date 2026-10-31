import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
Future<Database> openDB()=>openDatabase(join(await getDatabasesPath(),'q12.db'),version:1,
  onCreate:(db,v) async=>db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,course TEXT)'));
void main()=>runApp(const MaterialApp(home:CoursePage()));
class CoursePage extends StatefulWidget { const CoursePage({super.key}); @override State<CoursePage> createState()=>_CoursePageState(); }
class _CoursePageState extends State<CoursePage> {
  String course='BCA'; List<Map<String,Object?>> students=[];
  Future<void> load() async { final rows=await (await openDB()).query('students',where:'course = ?',whereArgs:[course]); setState(()=>students=rows); }
  @override void initState(){super.initState();load();}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Course Students')),body:Column(children:[
    DropdownButton<String>(value:course,items:['BCA','BBA','MCA'].map((c)=>DropdownMenuItem(value:c,child:Text(c))).toList(),
      onChanged:(v){setState(()=>course=v!);load();}),
    Expanded(child:ListView(children:students.map((s)=>ListTile(title:Text('${s['name']}'))).toList()))
  ]));
}