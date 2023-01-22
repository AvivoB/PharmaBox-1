import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget {

  Maps({Key? key,this.mapController,this.latLng}) : super(key: key);

  GoogleMapController? mapController;
  LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
        onMapCreated: (controller){
          mapController = controller;
        },
        compassEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,

        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: latLng ?? LatLng(45.521563, -122.677433),
          zoom: 12.0,
        ));
  }
}
