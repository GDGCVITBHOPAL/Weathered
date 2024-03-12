import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../home/view/home_view.dart';
import '../service/forecast_tile_provider.dart';
import '../provider/location_provider.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});
  @override
  ConsumerState<MapView> createState() => MapViewState();
}

class MapViewState extends ConsumerState<MapView> {
  @override
  void initState() {
    super.initState();
    setState(() {
      requestLocationPermission();
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<TileOverlay> _tileOverlays = {};

  _initTiles() async {
    final String overlayId = DateTime.now().millisecondsSinceEpoch.toString();
    final tileOverlay = TileOverlay(
        tileOverlayId: TileOverlayId(overlayId),
        tileProvider: ForecastTileProvider());
    setState(
      () {
        _tileOverlays = {tileOverlay};
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(locationProvider.future);
    return Scaffold(
      body: FutureBuilder(
        future: position,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error : ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                  target:
                      LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  zoom: 5.0),
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
