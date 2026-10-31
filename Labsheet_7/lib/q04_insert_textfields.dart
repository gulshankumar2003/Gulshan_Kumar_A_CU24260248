import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
Future<Database> openDB() => openDatabase(join(await getDatabasesPath(),'q4.db'),
  version:1, onCreate:(db,v) async => db.execute(
  'CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,course TEXT)'));
void main()=>runApp(MaterialApp(home: StudentPage()));
class StudentPage extends StatelessWidget {
  StudentPage({super.key});
  final name=TextEditingController(), roll=TextEditingController(), course=TextEditingController();
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Add Student')),
    body:Column(children:[
      TextField(controller:name,decoration:const InputDecoration(labelText:'Name')),
      TextField(controller:roll,decoration:const InputDecoration(labelText:'Roll')),
      TextField(controller:course,decoration:const InputDecoration(labelText:'Course')),
      ElevatedButton(onPressed:() async {
        final db=await openDB();
        await db.insert('students',{'name':name.text,'roll':roll.text,'course':course.text});
        if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Student added')));
      },child:const Text('Save'))
    ]));
}