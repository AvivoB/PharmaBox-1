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
            SizedBox(
              height: height * 0.01,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: BlocBuilder<MembresBloc, MembresState>(
                    builder: (context, state) {
                  if (state is MembresReady) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                    return Column(
                      children: [
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
                        Text(
                          '0 résultats',
                          style: paragraph,
                        ),
                      ],
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
