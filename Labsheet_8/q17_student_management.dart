import 'package:flutter/material.dart';
import 'db_helper.dart';

class StudentManagementScreen extends StatefulWidget { const StudentManagementScreen({super.key}); @override State<StudentManagementScreen> createState()=>_StudentManagementScreenState(); }
class _StudentManagementScreenState extends State<StudentManagementScreen>{
 late Future<dynamic> dbFuture;List<Map<String,dynamic>> rows=[];final name=TextEditingController(),roll=TextEditingController();
 @override void initState(){super.initState();dbFuture=openLabDb('q17_students.db','CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('students');if(mounted)setState((){});}
 Future<void> add()async{if(name.text.trim().isEmpty||roll.text.trim().isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Fill all fields')));return;}final db=await dbFuture;await db.insert('students',{'name':name.text.trim(),'roll':roll.text.trim()});name.clear();roll.clear();await refresh();}
 Future<void> edit(Map<String,dynamic> r)async{final n=TextEditingController(text:r['name']),ro=TextEditingController(text:r['roll']);await showDialog(context:context,builder:(c)=>AlertDialog(title:const Text('Update Student'),content:Column(mainAxisSize:MainAxisSize.min,children:[TextField(controller:n,decoration:const InputDecoration(labelText:'Name')),TextField(controller:ro,decoration:const InputDecoration(labelText:'Roll'))]),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),TextButton(onPressed:()async{if(n.text.trim().isEmpty||ro.text.trim().isEmpty)return;final db=await dbFuture;await db.update('students',{'name':n.text.trim(),'roll':ro.text.trim()},where:'id=?',whereArgs:[r['id']]);if(c.mounted)Navigator.pop(c);await refresh();},child:const Text('Save'))]));}
 Future<void> remove(Map<String,dynamic> r)async{final yes=await showDialog<bool>(context:context,builder:(c)=>AlertDialog(title:const Text('Delete student?'),actions:[TextButton(onPressed:()=>Navigator.pop(c,false),child:const Text('Cancel')),TextButton(onPressed:()=>Navigator.pop(c,true),child:const Text('Delete'))]));if(yes==true){final db=await dbFuture;await db.delete('students',where:'id=?',whereArgs:[r['id']]);await refresh();}}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Student Management')),body:Column(children:[
 TextField(controller:name,decoration:const InputDecoration(labelText:'Name')),TextField(controller:roll,decoration:const InputDecoration(labelText:'Roll number')),
 ElevatedButton(onPressed:add,child:const Text('Add Student')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text(r['name']),subtitle:Text(r['roll']),onTap:()=>edit(r),trailing:IconButton(icon:const Icon(Icons.delete),onPressed:()=>remove(r)))).toList()))]));
}
