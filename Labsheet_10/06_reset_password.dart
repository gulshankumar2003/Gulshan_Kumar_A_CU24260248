import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(home: ResetPassword()));

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Reset Password')),
    body: Column(children: [
      TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reset email sent')),
          );
        },
        child: const Text('Reset'),
      ),
    ]),
  );
}
