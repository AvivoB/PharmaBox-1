import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as geo;

class Maps extends StatelessWidget {
  Maps({Key? key, this.mapController, this.latLng}) : super(key: key);

  maps.GoogleMapController? mapController;
  geo.LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    return maps.GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        compassEnabled: true,
        zoomControlsEnabled: false,
        mapType: maps.MapType.normal,
        markers: {
          maps.Marker(
            markerId: const maps.MarkerId("localisation"),
            position: maps.LatLng(latLng!.lat, latLng!.lng),
          ),
        },
        initialCameraPosition: maps.CameraPosition(
          target: maps.LatLng(latLng!.lat, latLng!.lng),
          zoom: 12.0,
        ));
  }
}
