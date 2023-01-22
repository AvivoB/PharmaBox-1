import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Home/bottomNavbar.dart';
import 'package:pharmabox/Home/map.dart';
import 'package:pharmabox/Home/search_place.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';

import '../constants.dart';
import '../pharmacyProfile/pharmacy_controller.dart';

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gmap;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  PharmacyController controller = Get.put(PharmacyController());

  GoogleMapController? googleMapController;


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var placeText = 'Search here'.obs;
  Gmap.LatLng? latLng;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      widget.controller.getAndSaveUser();
    });
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigateAndRefresh();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(208, 209, 222, 1),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: width * 0.8,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                size: 25,
                                color: Color.fromRGBO(208, 209, 222, 1),
                              ),
                            ),
                            Obx(() {
                              return Text(placeText.value);
                            })

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Flexible(
                  child: GoogleMap(
                      onMapCreated: (controller){
                        widget.googleMapController = controller;
                      },
                      compassEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,

                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: latLng ?? Gmap.LatLng(45.521563, -122.677433),
                        zoom: 12.0,
                      )
                  ),
                )
                // const Maps(),
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
                    child: BottomNavbar(startIndex: 0),
                    isIos: true,
                    duration: Duration(milliseconds: 400),
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

  void _navigateAndRefresh() async {
    final result = await Get.to(() => AutoCompleteSearch());
    if (result != null) {
      var place = result as Place?;

      if (place != null && place.latLng != null) {
        placeText.value = place.name ?? '';
        latLng = Gmap.LatLng(place.latLng?.lat ?? 0.0, place.latLng?.lng ?? 0.0);
        widget.googleMapController?.animateCamera(CameraUpdate.newLatLng(latLng!));

      }

      // setState(() {
      //   placeText = place?.name ?? '';
      //
      // });

    }

  }
}
