import 'package:flutter/material.dart';
import 'db_helper.dart';

class FormValidationScreen extends StatefulWidget { const FormValidationScreen({super.key}); @override State<FormValidationScreen> createState()=>_FormValidationScreenState(); }
class _FormValidationScreenState extends State<FormValidationScreen>{
 final keyForm=GlobalKey<FormState>();final name=TextEditingController(),email=TextEditingController(),password=TextEditingController();late Future<dynamic> dbFuture;String message='';
 @override void initState(){super.initState();dbFuture=openLabDb('q13_users.db','CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,password TEXT)');}
 Future<void> save()async{if(!keyForm.currentState!.validate())return;final db=await dbFuture;await db.insert('users',{'name':name.text,'email':email.text,'password':password.text});setState(()=>message='Saved');}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Form Validation')),body:Form(key:keyForm,child:ListView(padding:const EdgeInsets.all(16),children:[
 TextFormField(controller:name,decoration:const InputDecoration(labelText:'Name'),validator:(v)=>v==null||v.trim().isEmpty?'Required':null),
 TextFormField(controller:email,decoration:const InputDecoration(labelText:'Email'),validator:(v)=>v!=null&&RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)?null:'Enter valid email'),
 TextFormField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password'),validator:(v)=>v!=null&&v.length>=6?null:'Minimum 6 characters'),
 ElevatedButton(onPressed:save,child:const Text('Save')),Text(message)])));
}
