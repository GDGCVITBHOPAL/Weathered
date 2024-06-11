import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathered/src/features/dashboard/data/weather_repository.dart';
import 'package:weathered/src/features/map/service/forecast_tile_provider.dart';
import 'package:weathered/src/features/map/provider/location_provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<TileOverlay> _tileOverlays = {};
  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> _recenterMap(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission;
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      // Location services are not enabled, show error message
      setState(() {
        _locationPermissionGranted = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _locationPermissionGranted = false;
        });
        return;
      }
    }

    setState(() {
      _locationPermissionGranted = true;
      LocationNotifier().getLocation();
    });
  }

  _initTiles() async {
    final String overlayId = DateTime.now().millisecondsSinceEpoch.toString();
    final tileOverlay = TileOverlay(
        tileOverlayId: TileOverlayId(overlayId),
        tileProvider: ForecastTileProvider());
    setState(() {
      _tileOverlays = {tileOverlay};
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_locationPermissionGranted) {
      return const Scaffold(
        body: Center(
          child: Text('Location permission is required to use this feature'),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Heat Map",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: FloatingActionButton(
            foregroundColor: Colors.black87,
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0.75),
            onPressed: () async {
              final container = ProviderScope.containerOf(context);
              final coords = container.read(locationProvider).coords;
              logger.i(coords);
              // if (coords is! AsyncData) return;

              final position = LatLng(coords.latitude, coords.longitude);
              await _recenterMap(position);
            },
            child: const Icon(Icons.my_location),
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final coords = ref.watch(locationProvider).coords;
          if (coords is AsyncLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (coords is AsyncError) {
            logger.e(coords);
            return Text(
              'Error : $coords',
              textAlign: TextAlign.center,
            );
          } else {
            logger.e(coords);
            return GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(coords.latitude, coords.longitude),
                zoom: 5.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _initTiles();
              },
              tileOverlays: _tileOverlays,
            );
          }
        },
      ),
    );
  }
}
