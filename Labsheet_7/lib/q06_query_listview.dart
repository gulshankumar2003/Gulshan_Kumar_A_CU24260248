import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
Future<Database> openDB()=>openDatabase(join(await getDatabasesPath(),'q6.db'),version:1,
  onCreate:(db,v) async=>db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,course TEXT)'));
void main()=>runApp(MaterialApp(home:StudentList()));
class StudentList extends StatelessWidget {
  StudentList({super.key});
  Future<List<Map<String,Object?>>> getStudents() async=>(await openDB()).query('students');
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Students')),
    body:FutureBuilder(future:getStudents(),builder:(context,s){
      if(!s.hasData)return const Center(child:CircularProgressIndicator());
      final rows=s.data!;
      return ListView.builder(itemCount:rows.length,itemBuilder:(context,i)=>ListTile(
        title:Text('${rows[i]['name']}'),subtitle:Text('${rows[i]['roll']}')));
    }));
}