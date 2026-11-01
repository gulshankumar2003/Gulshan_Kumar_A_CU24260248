import 'package:flutter/material.dart';
import 'db_helper.dart';

class ContactBookScreen extends StatefulWidget { const ContactBookScreen({super.key}); @override State<ContactBookScreen> createState()=>_ContactBookScreenState(); }
class _ContactBookScreenState extends State<ContactBookScreen>{
 late Future<dynamic> dbFuture; List<Map<String,dynamic>> rows=[]; final name=TextEditingController(); final phone=TextEditingController();
 @override void initState(){super.initState();dbFuture=openLabDb('q5_contacts.db','CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('contacts');if(mounted)setState((){});}
 Future<void> add()async{if(name.text.trim().isEmpty||phone.text.trim().isEmpty)return;final db=await dbFuture;await db.insert('contacts',{'name':name.text,'phone':phone.text});name.clear();phone.clear();await refresh();}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Contact Book')),body:Column(children:[
 TextField(controller:name,decoration:const InputDecoration(labelText:'Name')),TextField(controller:phone,keyboardType:TextInputType.phone,decoration:const InputDecoration(labelText:'Phone')),
 ElevatedButton(onPressed:add,child:const Text('Add Contact')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text(r['name']),subtitle:Text(r['phone']))).toList()))]));
}
