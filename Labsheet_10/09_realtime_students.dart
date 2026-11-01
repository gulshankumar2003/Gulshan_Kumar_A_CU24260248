import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(home: Students()));

class Students extends StatelessWidget {
  const Students({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Students')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snapshot.data!.docs.map((doc) => ListTile(
          title: Text(doc.data()['name'] ?? ''),
          subtitle: Text(doc.data()['course'] ?? ''),
        )).toList());
      },
    ),
  );
}
