import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as geo;

class Maps extends StatefulWidget {
  Maps({Key? key, this.mapController, this.latLng}) : super(key: key);

  maps.GoogleMapController? mapController;
  geo.LatLng? latLng;

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return maps.GoogleMap(
        onMapCreated: (controller) {
          widget.mapController = controller;
        },
        compassEnabled: true,
        zoomControlsEnabled: false,
        mapType: maps.MapType.normal,
        markers: {
          maps.Marker(
            markerId: const maps.MarkerId("localisation"),
            position: maps.LatLng(widget.latLng!.lat, widget.latLng!.lng),
          ),
        },
        initialCameraPosition: maps.CameraPosition(
          target: maps.LatLng(widget.latLng!.lat, widget.latLng!.lng),
          zoom: 12.0,
        ));
  }

 
}
