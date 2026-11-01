import 'package:flutter/material.dart';
import 'db_helper.dart';

class ContactSearchScreen extends StatefulWidget { const ContactSearchScreen({super.key}); @override State<ContactSearchScreen> createState()=>_ContactSearchScreenState(); }
class _ContactSearchScreenState extends State<ContactSearchScreen>{
 late Future<dynamic> dbFuture;List<Map<String,dynamic>> rows=[];
 @override void initState(){super.initState();dbFuture=openLabDb('q7_contacts.db','CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)');search('');}
 Future<void> search(String q)async{final db=await dbFuture;rows=await db.query('contacts',where:'name LIKE ?',whereArgs:['%$q%']);if(mounted)setState((){});}
 Future<void> add()async{final db=await dbFuture;await db.insert('contacts',{'name':'Rahul Kumar','phone':'9876543210'});await search('');}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Search Contacts')),floatingActionButton:FloatingActionButton(onPressed:add,child:const Icon(Icons.add)),
 body:Column(children:[TextField(onChanged:search,decoration:const InputDecoration(labelText:'Search name')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text(r['name']),subtitle:Text(r['phone']))).toList()))]));
}
