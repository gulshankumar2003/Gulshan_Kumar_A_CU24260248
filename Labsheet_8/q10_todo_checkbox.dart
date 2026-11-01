import 'package:flutter/material.dart';
import 'db_helper.dart';

class TodoCheckboxScreen extends StatefulWidget { const TodoCheckboxScreen({super.key}); @override State<TodoCheckboxScreen> createState()=>_TodoCheckboxScreenState(); }
class _TodoCheckboxScreenState extends State<TodoCheckboxScreen>{
 late Future<dynamic> dbFuture;List<Map<String,dynamic>> rows=[];
 @override void initState(){super.initState();dbFuture=openLabDb('q10_tasks.db','CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,done INTEGER)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('tasks');if(mounted)setState((){});}
 Future<void> add()async{final db=await dbFuture;await db.insert('tasks',{'title':'Complete homework','done':0});await refresh();}
 Future<void> toggle(Map<String,dynamic> r,bool? v)async{final db=await dbFuture;await db.update('tasks',{'done':v==true?1:0},where:'id=?',whereArgs:[r['id']]);await refresh();}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('To-Do List')),floatingActionButton:FloatingActionButton(onPressed:add,child:const Icon(Icons.add)),
 body:ListView(children:rows.map((r)=>CheckboxListTile(title:Text(r['title']),value:r['done']==1,onChanged:(v)=>toggle(r,v))).toList()));
}
