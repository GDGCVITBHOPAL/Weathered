import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../home/view/home_view.dart';
import '../service/forecast_tile_provider.dart';
import '../provider/location_provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
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
    return Scaffold(body: Consumer(
      builder: (context, ref, child) {
        final coords = ref.watch(locationProvider).coords;
        if (coords is AsyncLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (coords is AsyncError) {
          return Text(
            'Error : $coords',
            textAlign: TextAlign.center,
          );
        } else {
          return GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(coords.latitude, coords.longitude),
                zoom: 5.0),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _initTiles();
            },
            tileOverlays: _tileOverlays,
          );
        }
      },
    ));
  }
}
