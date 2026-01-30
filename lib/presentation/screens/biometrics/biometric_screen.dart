import 'package:flutter/material.dart';

class BiometricScreen extends StatelessWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(onPressed: () {}, child: const Text('Authenticate')),
            const SizedBox(height: 40),
            const Text('Biometric Status', style: TextStyle(fontSize: 30)),
            const Text('Status: ', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
