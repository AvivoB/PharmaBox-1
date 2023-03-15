import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gmap;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Home/main_map_pharma_non_titu.dart';
import 'package:pharmabox/Home/map.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';

import '../bloc/mainmap_bloc.dart';
import '../bloc/membres_bloc.dart';
import '../mainpages/custom_painter_marker.dart';
import '../mainpages/main_map_widget.dart';
import '../model/user_models/marker_model.dart';
import '../pharmaJob/non_titu/pharmaJobNav_non_titu.dart';
import 'bottomNavbar.dart';
import 'main_map_pharma_titu.dart';

class PharmaJobNonTitu extends StatefulWidget {
  const PharmaJobNonTitu({Key? key}) : super(key: key);

  @override
  State<PharmaJobNonTitu> createState() => _PharmaJobNonTituState();
}

class _PharmaJobNonTituState extends State<PharmaJobNonTitu> {
  _getMarkerIcon(int count) async {
    return await CircleAvatarPainter(
            text: count.toString(), color: Colors.blue, radius: 46)
        .toUint8List();
  }

  GoogleMapController? googleMapController;
  late TextEditingController localisationController;
  @override
  void initState() {
    super.initState();
    localisationController = TextEditingController();
  }

  Future createMarkers(List<MarkerModel> markers) async {
    Set<Marker> setList = {};
    for (MarkerModel marker in markers) {
      setList.add(Marker(
        markerId: MarkerId(marker.lat.toString() + ' ' + marker.lng.toString()),
        position: Gmap.LatLng(marker.lat, marker.lng),
        onTap: () async {
          BlocProvider.of<OffresBloc>(context).add(GetExplorerOffres(
              recherche: places.LatLng(lat: marker.lat, lng: marker.lng)));
         Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: PharmaJobNavNonTitu(),
              isIos: true,
              duration: const Duration(milliseconds: 400),
            ),
          );
        },
        icon: BitmapDescriptor.fromBytes(
          await _getMarkerIcon(
            marker.count,
          ),
        ),
        infoWindow: InfoWindow(title: 'Results: ${marker.count}'),
      ));
    }
    return setList;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                MainMapPharmaNonTitu(
                  localisationController: localisationController,
                  mapController: googleMapController,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
               /* Flexible(child: BlocBuilder<MainmapBloc, MainmapState>(
                    builder: (context, state) {
                  return FutureBuilder(
                      future: createMarkers(state.models),
                      builder: (context, snapshot) {
                        return GoogleMap(
                            onMapCreated: (controller) {
                              googleMapController = controller;
                            },
                            compassEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            mapType: MapType.normal,
                            markers: snapshot.hasData
                                ? snapshot.data as Set<Marker>
                                : {},
                            initialCameraPosition: const CameraPosition(
                              target: const Gmap.LatLng(46, 2),
                              zoom: 6.0,
                            ));
                      });
                }))*/
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child:PharmaJobNavNonTitu(),
                    isIos: true,
                    duration: const Duration(milliseconds: 400),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: height * 0.07,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Hero(
                            tag: 'anim',
                            child: Image(
                              image:
                                  AssetImage('assets/images/homeindicator.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '6 résultats',
                          style: paragraph,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
