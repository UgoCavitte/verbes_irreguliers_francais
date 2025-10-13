import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/firebase/firebase_notifier.dart';

class LoginPage extends StatelessWidget {
  final void Function() reload;

  const LoginPage({super.key, required this.reload});

  @override
  Widget build(BuildContext context) {
    var firebaseNotifier = context.watch<FirebaseNotifier>();

    if (firebaseNotifier.isLoggingIn) {
      return const Center(child: Text('Connexion en cours...'));
    }
    return Center(
      child: FilledButton(
        onPressed: () {
          firebaseNotifier.login(reload);
        },
        child: const Text('Se connecter'),
      ),
    );
  }
}
