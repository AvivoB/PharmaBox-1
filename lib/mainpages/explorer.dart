import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:pharmabox/mainpages/HomePage.dart';
import 'package:pharmabox/Widgets/countContainer.dart';
import 'package:pharmabox/Widgets/jobsbox.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/Widgets/pharmaciesbox.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/bloc/pharmacierecherche_bloc.dart';
import 'package:pharmabox/pharmacyProfile/pharmacie_consultation.dart';
import '../Theme/text.dart';

import '../tabview/profil.dart';

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
  int members = 0;
  int joobs = 0;
  int phars = 0;
  TextEditingController localisationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
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
        BlocBuilder<MembresBloc, MembresState>(
          builder: (context, membreState) {
            membreState is MembresReady
                ? members = membreState.membres.length
                : 0;
            return BlocBuilder<OffresBloc, OffresState>(
              builder: (context, offreState) {
                offreState is FilteredOffresReady
                    ? joobs = offreState.offres.length
                    : 0;
                return BlocBuilder<PharmacierechercheBloc,
                    PharmacierechercheState>(
                  builder: (context, pharmaState) {
                    pharmaState is ExplorerPharmacieReady
                        ? phars = pharmaState.pharmacies.length
                        : 0;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${phars + joobs + members} résultats',
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BlocBuilder<MembresBloc, MembresState>(
                      builder: (context, state) {
                    if (state is MembresReady) {
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
                                          builder: (context) => Profil(
                                              membre: state.membres[index]),
                                        ),
                                      );
                                    },
                                    child: MembersBox(
                                      poste: state.membres[index].poste,
                                      image: state.membres[index].photoUrl != ''
                                          ? state.membres[index].photoUrl
                                          : 'assets/images/user.png',
                                      name: state.membres[index].nom +
                                          ' ' +
                                          state.membres[index].prenom,
                                      zip: state.membres[index].localisation
                                              .codePostal
                                              .toString() +
                                          ' ' +
                                          state.membres[index].localisation
                                              .ville,
                                      user: state.membres[index],
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
                  BlocBuilder<PharmacierechercheBloc, PharmacierechercheState>(
                      builder: (context, state) {
                    if (state is ExplorerPharmacieReady) {
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
                  BlocBuilder<PharmacierechercheBloc, PharmacierechercheState>(
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
                                          builder: (context) => PharmacyProfile(
                                              pharmacie:
                                                  state.pharmacies[index]),
                                        ),
                                      );
                                    },
                                    child: PharmaciesBox(
                                      zip: state
                                          .pharmacies[index].localisation.ville,
                                      pharmacie: state.pharmacies[index],
                                      pharm: state.pharmacies[index].nom,
                                      imagePharm: state.pharmacies[index].images
                                              .isNotEmpty
                                          ? state.pharmacies[index].images[0]
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
                                          builder: (context) => PharmacyProfile(
                                              pharmacie: state
                                                  .offres[index].pharmacie),
                                        ),
                                      );
                                    },
                                    child: JobBox(
                                      zip: state.offres[index].pharmacie
                                          .localisation.ville,
                                      pharmacie: state.offres[index].pharmacie,
                                      jobName: state.offres[index].nomOffre,
                                      pharm: state.offres[index].pharmacie.nom,
                                      imagePharm: state.offres[index].pharmacie
                                              .images.isEmpty
                                          ? 'assets/images/pharma_img.png'
                                          : state.offres[index].pharmacie
                                              .images[0],
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
    );
  }
}
