import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool isReady;
  final bool trackingUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapState({
    this.isReady = false,
    this.trackingUser = false,
    this.markers = const [],
    this.controller,
  });

  Set<Marker> get setMarkers {
    return Set.from(markers);
  }

  MapState copyWith({
    bool? isReady,
    bool? trackingUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      trackingUser: trackingUser ?? this.trackingUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocation;
  (double, double)? lastKnownLocation;

  MapNotifier() : super(MapState()) {
    trackUser().listen((event) {
      lastKnownLocation = (event.$1, event.$2);
    });
  }

  Stream<(double, double)> trackUser() async* {
    await for (final position in Geolocator.getPositionStream()) {
      yield (position.latitude, position.longitude);
    }
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(controller: controller, isReady: true);
  }

  void goToLocation(double latitude, double longitude) {
    final newPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    );
    state.controller?.animateCamera(
      CameraUpdate.newCameraPosition(newPosition),
    );
  }

  void toggleTrackingUser() {
    state = state.copyWith(trackingUser: !state.trackingUser);
    if (state.trackingUser) {
      findUser();
      userLocation = trackUser().listen((event) {
        goToLocation(event.$1, event.$2);
      });
    } else {
      userLocation?.cancel();
    }
  }

  void findUser() {
    if (lastKnownLocation == null) return;
    final (lat, lng) = lastKnownLocation!;
    goToLocation(lat, lng);
  }

  void addMarkerCurrentPosition() {
    if (lastKnownLocation == null) return;
    final (lat, lng) = lastKnownLocation!;
    addMarker(lat, lng, 'User known location');
  }

  void addMarker(double lat, double lng, String name) {
    final newMarker = Marker(
      markerId: MarkerId('${state.markers.length}'),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: name),
    );
    state = state.copyWith(markers: [...state.markers, newMarker]);
  }
}

final mapControllerProvider =
    StateNotifierProvider.autoDispose<MapNotifier, MapState>((ref) {
      return MapNotifier();
    });
