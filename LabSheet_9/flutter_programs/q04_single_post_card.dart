import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Future<Map<String, dynamic>> getPost() async {
    var res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );
    if (res.statusCode != 200) throw Exception('Request failed');
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Single Post")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading post"));
          }
          var post = snapshot.data!;
          return Card(
            child: ListTile(
              title: Text(post['title']),
              subtitle: Text(post['body']),
            ),
          );
        },
      ),
    );
  }
}
