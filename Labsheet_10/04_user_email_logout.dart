import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(FirebaseAuth.instance.currentUser?.email ?? ''),
        ElevatedButton(
          onPressed: () => FirebaseAuth.instance.signOut(),
          child: const Text('Logout'),
        ),
      ],
    )),
  );
}
