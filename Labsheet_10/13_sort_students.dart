import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(home: SortedStudents()));

class SortedStudents extends StatelessWidget {
  const SortedStudents({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sorted Students')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('students')
          .orderBy('name').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snapshot.data!.docs.map((doc) =>
          ListTile(title: Text(doc.data()['name'] ?? ''))).toList());
      },
    ),
  );
}
