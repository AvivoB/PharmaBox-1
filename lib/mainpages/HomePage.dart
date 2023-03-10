import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Home/bottomNavbar.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/bloc/pharmacierecherche_bloc.dart';
import 'package:pharmabox/business_logic/competences_bloc/competences_bloc.dart';
import 'package:pharmabox/business_logic/experiences_bloc/experiences_bloc.dart';
import 'package:pharmabox/business_logic/langues_bloc/langues_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';
import 'package:pharmabox/business_logic/specialisations_bloc/specialisations_bloc.dart';
import 'package:pharmabox/business_logic/universites_bloc/universites_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/mainpages/main_map_widget.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gmap;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import '../bloc/mainmap_bloc.dart';
import '../bloc/membres_bloc.dart';
import '../bloc/navigation_bloc.dart';
import '../model/user_models/marker_model.dart';
import 'custom_painter_marker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var placeText = 'Search here'.obs;
  Gmap.LatLng? latLng;

  @override
  void dispose() {
    super.dispose();
    localisationController.dispose();
    googleMapController!.dispose();
  }

  GoogleMapController? googleMapController;
  late TextEditingController localisationController;
  late Function(MarkerModel) tapFunction;
  @override
  void initState() {
    super.initState();
    localisationController = TextEditingController();
    NonTitulaire? user = BlocProvider.of<UsersBlocBloc>(context).state.user;
    if (user != null) {
      BlocProvider.of<UniversitesBloc>(context)
          .add(IntiailiseUniversite(universites: user.universites));
      BlocProvider.of<LgoBloc>(context).add(InitialiseLgo(lgos: user.lgos));
      BlocProvider.of<LanguesBloc>(context)
          .add(InitialiseLangue(langues: user.langues));
      BlocProvider.of<ExperiencesBloc>(context)
          .add(InitialiseExperience(experiences: user.experiences));
      BlocProvider.of<CompetencesBloc>(context)
          .add(InitialiseCompetence(competences: user.competences));
      BlocProvider.of<SpecialisationsBloc>(context)
          .add(InitialiseSpecialisation(specialisations: user.specialisations));
      tapFunction = explorerTap;
    }
  }

  _getMarkerIcon(int count) async {
    return await CircleAvatarPainter(
            text: count.toString(), color: Colors.blue, radius: 46)
        .toUint8List();
  }

  Future createMarkers(
      List<MarkerModel> markers, Function(MarkerModel) onTap) async {
    Set<Marker> setList = {};
    for (MarkerModel marker in markers) {
      setList.add(Marker(
        markerId: MarkerId(marker.lat.toString() + ' ' + marker.lng.toString()),
        position: Gmap.LatLng(marker.lat, marker.lng),
        onTap: () {
          onTap(marker);
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

  explorerTap(MarkerModel marker) {
    BlocProvider.of<MembresBloc>(context).add(GetExplorerMembres(
        input: places.LatLng(lat: marker.lat, lng: marker.lng)));
    BlocProvider.of<PharmacierechercheBloc>(context).add(GetExplorerPharmacies(
        recherche: places.LatLng(lat: marker.lat, lng: marker.lng)));
    BlocProvider.of<OffresBloc>(context).add(GetExplorerOffres(
        recherche: places.LatLng(lat: marker.lat, lng: marker.lng)));
  }

  pharmaJobTitu(MarkerModel marker) {
    BlocProvider.of<OffresBloc>(context).add(GetExplorerOffres(
        recherche: places.LatLng(lat: marker.lat, lng: marker.lng)));
  }

  pharmaJobNonTitu(MarkerModel marker) {
    BlocProvider.of<MembresBloc>(context).add(GetExplorerMembres(
        input: places.LatLng(lat: marker.lat, lng: marker.lng)));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                MainMap(
                  localisationController: localisationController,
                  mapController: googleMapController,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Flexible(child: BlocBuilder<MainmapBloc, MainmapState>(
                  builder: (context, state) {
                    return BlocListener<NavigationBloc, NavigationState>(
                        listener: (context, state) {
                          print(state);
                          if (state is ExplorerState) {
                            tapFunction = explorerTap;
                          } else if (state is PharmaJobTituState) {
                            tapFunction = pharmaJobTitu;
                          } else if (state is PharmaJobNonTituState) {
                            tapFunction = pharmaJobNonTitu;
                          }
                        },
                        child: FutureBuilder(
                            future: createMarkers(state.models, tapFunction),
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
                                  initialCameraPosition: CameraPosition(
                                    target: latLng ?? const Gmap.LatLng(46, 2),
                                    zoom: 6.0,
                                  ));
                            }));
                  },
                ))
              ],
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              expand: true,
              maxChildSize: 1,
              builder: (context, scrollController) =>
                  BottomNavbar(scrollController: scrollController),
            ),
            /*Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: BottomNavbar(startIndex: 0),
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
                          BlocBuilder<MainmapBloc, MainmapState>(
                            builder: (context, state) {
                              final MarkerModel countResults =
                                  state.models.isNotEmpty
                                      ? state.models.reduce(
                                          (model, old) => MarkerModel(
                                              lat: 0,
                                              lng: 0,
                                              count: model.count + old.count))
                                      : MarkerModel(lat: 0, lng: 0, count: 0);
                              return Text(
                                '${countResults.count} résultats',
                                style: paragraph,
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
