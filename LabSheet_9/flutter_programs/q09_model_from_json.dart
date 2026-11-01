import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final String title;

  Post(this.title);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json['title']);
  }
}

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Future<List<Post>> getPosts() async {
    var res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (res.statusCode != 200) throw Exception('Request failed');
    List data = jsonDecode(res.body);
    return data.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Objects")),
      body: FutureBuilder<List<Post>>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading posts"));
          }
          return ListView(
            children: snapshot.data!
                .map((p) => ListTile(title: Text(p.title))
                ).toList(),
          );
        },
      ),
    );
  }
}
