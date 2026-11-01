import 'package:flutter/material.dart';
import 'db_helper.dart';

class NotesSwipeDeleteScreen extends StatefulWidget {
  const NotesSwipeDeleteScreen({super.key});
  @override
  State<NotesSwipeDeleteScreen> createState() => _NotesSwipeDeleteScreenState();
}
class _NotesSwipeDeleteScreenState extends State<NotesSwipeDeleteScreen> {
  late Future<dynamic> dbFuture; List<Map<String,dynamic>> rows=[];
  @override void initState(){super.initState(); dbFuture=openLabDb('q3_notes.db','CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)'); refresh();}
  Future<void> refresh() async {final db=await dbFuture; rows=await db.query('notes'); if(mounted)setState((){});}
  Future<void> add() async {final db=await dbFuture; await db.insert('notes',{'title':'Sample note','content':'Swipe left or right to delete'}); await refresh();}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Swipe to Delete')),
    floatingActionButton:FloatingActionButton(onPressed:add,child:const Icon(Icons.add)),
    body:ListView(children:rows.map((r)=>Dismissible(key:ValueKey(r['id']),background:Container(color:Colors.red),
      onDismissed:(_) async {final db=await dbFuture; await db.delete('notes',where:'id=?',whereArgs:[r['id']]); await refresh();
        if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Note deleted')));},
      child:ListTile(title:Text(r['title']),subtitle:Text(r['content']))).toList()));
}
