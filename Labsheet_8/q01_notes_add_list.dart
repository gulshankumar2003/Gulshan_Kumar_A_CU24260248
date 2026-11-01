import 'package:flutter/material.dart';
import 'db_helper.dart';

class NotesAddListScreen extends StatefulWidget {
  const NotesAddListScreen({super.key});
  @override
  State<NotesAddListScreen> createState() => _NotesAddListScreenState();
}

class _NotesAddListScreenState extends State<NotesAddListScreen> {
  late Future<dynamic> dbFuture;
  List<Map<String, dynamic>> rows = [];
  final title = TextEditingController();
  final content = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbFuture = openLabDb('q1_notes.db',
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)');
    refresh();
  }

  Future<void> refresh() async {
    final db = await dbFuture;
    rows = await db.query('notes');
    if (mounted) setState(() {});
  }

  Future<void> add() async {
    if (title.text.trim().isEmpty) return;
    final db = await dbFuture;
    await db.insert('notes', {'title': title.text.trim(), 'content': content.text.trim()});
    title.clear(); content.clear(); await refresh();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Notes: Add and List')),
    body: Column(children: [
      TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
      TextField(controller: content, decoration: const InputDecoration(labelText: 'Content')),
      ElevatedButton(onPressed: add, child: const Text('Add Note')),
      Expanded(child: ListView(children: rows.map((r) => ListTile(
        title: Text(r['title'] ?? ''), subtitle: Text(r['content'] ?? ''),
      )).toList())),
    ]),
  );
}
