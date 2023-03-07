import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:pharmabox/mainpages/custom_marker.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:flutter/material.dart' as mat;
import 'dart:ui' as ui;

class MapUtils {
  static Future<places.LatLng> getLocationFromAddress(String address) async {
    print(address);
    List<geo.Location> locations = await geo.locationFromAddress(address);
    geo.Location location = locations.first;
    return places.LatLng(lat: location.latitude, lng: location.longitude);
  }

  static double computeDistance(
      places.LatLng source, places.LatLng destination) {
    Point from = Point(source.lat, source.lng);
    Point to = Point(destination.lat, destination.lng);

    return SphericalUtils.computeDistanceBetween(from, to);
  }

  static Future getAddressFromLocation(maps.LatLng coord) async {
    List<geo.Placemark> markers =
        await geo.placemarkFromCoordinates(coord.latitude, coord.longitude);
    print(markers[0]);
    return markers[0].name!;
  }
}
