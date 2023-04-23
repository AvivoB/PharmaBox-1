import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/recherche_bloc.dart';
import 'package:pharmabox/bloc/recherche_pharmajob_bloc.dart';
import 'package:pharmabox/pharmaJob/bottomsheet.dart';
import 'package:pharmabox/tabview/profil.dart';

import '../Home/map.dart';
import '../Theme/text.dart';
import '../bloc/offres_bloc.dart';
import '../offer/recherche_widget.dart';
import '../offer/recherches_display.dart';

class PharmaJobNav extends StatelessWidget {
  const PharmaJobNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        color: Color.fromARGB(255, 251, 251, 251),
        margin: EdgeInsets.only(top: height * 0.02),
        child: BlocBuilder<RecherchePharmajobBloc, RecherchePharmajobState>(
            builder: (context, state) {
          if (state is RecherchesJobReady) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/homeindicator.png'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${state.recherches.length} résultats',
                      style: paragraph,
                    ),
                  ],
                ),
                ...List.generate(
                    state.recherches.length,
                    (index) => InkWell(
                        onTap: () {
                          BlocProvider.of<OffresBloc>(context).add(
                              GetFilteredOffres(
                                  recherche: state.recherches[index]));
                        },
                        child: RechercheDisplay(
                            recherche: state.recherches[index]))),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/homeindicator.png'),
                      ),
                    ),
                  ],
                ),
                Text(
                  '0 résultats',
                  style: paragraph,
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
