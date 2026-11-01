import 'package:flutter/material.dart';
import 'db_helper.dart';

class ContactDeleteConfirmScreen extends StatefulWidget { const ContactDeleteConfirmScreen({super.key}); @override State<ContactDeleteConfirmScreen> createState()=>_ContactDeleteConfirmScreenState(); }
class _ContactDeleteConfirmScreenState extends State<ContactDeleteConfirmScreen>{
 late Future<dynamic> dbFuture; List<Map<String,dynamic>> rows=[];
 @override void initState(){super.initState();dbFuture=openLabDb('q6_contacts.db','CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('contacts');if(mounted)setState((){});}
 Future<void> add()async{final db=await dbFuture;await db.insert('contacts',{'name':'Rahul','phone':'9876543210'});await refresh();}
 Future<void> remove(Map<String,dynamic> r)async{final yes=await showDialog<bool>(context:context,builder:(c)=>AlertDialog(title:const Text('Delete contact?'),content:Text('Delete ${r['name']}?'),actions:[
 TextButton(onPressed:()=>Navigator.pop(c,false),child:const Text('Cancel')),TextButton(onPressed:()=>Navigator.pop(c,true),child:const Text('Delete'))]));
 if(yes==true){final db=await dbFuture;await db.delete('contacts',where:'id=?',whereArgs:[r['id']]);await refresh();}}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Delete Contact')),floatingActionButton:FloatingActionButton(onPressed:add,child:const Icon(Icons.add)),
 body:ListView(children:rows.map((r)=>ListTile(title:Text(r['name']),subtitle:Text(r['phone']),trailing:IconButton(icon:const Icon(Icons.delete),onPressed:()=>remove(r)))).toList()));
}
