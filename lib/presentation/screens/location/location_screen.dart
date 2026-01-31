import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellaneous/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(userLocationProvider);
    final trackingLocation = ref.watch(trackingLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Current Location'),
            location.when(
              data: (data) => Text('$data'),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 30),
            const Text('Location Tracking'),
            trackingLocation.when(
              data: (data) => Text('$data'),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
