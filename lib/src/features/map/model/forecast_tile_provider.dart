import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ForecastTileProvider implements TileProvider {
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);
    try {
      final url =
          "https://tile.openweathermap.org/map/temp_new/$zoom/$x/$y.png?appid=b811e375e46ccd83825fb9cb2d9813da";
      final uri = Uri.parse(url);
      final imageData = await NetworkAssetBundle(uri).load("");
      tileBytes = imageData.buffer.asUint8List();
    } catch (e) {
      print(e.toString());
    }
    return Tile(256, 256, tileBytes);
  }
}
