import 'package:flutter/material.dart';
import 'db_helper.dart';

class ShoppingCartScreen extends StatefulWidget { const ShoppingCartScreen({super.key}); @override State<ShoppingCartScreen> createState()=>_ShoppingCartScreenState(); }
class _ShoppingCartScreenState extends State<ShoppingCartScreen>{
 late Future<dynamic> dbFuture;List<Map<String,dynamic>> rows=[];double total=0;
 @override void initState(){super.initState();dbFuture=openLabDb('q16_cart.db','CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,price REAL,quantity INTEGER)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('cart');final r=await db.rawQuery('SELECT SUM(price * quantity) AS total FROM cart');total=(r.first['total'] as num?)?.toDouble()??0;if(mounted)setState((){});}
 Future<void> add()async{final db=await dbFuture;await db.insert('cart',{'name':'Book','price':100.0,'quantity':2});await refresh();}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Shopping Cart')),floatingActionButton:FloatingActionButton(onPressed:add,child:const Icon(Icons.add)),
 body:Column(children:[Padding(padding:const EdgeInsets.all(12),child:Text('Total: ₹${total.toStringAsFixed(2)}',style:const TextStyle(fontSize:20))),
 Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text(r['name']),subtitle:Text('${r['quantity']} × ₹${r['price']}'))).toList()))]));
}
