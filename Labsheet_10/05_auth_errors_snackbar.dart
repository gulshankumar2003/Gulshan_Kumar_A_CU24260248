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
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim(),
            );
          } on FirebaseAuthException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message ?? 'Login failed')),
            );
          }
        },
        child: const Text('Login'),
      ),
    ]),
  );
}
