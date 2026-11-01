import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(home: CheckLogin()));

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (snapshot.hasData) {
        return Scaffold(body: Center(child: ElevatedButton(
          onPressed: () => FirebaseAuth.instance.signOut(),
          child: const Text('Logout'),
        )));
      }
      return const Scaffold(body: Center(child: Text('Please Login')));
    },
  );
}
