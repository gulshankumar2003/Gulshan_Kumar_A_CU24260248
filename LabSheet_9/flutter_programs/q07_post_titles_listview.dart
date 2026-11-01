import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Future<List> getPosts() async {
    var res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (res.statusCode != 200) throw Exception('Request failed');
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Titles")),
      body: FutureBuilder<List>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading posts"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) =>
                ListTile(title: Text(snapshot.data![i]['title'])),
          );
        },
      ),
    );
  }
}
