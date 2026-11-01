import 'package:flutter/material.dart';
import 'db_helper.dart';

class NotesSearchScreen extends StatefulWidget {
  const NotesSearchScreen({super.key});
  @override State<NotesSearchScreen> createState()=>_NotesSearchScreenState();
}
class _NotesSearchScreenState extends State<NotesSearchScreen>{
  late Future<dynamic> dbFuture; List<Map<String,dynamic>> rows=[];
  @override void initState(){super.initState();dbFuture=openLabDb('q4_notes.db','CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)'); search('');}
  Future<void> search(String q) async {final db=await dbFuture; rows=await db.query('notes',where:'title LIKE ?',whereArgs:['%$q%']); if(mounted)setState((){});}
  Future<void> add() async {final db=await dbFuture; await db.insert('notes',{'title':'Flutter Notes','content':'Search example'}); await search('');}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Search Notes')),
    floatingActionButton:FloatingActionButton(onPressed:add,child:const Icon(Icons.add)),
    body:Column(children:[TextField(onChanged:search,decoration:const InputDecoration(labelText:'Search title')),
      Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text(r['title']),subtitle:Text(r['content']))).toList()))]));
}
