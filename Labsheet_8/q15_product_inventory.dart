import 'package:flutter/material.dart';
import 'db_helper.dart';

class ProductInventoryScreen extends StatefulWidget { const ProductInventoryScreen({super.key}); @override State<ProductInventoryScreen> createState()=>_ProductInventoryScreenState(); }
class _ProductInventoryScreenState extends State<ProductInventoryScreen>{
 late Future<dynamic> dbFuture;List<Map<String,dynamic>> rows=[];final name=TextEditingController(),qty=TextEditingController(),price=TextEditingController();
 @override void initState(){super.initState();dbFuture=openLabDb('q15_products.db','CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,quantity INTEGER,price REAL)');refresh();}
 Future<void> refresh()async{final db=await dbFuture;rows=await db.query('products');if(mounted)setState((){});}
 Future<void> add()async{final q=int.tryParse(qty.text);final p=double.tryParse(price.text);if(name.text.trim().isEmpty||q==null||p==null)return;final db=await dbFuture;await db.insert('products',{'name':name.text,'quantity':q,'price':p});name.clear();qty.clear();price.clear();await refresh();}
 Future<void> edit(Map<String,dynamic> r)async{final db=await dbFuture;await db.update('products',{'quantity':(r['quantity'] as int)+1},where:'id=?',whereArgs:[r['id']]);await refresh();}
 Future<void> remove(int id)async{final db=await dbFuture;await db.delete('products',where:'id=?',whereArgs:[id]);await refresh();}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Product Inventory')),body:Column(children:[
 TextField(controller:name,decoration:const InputDecoration(labelText:'Product name')),TextField(controller:qty,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Quantity')),TextField(controller:price,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Price')),
 ElevatedButton(onPressed:add,child:const Text('Add Product')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text(r['name']),subtitle:Text('Qty: ${r['quantity']} | ₹${r['price']}'),onTap:()=>edit(r),trailing:IconButton(icon:const Icon(Icons.delete),onPressed:()=>remove(r['id'])))).toList()))]));
}
