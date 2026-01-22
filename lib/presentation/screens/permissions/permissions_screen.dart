import 'package:flutter/material.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions')),
      body: const _PermissionsVIew(),
    );
  }
}

class _PermissionsVIew extends StatelessWidget {
  const _PermissionsVIew();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CheckboxListTile(
          value: true,
          title: const Text('Camera'),
          subtitle: const Text('Current status'),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
