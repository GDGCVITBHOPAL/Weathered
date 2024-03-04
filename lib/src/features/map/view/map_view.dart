import 'dart:async';
import 'package:weathered/src/features/map/model/forecast_tile_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => MapSampleState();
}

class MapSampleState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _initialPos = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 4,
  );

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
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _initTiles();
        },
        tileOverlays: _tileOverlays,
      ),
    );
  }
}
