import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(home: Register()));

class Register extends StatelessWidget {
  Register({super.key});
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Register')),
    body: Column(children: [
      TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: password, decoration: const InputDecoration(labelText: 'Password')),
      ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim(),
          );
        },
        child: const Text('Register'),
      ),
    ]),
  );
}
