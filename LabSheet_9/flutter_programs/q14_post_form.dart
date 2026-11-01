import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  final title = TextEditingController();
  final body = TextEditingController();

  Future<String> sendData() async {
    var res = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title.text,
        'body': body.text,
        'userId': 1,
      }),
    );
    return res.statusCode == 201
        ? "Data Sent Successfully"
        : "Error: ${res.statusCode}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Data")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: body,
              decoration: InputDecoration(labelText: "Body"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  String msg = await sendData();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(msg)),
                  );
                } catch (_) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Network Error")),
                  );
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
