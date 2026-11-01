import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Future<String> getData() async {
    var res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );
    if (res.statusCode != 200) throw Exception('Request failed');
    return res.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FutureBuilder")),
      body: FutureBuilder<String>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Text(snapshot.data!),
          );
        },
      ),
    );
  }
}
