import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/mainpages/bottomNavbar.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/bloc/pharmacierecherche_bloc.dart';
import 'package:pharmabox/business_logic/competences_bloc/competences_bloc.dart';
import 'package:pharmabox/business_logic/experiences_bloc/experiences_bloc.dart';
import 'package:pharmabox/business_logic/langues_bloc/langues_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';
import 'package:pharmabox/business_logic/specialisations_bloc/specialisations_bloc.dart';
import 'package:pharmabox/business_logic/universites_bloc/universites_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/mainpages/explorer.dart';
import 'package:pharmabox/mainpages/main_map_widget.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gmap;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import '../Widgets/jobsbox.dart';
import '../Widgets/membersBox.dart';
import '../Widgets/pharmaciesbox.dart';
import '../bloc/mainmap_bloc.dart';
import '../bloc/membres_bloc.dart';
import '../bloc/navigation_bloc.dart';
import '../enums/user_type.dart';
import '../model/user_models/marker_model.dart';
import '../pharmaJob/bottomsheet.dart';
import '../pharmacyProfile/pharmacie_consultation.dart';
import '../tabview/profil.dart';
import 'custom_painter_marker.dart';

class HomePage extends StatefulWidget {
  bool fromRegister;
  HomePage({Key? key, this.fromRegister = false}) : super(key: key);

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
  explorerTap(MarkerModel marker) {
    BlocProvider.of<MembresBloc>(context).add(GetMarkerMembres(
        input: places.LatLng(lat: marker.lat, lng: marker.lng)));
    BlocProvider.of<PharmacierechercheBloc>(context).add(GetMarkerPharmacies(
        recherche: places.LatLng(lat: marker.lat, lng: marker.lng)));
    BlocProvider.of<OffresBloc>(context).add(GetMarkerOffres(
        recherche: places.LatLng(lat: marker.lat, lng: marker.lng)));

    setState(() {
      markeOn = true;
    });
  }

  pharmaJobTitu(MarkerModel marker) {
    BlocProvider.of<MembresBloc>(context).add(GetMarkerMembres(
        input: places.LatLng(lat: marker.lat, lng: marker.lng)));
    /*BlocProvider.of<OffresBloc>(context).add(GetExplorerOffres(
        recherche: places.LatLng(lat: marker.lat, lng: marker.lng)));*/
  }

  pharmaJobNonTitu(MarkerModel marker) {
    BlocProvider.of<OffresBloc>(context).add(GetMarkerOffres(
        recherche: places.LatLng(lat: marker.lat, lng: marker.lng)));
    /*BlocProvider.of<MembresBloc>(context).add(GetExplorerMembres(
        input: places.LatLng(lat: marker.lat, lng: marker.lng)));*/
  }

  void animateController(places.LatLng local) {
    googleMapController!.animateCamera(
        Gmap.CameraUpdate.newLatLngZoom(Gmap.LatLng(local.lat, local.lng), 12));
  }

  bool markeOn = false;
  DraggableScrollableController dragController =
      DraggableScrollableController();
  @override
  void initState() {
    super.initState();
    localisationController = TextEditingController();
    tapFunction = explorerTap;

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
    }
  }

  double animationMax = 0.7;

  _getMarkerIcon(int count) async {
    return await CircleAvatarPainter(
            text: count.toString(), color: Colors.blue, radius: 46)
        .toUint8List();
  }

  GlobalKey sheetKey = GlobalKey();
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: appBarCustom(),
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
                  animateController: animateController,
                ),
                Flexible(
                    child: BlocBuilder<MainmapBloc, MainmapState>(
                  buildWhen: (previous, current) => (previous != current),
                  builder: (context, state) {
                    print(state);
                    return BlocListener<NavigationBloc, NavigationState>(
                        listener: (context, state) {
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
                              return GestureDetector(
                                onTap: () {
                                  dragController.animateTo(0.1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                                child: GoogleMap(
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
                                      target:
                                          latLng ?? const Gmap.LatLng(46, 2),
                                      zoom: 6.0,
                                    )),
                              );
                            }));
                  },
                ))
              ],
            ),
            Positioned.fill(
              top: height * 0.45,
              bottom: 80,
              left: 20,
              right: 20,
              child: Visibility(
                visible: markeOn,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      BlocBuilder<MembresBloc, MembresState>(
                        builder: (context, state) {
                          if (state is MembresReady) {
                            return Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(
                                  state.membres.length,
                                  (index) => Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20.0, top: 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Profil(
                                                    membre:
                                                        state.membres[index]),
                                              ),
                                            );
                                          },
                                          child: MembersBox(
                                            user: state.membres[index],
                                            poste: state.membres[index].poste,
                                            image: state.membres[index]
                                                        .photoUrl !=
                                                    ''
                                                ? state.membres[index].photoUrl
                                                : 'assets/images/user.png',
                                            name: state.membres[index].nom +
                                                ' ' +
                                                state.membres[index].prenom,
                                            zip: state.membres[index]
                                                    .localisation.codePostal
                                                    .toString() +
                                                ' ' +
                                                state.membres[index]
                                                    .localisation.ville,
                                          ),
                                        ),
                                      ),
                                      state.membres.length > 1
                                          ? const SizedBox(width: 10)
                                          : const SizedBox(),
                                    ],
                                  ),
                                ));
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      BlocBuilder<PharmacierechercheBloc,
                          PharmacierechercheState>(
                        builder: (context, state) {
                          if (state is ExplorerPharmacieReady) {
                            return Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(
                                  state.pharmacies.length,
                                  (index) => Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PharmacyProfile(
                                                        pharmacie: state
                                                            .pharmacies[index]),
                                              ),
                                            );
                                          },
                                          child: PharmaciesBox(
                                            zip: state.pharmacies[index]
                                                .localisation.ville,
                                            pharmacie: state.pharmacies[index],
                                            pharm: state.pharmacies[index].nom,
                                            imagePharm: state.pharmacies[index]
                                                    .images.isNotEmpty
                                                ? state
                                                    .pharmacies[index].images[0]
                                                : "assets/images/pharma_img.png",
                                          ),
                                        ),
                                      ),
                                      state.pharmacies.length > 1
                                          ? const SizedBox(width: 10)
                                          : const SizedBox(),
                                    ],
                                  ),
                                ));
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      BlocBuilder<OffresBloc, OffresState>(
                        builder: (context, state) {
                          if (state is FilteredOffresReady) {
                            return Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(
                                  state.offres.length,
                                  (index) => Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20.0, top: 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PharmacyProfile(
                                                        pharmacie: state
                                                            .offres[index]
                                                            .pharmacie),
                                              ),
                                            );
                                          },
                                          child: JobBox(
                                            zip: state.offres[index].pharmacie
                                                .localisation.ville,
                                            pharmacie:
                                                state.offres[index].pharmacie,
                                            jobName:
                                                state.offres[index].nomOffre,
                                            pharm: state
                                                .offres[index].pharmacie.nom,
                                            imagePharm: state.offres[index]
                                                    .pharmacie.images.isEmpty
                                                ? 'assets/images/pharma_img.png'
                                                : state.offres[index].pharmacie
                                                    .images[0],
                                          ),
                                        ),
                                      ),
                                      state.offres.length > 1
                                          ? const SizedBox(width: 10)
                                          : const SizedBox(),
                                    ],
                                  ),
                                ));
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ]),
              ),
            ),

            BlocListener<UsersBlocBloc, UsersBlocState>(
              listener: (context, state) {
                if (state is UserAdded) {
                  if (state.user!.poste == UserType.tutor) {
                    if (widget.fromRegister) {
                      animationMax = 1;
                      WidgetsBinding.instance.addPostFrameCallback((_) async =>
                          dragController.animateTo(animationMax,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut));
                      widget.fromRegister = false;
                    }
                  }
                }
              },
              child: SafeArea(
                child: BlocListener<NavigationBloc, NavigationState>(
                  listener: (context, state) {
                    if (state is NavigationInitial ||
                        state is PharmaJobTituState ||
                        state is PharmaJobNonTituState) {
                      animationMax = 0.7;
                      dragController.animateTo(animationMax,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    } else {
                      animationMax = 1;
                      dragController.animateTo(animationMax,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      dragController.animateTo(animationMax,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: DraggableScrollableSheet(
                        initialChildSize: 0.15,
                        minChildSize: 0.15,
                        expand: true,
                        maxChildSize: 1,
                        controller: dragController,
                        builder: (context, scrollController) {
                          return BottomNavbar(
                            scrollController: scrollController,
                            fromRegister: widget.fromRegister,
                            draggableScrollableController: dragController,
                          );
                        }),
                  ),
                ),
              ),
            )
            // },
          ],
        ),
      ),
    );
  }
}
