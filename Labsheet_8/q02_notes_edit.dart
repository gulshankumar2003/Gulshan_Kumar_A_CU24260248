import 'package:flutter/material.dart';
import 'db_helper.dart';

class NotesEditScreen extends StatefulWidget {
  const NotesEditScreen({super.key});
  @override
  State<NotesEditScreen> createState() => _NotesEditScreenState();
}

class _NotesEditScreenState extends State<NotesEditScreen> {
  late Future<dynamic> dbFuture;
  List<Map<String, dynamic>> rows = [];
  @override
  void initState() { super.initState(); dbFuture = openLabDb('q2_notes.db',
    'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)'); refresh(); }
  Future<void> refresh() async { final db = await dbFuture; rows = await db.query('notes'); if (mounted) setState(() {}); }
  Future<void> edit(Map<String, dynamic> row) async {
    final title = TextEditingController(text: row['title']);
    final content = TextEditingController(text: row['content']);
    await showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Edit Note'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
        TextField(controller: content, decoration: const InputDecoration(labelText: 'Content')),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: () async { final db = await dbFuture; await db.update('notes',
          {'title': title.text, 'content': content.text}, where: 'id=?', whereArgs: [row['id']]);
          if (context.mounted) Navigator.pop(context); await refresh(); }, child: const Text('Save'))]));
  }
  Future<void> addSample() async { final db = await dbFuture; await db.insert('notes', {'title':'Tap to edit','content':'Sample note'}); await refresh(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Edit Note')),
    floatingActionButton: FloatingActionButton(onPressed: addSample, child: const Icon(Icons.add)),
    body: ListView(children: rows.map((r) => ListTile(title: Text(r['title']), subtitle: Text(r['content']),
      onTap: () => edit(r))).toList()));
}
