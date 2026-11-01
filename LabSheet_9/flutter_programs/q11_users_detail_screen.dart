import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Future<List> getUsers() async {
    var res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    if (res.statusCode != 200) throw Exception('Request failed');
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: FutureBuilder<List>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading users"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              var u = snapshot.data![i];
              return ListTile(
                title: Text(u['name']),
                subtitle: Text(u['email']),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Detail(user: u)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final Map user;

  Detail({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${user['name']}"),
            Text("Email: ${user['email']}"),
            Text("Phone: ${user['phone']}"),
            Text("Website: ${user['website']}"),
            Text("City: ${user['address']['city']}"),
            Text("Company: ${user['company']['name']}"),
          ],
        ),
      ),
    );
  }
}
