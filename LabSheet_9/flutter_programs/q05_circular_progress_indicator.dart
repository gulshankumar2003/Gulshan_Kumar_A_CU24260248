import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data = "Loading...";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      var res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      );
      if (!mounted) return;
      setState(() {
        data = res.statusCode == 200 ? res.body : "Error loading data";
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => data = "Network error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loading Data")),
      body: Center(
        child: data == "Loading..."
            ? CircularProgressIndicator()
            : SingleChildScrollView(child: Text(data)),
      ),
    );
  }
}
