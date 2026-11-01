import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(home: StudentApp()));

class StudentApp extends StatelessWidget {
  StudentApp({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, auth) {
      if (auth.connectionState == ConnectionState.waiting) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (!auth.hasData) {
        return Scaffold(
          appBar: AppBar(title: const Text('Student Login')),
          body: Column(children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: password, obscureText: true,
              decoration: const InputDecoration(labelText: 'Password')),
            ElevatedButton(onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email.text.trim(), password: password.text.trim());
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.message ?? 'Login failed')));
              }
            }, child: const Text('Login')),
            ElevatedButton(onPressed: () async {
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email.text.trim(), password: password.text.trim());
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.message ?? 'Registration failed')));
              }
            }, child: const Text('Register')),
          ]),
        );
      }
      return Scaffold(
        appBar: AppBar(title: const Text('Student Management'),
          actions: [IconButton(onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout))]),
        body: Column(children: [
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
          TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll Number')),
          TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
          ElevatedButton(onPressed: () async {
            if (name.text.trim().isNotEmpty && roll.text.trim().isNotEmpty &&
                course.text.trim().isNotEmpty) {
              await db.collection('students').add({
                'name': name.text.trim(), 'roll': roll.text.trim(), 'course': course.text.trim(),
              });
              name.clear(); roll.clear(); course.clear();
            }
          }, child: const Text('Add Student')),
          Expanded(child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: db.collection('students').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              return ListView(children: snapshot.data!.docs.map((doc) => ListTile(
                title: Text(doc.data()['name'] ?? ''),
                subtitle: Text('${doc.data()['roll'] ?? ''} - ${doc.data()['course'] ?? ''}'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: () async {
                    await doc.reference.update({'name': 'Updated Student'});
                  }),
                  IconButton(icon: const Icon(Icons.delete), onPressed: () => doc.reference.delete()),
                ]),
              )).toList());
            },
          )),
        ]),
      );
    },
  );
}
