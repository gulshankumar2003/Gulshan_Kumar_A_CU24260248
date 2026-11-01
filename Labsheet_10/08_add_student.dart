import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(home: AddStudent()));

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  final db = FirebaseFirestore.instance;
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add Student')),
    body: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
      TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll Number')),
      TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
      ElevatedButton(
        onPressed: () async {
          await db.collection('students').add({
            'name': name.text, 'roll': roll.text, 'course': course.text,
          });
        },
        child: const Text('Save'),
      ),
    ]),
  );
}
