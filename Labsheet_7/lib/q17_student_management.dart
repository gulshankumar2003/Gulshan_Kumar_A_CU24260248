import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
Future<Database> openDB()=>openDatabase(join(await getDatabasesPath(),'q17.db'),version:1,
  onCreate:(db,v) async=>db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,course TEXT)'));
void main()=>runApp(const MaterialApp(home:StudentPage()));
class StudentPage extends StatefulWidget { const StudentPage({super.key}); @override State<StudentPage> createState()=>_StudentPageState(); }
class _StudentPageState extends State<StudentPage> {
  final name=TextEditingController(),roll=TextEditingController(),course=TextEditingController();
  List<Map<String,Object?>> students=[];
  Future<void> load() async { students=await (await openDB()).query('students');setState((){}); }
  Future<void> save() async { await (await openDB()).insert('students',{'name':name.text,'roll':roll.text,'course':course.text});name.clear();roll.clear();course.clear();await load(); }
  @override void initState(){super.initState();load();}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Student Management')),body:Column(children:[
    TextField(controller:name,decoration:const InputDecoration(labelText:'Name')),
    TextField(controller:roll,decoration:const InputDecoration(labelText:'Roll')),
    TextField(controller:course,decoration:const InputDecoration(labelText:'Course')),
    ElevatedButton(onPressed:save,child:const Text('Add Student')),
    Expanded(child:ListView.builder(itemCount:students.length,itemBuilder:(context,i){final s=students[i];return ListTile(
      title:Text('${s['name']}'),subtitle:Text('${s['roll']} - ${s['course']}'),
      trailing:Row(mainAxisSize:MainAxisSize.min,children:[
        IconButton(icon:const Icon(Icons.edit),onPressed:() async {
          final c=TextEditingController(text:'${s['name']}');
          await showDialog<void>(context:context,builder:(d)=>AlertDialog(title:const Text('Update Name'),content:TextField(controller:c),actions:[
            TextButton(onPressed:() async {await (await openDB()).update('students',{'name':c.text},where:'id = ?',whereArgs:[s['id']]);if(d.mounted)Navigator.pop(d);await load();},child:const Text('Update'))
          ]));
        }),
        IconButton(icon:const Icon(Icons.delete),onPressed:() async {await (await openDB()).delete('students',where:'id = ?',whereArgs:[s['id']]);await load();})
      ]));}))
  ]));
}