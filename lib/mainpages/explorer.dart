import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/mainpages/HomePage.dart';
import 'package:pharmabox/Widgets/countContainer.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/Widgets/jobsbox.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/Widgets/pharmaciesbox.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/bloc/pharmacierecherche_bloc.dart';
import 'package:pharmabox/mainpages/mainmap_explorer.dart';
import 'package:pharmabox/pharmacyProfile/pharmacie_consultation.dart';
import '../Home/map.dart';
import '../Theme/text.dart';

import '../tabview/profil.dart';
import 'main_map_widget.dart';

class Explorer extends StatefulWidget {
  const Explorer({Key? key}) : super(key: key);

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  bool membres = true;
  bool pharmacies = true;
  bool jobs = true;
  int nbResults = 0;
  TextEditingController localisationController = TextEditingController();
  gmaps.GoogleMapController? googleMapController;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var mapWidget = InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.topToBottom,
            child: HomePage(),
            isIos: true,
            duration: const Duration(milliseconds: 400),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        height: height * 0.25,
        child: Maps(
          mapController: googleMapController,
          latLng: const LatLng(lat: 42, lng: 2),
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    MainmapExplorer(
                      localisationController: localisationController,
                      mapController: googleMapController,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // mapWidget,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Hero(
                                        tag: 'anim',
                                        child: Image(
                                          image: AssetImage(
                                            'assets/images/homeindicator.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              BlocBuilder<MembresBloc, MembresState>(
                                builder: (context, membreState) {
                                  return BlocBuilder<OffresBloc, OffresState>(
                                    builder: (context, offreState) {
                                      return BlocBuilder<PharmacierechercheBloc,
                                          PharmacierechercheState>(
                                        builder: (context, pharmaState) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$nbResults résultats',
                                                style: paragraph,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              BlocBuilder<MembresBloc, MembresState>(
                                  builder: (context, state) {
                                if (state is MembresReady) {
                                  nbResults = nbResults + state.membres.length;
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        membres = !membres;
                                      });
                                    },
                                    child: CountContainer(
                                      icon: membres
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_outlined,
                                      count: state.membres.length,
                                      text: 'Membres',
                                    ),
                                  );
                                } else {
                                  return CountContainer(
                                    icon: Icons.keyboard_arrow_down_outlined,
                                    count: 0,
                                    text: 'Membres',
                                  );
                                }
                              }),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              BlocBuilder<MembresBloc, MembresState>(
                                builder: (context, state) {
                                  if (state is MembresReady) {
                                    return membres
                                        ? Column(
                                            children: List.generate(
                                            state.membres.length,
                                            (index) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0, top: 20),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Profil(
                                                              membre:
                                                                  state.membres[
                                                                      index]),
                                                    ),
                                                  );
                                                },
                                                child: MembersBox(
                                                  poste: state.membres[index].poste,
                                                  image: state.membres[index]
                                                              .photoUrl !=
                                                          ''
                                                      ? state.membres[index]
                                                          .photoUrl
                                                      : 'assets/images/user.png',
                                                  name:
                                                      state.membres[index].nom +
                                                          ' ' +
                                                          state.membres[index]
                                                              .prenom,

                                                  zip: state
                                                          .membres[index]
                                                          .localisation
                                                          .codePostal
                                                          .toString() +
                                                      ' ' +
                                                      state.membres[index]
                                                          .localisation.ville,
                                                ),
                                              ),
                                            ),
                                          ))
                                        : Container();
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              BlocBuilder<PharmacierechercheBloc,
                                      PharmacierechercheState>(
                                  builder: (context, state) {
                                if (state is ExplorerPharmacieReady) {
                                  nbResults =
                                      nbResults + state.pharmacies.length;
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        pharmacies = !pharmacies;
                                      });
                                    },
                                    child: CountContainer(
                                      icon: pharmacies
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_outlined,
                                      count: state.pharmacies.length,
                                      text: 'Pharmacies',
                                    ),
                                  );
                                } else {
                                  return CountContainer(
                                    icon: Icons.keyboard_arrow_down_outlined,
                                    count: 0,
                                    text: 'Pharmacies',
                                  );
                                }
                              }),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              BlocBuilder<PharmacierechercheBloc,
                                  PharmacierechercheState>(
                                builder: (context, state) {
                                  if (state is ExplorerPharmacieReady) {
                                    return pharmacies
                                        ? Column(
                                            children: List.generate(
                                            state.pharmacies.length,
                                            (index) => Padding(
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
                                                                      .pharmacies[
                                                                  index]),
                                                    ),
                                                  );
                                                },
                                                child: PharmaciesBox(
                                                  zip: state.pharmacies[index]
                                                      .localisation.ville,
                                                  pharm: state
                                                      .pharmacies[index].nom,
                                                  imagePharm: state
                                                          .pharmacies[index]
                                                          .images
                                                          .isNotEmpty
                                                      ? state.pharmacies[index]
                                                          .images[0]
                                                      : "assets/images/pharma_img.png",
                                                ),
                                              ),
                                            ),
                                          ))
                                        : Container();
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              BlocBuilder<OffresBloc, OffresState>(
                                  builder: (context, state) {
                                if (state is FilteredOffresReady) {
                                  nbResults += state.offres.length;
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        jobs = !jobs;
                                      });
                                    },
                                    child: CountContainer(
                                      icon: jobs
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_outlined,
                                      count: state.offres.length,
                                      text: 'Jobs',
                                    ),
                                  );
                                } else {
                                  return CountContainer(
                                    icon: Icons.keyboard_arrow_down_outlined,
                                    count: 0,
                                    text: 'Jobs',
                                  );
                                }
                              }),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              BlocBuilder<OffresBloc, OffresState>(
                                builder: (context, state) {
                                  if (state is FilteredOffresReady) {
                                    return jobs
                                        ? Column(
                                            children: List.generate(
                                            state.offres.length,
                                            (index) => Padding(
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
                                                  zip: state
                                                      .offres[index]
                                                      .pharmacie
                                                      .localisation
                                                      .ville,
                                                  jobName: state
                                                      .offres[index].nomOffre,
                                                  pharm: state.offres[index]
                                                      .pharmacie.nom,
                                                  imagePharm: state
                                                          .offres[index]
                                                          .pharmacie
                                                          .images
                                                          .isEmpty
                                                      ? 'assets/images/pharma_img.png'
                                                      : state.offres[index]
                                                          .pharmacie.images[0],
                                                ),
                                              ),
                                            ),
                                          ))
                                        : Container();
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
