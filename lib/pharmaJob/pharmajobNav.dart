import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/pharmaJob/bottomsheet.dart';
import 'package:pharmabox/tabview/profil.dart';

import '../Home/map.dart';
import '../Home/pharmajob.dart';
import '../Theme/text.dart';

class PharmaJobNav extends StatelessWidget {
  const PharmaJobNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height * 0.02,
              color: Colors.white,
            ),
            Container(
              height: height * 0.1,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(208, 209, 222, 1),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: width * 0.9,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.8,
                              child: TextField(
                                onSubmitted: (val) {
                                  BlocProvider.of<MembresBloc>(context)
                                      .add(RechercheLibre(input: val));
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Rechercher',
                                  border: InputBorder.none,
                                  icon: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.search,
                                      size: 25,
                                      color: Color.fromRGBO(208, 209, 222, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) =>
                                      const FiltersBottomSheet(),
                                );
                              },
                              child: Image(
                                height: height * 0.04,
                                image: const AssetImage(
                                  'assets/icons/filter.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: BlocBuilder<MembresBloc, MembresState>(
                    builder: (context, state) {
                  if (state is MembresReady) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.04,
                          color: Colors.white,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.topToBottom,
                                child: const PharmaJob(),
                                isIos: true,
                                duration: const Duration(milliseconds: 400),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: height * 0.2,
                            child: Maps(
                              latLng: LatLng(lat: 44, lng: 44),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/homeindicator.png'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${state.membres.length} résultats',
                              style: paragraph,
                            ),
                          ],
                        ),
                        ...List.generate(
                          state.membres.length,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20.0, top: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Profil(membre: state.membres[index]),
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
                                zip: state
                                        .membres[index].localisation.codePostal
                                        .toString() +
                                    ' ' +
                                    state.membres[index].localisation.ville,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child:
                          Text("Pas de membres recherchant ce type d'offres"),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
