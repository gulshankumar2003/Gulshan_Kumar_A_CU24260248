import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<String> data;

  Future<String> getData() async {
    var res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );
    if (res.statusCode != 200) throw Exception('Request failed');
    return res.body;
  }

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error Handling")),
      body: FutureBuilder<String>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error loading data"),
                  ElevatedButton(
                    onPressed: () => setState(() => data = getData()),
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(child: Text(snapshot.data!));
        },
      ),
    );
  }
}
