import 'package:flutter/material.dart';
import 'db_helper.dart';

class StudentNavigationScreen extends StatefulWidget { const StudentNavigationScreen({super.key}); @override State<StudentNavigationScreen> createState()=>_StudentNavigationScreenState(); }
class _StudentNavigationScreenState extends State<StudentNavigationScreen>{
 late Future<dynamic> dbFuture;List<Map<String,dynamic>> rows=[];final name=TextEditingController();
 @override void initState(){super.initState();dbFuture=openLabDb('q14_students.db','CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('students');if(mounted)setState((){});}
 Future<void> addScreen()async{await Navigator.push(context,MaterialPageRoute(builder:(_)=>_AddStudent(onSave:(value)async{final db=await dbFuture;await db.insert('students',{'name':value});})));await refresh();}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Student List')),floatingActionButton:FloatingActionButton(onPressed:addScreen,child:const Icon(Icons.add)),
 body:ListView(children:rows.map((r)=>ListTile(title:Text(r['name']))).toList()));
}
class _AddStudent extends StatefulWidget{final Future<void> Function(String) onSave;const _AddStudent({required this.onSave});@override State<_AddStudent> createState()=>_AddStudentState();}
class _AddStudentState extends State<_AddStudent>{final name=TextEditingController();@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Add Student')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[
 TextField(controller:name,decoration:const InputDecoration(labelText:'Student name')),ElevatedButton(onPressed:()async{if(name.text.trim().isEmpty)return;await widget.onSave(name.text.trim());if(context.mounted)Navigator.pop(context);},child:const Text('Save'))])));}
