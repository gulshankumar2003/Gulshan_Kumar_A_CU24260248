import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: ListPage()));

class ListPage extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Students")),
    body: ListTile(
      title: Text("Gulshan"),
      subtitle: Text("BCA"),
      onTap: () => Navigator.push(
        c,
        MaterialPageRoute(builder: (_) => Detail("Gulshan", "BCA")),
      ),
    ),
  );
}

class Detail extends StatelessWidget {
  final String name, course;
  Detail(this.name, this.course);

  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("$name\n$course")));
}
