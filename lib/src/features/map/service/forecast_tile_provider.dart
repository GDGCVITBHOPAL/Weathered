import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathered/src/api/api_key.dart';
// TODO : The map overlay is slow

class ForecastTileProvider implements TileProvider {
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);
    try {
      final url =
          "https://tile.openweathermap.org/map/temp_new/$zoom/$x/$y.png?appid=$api_key";
      final uri = Uri.parse(url);
      final imageData = await NetworkAssetBundle(uri).load("");
      tileBytes = imageData.buffer.asUint8List();
    } catch (e) {
      print(e.toString());
    }
    return Tile(256, 256, tileBytes);
  }
}
