import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(home: Notes()));

class Notes extends StatelessWidget {
  Notes({super.key});
  final text = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Please Login')));
    }
    final notes = db.collection('notes').where('uid', isEqualTo: user.uid);
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: Column(children: [
        TextField(controller: text, decoration: const InputDecoration(labelText: 'Enter Note')),
        ElevatedButton(
          onPressed: () async {
            if (text.text.trim().isNotEmpty) {
              await db.collection('notes').add({'uid': user.uid, 'text': text.text.trim()});
              text.clear();
            }
          },
          child: const Text('Add Note'),
        ),
        Expanded(child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: notes.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            return ListView(children: snapshot.data!.docs.map((doc) => ListTile(
              title: Text(doc.data()['text'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => doc.reference.delete(),
              ),
            )).toList());
          },
        )),
      ]),
    );
  }
}
