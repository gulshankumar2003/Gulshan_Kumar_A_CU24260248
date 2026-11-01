import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List posts = [];
  bool loading = true;
  String error = "";

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  Future<void> getPosts() async {
    try {
      var res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      if (res.statusCode != 200) throw Exception('Request failed');
      if (!mounted) return;
      setState(() {
        posts = jsonDecode(res.body);
        error = "";
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => error = "Error loading posts");
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Refresh Posts")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : error.isNotEmpty && posts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => loading = true);
                          getPosts();
                        },
                        child: Text("Retry"),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: getPosts,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: posts
                        .map((p) => ListTile(title: Text(p['title'])))
                        .toList(),
                  ),
                ),
    );
  }
}
