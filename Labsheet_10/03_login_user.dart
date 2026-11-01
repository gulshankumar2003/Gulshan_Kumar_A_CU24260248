import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(home: Login()));

class Login extends StatelessWidget {
  Login({super.key});
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: Column(children: [
      TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: password, decoration: const InputDecoration(labelText: 'Password')),
      ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim(),
          );
        },
        child: const Text('Login'),
      ),
    ]),
  );
}
