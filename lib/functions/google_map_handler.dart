import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHandler {
  static void check(CameraUpdate u, GoogleMapController c) async {
    try {
      c.animateCamera(u);
      c.animateCamera(u);
      LatLngBounds l1 = await c.getVisibleRegion();
      LatLngBounds l2 = await c.getVisibleRegion();
      if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
        check(u, c);
      }
    } catch (e) {
      print("Error in check ${e.toString()}");
    }
  }

  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0;
    late double x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0 ?? 0, y0));
  }

  static Future<BitmapDescriptor> getMarkerIconFromAssetPng(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    ByteData bd = await fi.image.toByteData(format: ImageByteFormat.png) as ByteData;
    return BitmapDescriptor.fromBytes(bd.buffer.asUint8List());
  }

  static Future<String> getMapStyleFromFile(String path) async {
    return await rootBundle.loadString(path);
  }
}
