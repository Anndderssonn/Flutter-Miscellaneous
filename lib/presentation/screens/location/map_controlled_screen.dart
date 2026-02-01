import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscellaneous/presentation/providers/providers.dart';

class MapControlledScreen extends ConsumerWidget {
  const MapControlledScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInitialLocation = ref.watch(userLocationProvider);

    return Scaffold(
      body: userInitialLocation.when(
        data: (data) => ControlsMap(latitude: data.$1, longitude: data.$2),
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => const Center(child: Text('Tracking user')),
      ),
    );
  }
}

class ControlsMap extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const ControlsMap({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = ref.watch(mapControllerProvider);

    return Stack(
      children: [
        _MapView(initialLat: latitude, initialLng: longitude),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControllerProvider.notifier).findUser();
            },
            icon: const Icon(Icons.location_searching),
          ),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControllerProvider.notifier).toggleTrackingUser();
            },
            icon: Icon(
              mapController.trackingUser
                  ? Icons.directions_run
                  : Icons.accessibility_new,
            ),
          ),
        ),
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref
                  .read(mapControllerProvider.notifier)
                  .addMarkerCurrentPosition();
            },
            icon: const Icon(Icons.pin_drop),
          ),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLng;

  const _MapView({required this.initialLat, required this.initialLng});

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);

    return GoogleMap(
      markers: mapController.setMarkers,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLat, widget.initialLng),
        zoom: 12,
      ),
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
      onLongPress: (argument) {
        ref
            .read(mapControllerProvider.notifier)
            .addMarker(
              argument.latitude,
              argument.longitude,
              'LongPress Custom Marker',
            );
      },
    );
  }
}
