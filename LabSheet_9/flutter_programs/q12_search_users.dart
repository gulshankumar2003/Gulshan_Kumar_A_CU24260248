import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List users = [];
  bool loading = true;
  String search = "";

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      var res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );
      if (res.statusCode != 200) throw Exception('Request failed');
      if (!mounted) return;
      setState(() => users = jsonDecode(res.body));
    } catch (_) {
      if (!mounted) return;
      setState(() => users = []);
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var filtered = users.where((u) =>
        u['name'].toString().toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Search Users")),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search name",
              contentPadding: EdgeInsets.all(12),
            ),
            onChanged: (v) => setState(() => search = v),
          ),
          Expanded(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : users.isEmpty
                    ? Center(child: Text("Error loading users"))
                    : ListView(
                        children: filtered
                            .map((u) => ListTile(title: Text(u['name'])))
                            .toList(),
                      ),
          ),
        ],
      ),
    );
  }
}
