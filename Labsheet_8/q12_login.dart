import 'package:flutter/material.dart';
import 'db_helper.dart';

class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState()=>_LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen>{
 late Future<dynamic> dbFuture;final email=TextEditingController(),password=TextEditingController();String message='';
 @override void initState(){super.initState();dbFuture=openLabDb('q12_users.db','CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,email TEXT,password TEXT)');}
 Future<void> login()async{final db=await dbFuture;final rows=await db.query('users',where:'email=? AND password=?',whereArgs:[email.text,password.text]);
 if(rows.isNotEmpty){if(mounted)Navigator.push(context,MaterialPageRoute(builder:(_)=>const _Home()));}else{setState(()=>message='Invalid login');}}
 Future<void> addDemo()async{final db=await dbFuture;await db.insert('users',{'email':'demo@mail.com','password':'123456'});setState(()=>message='Demo user: demo@mail.com / 123456');}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Login')),body:ListView(padding:const EdgeInsets.all(16),children:[
 TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),TextField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password')),
 ElevatedButton(onPressed:login,child:const Text('Login')),TextButton(onPressed:addDemo,child:const Text('Create demo login')),Text(message)]));
}
class _Home extends StatelessWidget{const _Home();@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Home')),body:const Center(child:Text('Login successful!')));}
