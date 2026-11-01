import 'package:flutter/material.dart';
import 'db_helper.dart';

class ExpenseTrackerScreen extends StatefulWidget { const ExpenseTrackerScreen({super.key}); @override State<ExpenseTrackerScreen> createState()=>_ExpenseTrackerScreenState(); }
class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen>{
 late Future<dynamic> dbFuture;List<Map<String,dynamic>> rows=[];final title=TextEditingController();final amount=TextEditingController();
 @override void initState(){super.initState();dbFuture=openLabDb('q8_expenses.db','CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount REAL)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('expenses');if(mounted)setState((){});}
 Future<void> add()async{final a=double.tryParse(amount.text);if(title.text.trim().isEmpty||a==null)return;final db=await dbFuture;await db.insert('expenses',{'title':title.text,'amount':a});title.clear();amount.clear();await refresh();}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Expense Tracker')),body:Column(children:[
 TextField(controller:title,decoration:const InputDecoration(labelText:'Title')),TextField(controller:amount,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Amount')),
 ElevatedButton(onPressed:add,child:const Text('Add Expense')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text(r['title']),subtitle:Text('₹${r['amount']}'))).toList()))]));
}
