import 'package:flutter/material.dart';
import 'db_helper.dart';

class ExpenseSumScreen extends StatefulWidget { const ExpenseSumScreen({super.key}); @override State<ExpenseSumScreen> createState()=>_ExpenseSumScreenState(); }
class _ExpenseSumScreenState extends State<ExpenseSumScreen>{
 late Future<dynamic> dbFuture;List<Map<String,dynamic>> rows=[];double total=0;
 @override void initState(){super.initState();dbFuture=openLabDb('q9_expenses.db','CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount REAL)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('expenses');final r=await db.rawQuery('SELECT SUM(amount) AS total FROM expenses');total=(r.first['total'] as num?)?.toDouble()??0;if(mounted)setState((){});}
 Future<void> add()async{final db=await dbFuture;await db.insert('expenses',{'title':'Food','amount':200.0});await refresh();}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Expense Total')),floatingActionButton:FloatingActionButton(onPressed:add,child:const Icon(Icons.add)),
 body:Column(children:[Padding(padding:const EdgeInsets.all(12),child:Text('Total Expense: ₹${total.toStringAsFixed(2)}',style:const TextStyle(fontSize:20))),
 Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text(r['title']),subtitle:Text('₹${r['amount']}'))).toList()))]));
}
