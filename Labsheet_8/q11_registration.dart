import 'package:flutter/material.dart';
import 'db_helper.dart';

class RegistrationScreen extends StatefulWidget { const RegistrationScreen({super.key}); @override State<RegistrationScreen> createState()=>_RegistrationScreenState(); }
class _RegistrationScreenState extends State<RegistrationScreen>{
 late Future<dynamic> dbFuture;final name=TextEditingController(),email=TextEditingController(),password=TextEditingController();String message='';
 @override void initState(){super.initState();dbFuture=openLabDb('q11_users.db','CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,password TEXT)');}
 Future<void> register()async{if(name.text.trim().isEmpty||email.text.trim().isEmpty||password.text.isEmpty)return;final db=await dbFuture;await db.insert('users',{'name':name.text,'email':email.text,'password':password.text});setState(()=>message='Registered successfully');}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Registration')),body:ListView(padding:const EdgeInsets.all(16),children:[
 TextField(controller:name,decoration:const InputDecoration(labelText:'Name')),TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),TextField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password')),
 ElevatedButton(onPressed:register,child:const Text('Register')),Text(message)]));
}
