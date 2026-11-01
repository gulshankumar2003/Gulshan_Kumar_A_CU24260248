import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(home: CourseStudents()));

class CourseStudents extends StatelessWidget {
  const CourseStudents({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('BCA Students')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('students')
          .where('course', isEqualTo: 'BCA').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snapshot.data!.docs.map((doc) =>
          ListTile(title: Text(doc.data()['name'] ?? ''))).toList());
      },
    ),
  );
}
