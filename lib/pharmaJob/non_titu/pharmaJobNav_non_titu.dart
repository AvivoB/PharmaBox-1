import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/pharmacyProfile/pharmacie_consultation.dart';

import '../../Home/map.dart';
import '../../Theme/text.dart';
import '../../Widgets/jobsbox.dart';
import '../../bloc/offres_bloc.dart';
import 'non_titu_bottomsheet.dart';

class PharmaJobNavNonTitu extends StatelessWidget {
  const PharmaJobNavNonTitu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        color: Color.fromARGB(255, 251, 251, 251),
        margin:  EdgeInsets.only(top:height*0.02),
        child: BlocBuilder<OffresBloc, OffresState>(
          builder: (context, state) {
            if (state is FilteredOffresReady) {
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
                        '${state.offres.length} résultats',
                        style: paragraph,
                      ),
                    ],
                  ),
                  ...List.generate(
                    state.offres.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PharmacyProfile(
                                pharmacie: state.offres[index].pharmacie,
                              ),
                            ),
                          );
                        },
                        child: JobBox(
                          pharmacie: state.offres[index].pharmacie,
                          jobName: state.offres[index].nomOffre,
                          zip: state.offres[index].pharmacie.localisation
                                  .codePostal
                                  .toString() +
                              ' ' +
                              state.offres[index].pharmacie.localisation.ville,
                          pharm: state.offres[index].pharmacie.nom,
                          imagePharm:
                              state.offres[index].pharmacie.images.isEmpty
                                  ? 'assets/images/pharma_img.png'
                                  : state.offres[index].pharmacie.images[0],
                        ),
                      ),
                    ),
                  )
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
          },
        ),
      ),
    );
  }
}
