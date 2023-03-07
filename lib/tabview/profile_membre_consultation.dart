import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/button.dart';
import 'package:pharmabox/Widgets/gradientText.dart';
import 'package:pharmabox/general/widgets/custom_slider_consul.dart';
import 'package:pharmabox/general/widgets/custom_slider_with_gradient.dart';
import 'package:pharmabox/model/langue.dart';
import 'package:pharmabox/model/lgo.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

import '../Widgets/countContainer.dart';

class ProfilTab extends StatefulWidget {
  final NonTitulaire membre;
  const ProfilTab({Key? key, required this.membre}) : super(key: key);

  @override
  State<ProfilTab> createState() => _ProfilTabState();
}

class _ProfilTabState extends State<ProfilTab> {
  bool showExperience = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        widget.membre.specialisations.isNotEmpty
            ? Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: height * 0.12,
                width: width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(31, 92, 103, 0.17),
                      offset: Offset(3, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Text(
                          'Spécialisations',
                          style: heading,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    ...List.generate(
                      widget.membre.specialisations.length,
                      (index) => SpecialisationsItem(
                          width: width,
                          height: height,
                          text: widget.membre.specialisations[index].nom),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: height * 0.025,
        ),

        ///lgos
        widget.membre.lgos.isNotEmpty
            ? Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: height * 0.17,
                width: width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(31, 92, 103, 0.17),
                      offset: Offset(3, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Text(
                          'LGO',
                          style: heading,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Column(
                      children: List.generate(
                          widget.membre.lgos.length,
                          (index) => Row(children: [
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                CustomSliderConsul(
                                  assetImage: 'assets/icons/computerIcon.png',
                                  categoryCount: 3,
                                  parent: Lgo(
                                      niveau: widget.membre.lgos[index].niveau,
                                      nom: widget.membre.lgos[index].nom,
                                     ),
                                )
                              ])),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: height * 0.025,
        ),
        //Competences
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.28,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(31, 92, 103, 0.17),
                offset: Offset(3, 3),
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    'Compétences',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Column(
                children: [
                  widget.membre.competences[0].enabled
                      ? Row(
                          children: [
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Image(
                              image: const AssetImage('assets/icons/covid.png'),
                              height: height * 0.025,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              'Test  COVID',
                              style: paragraph,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  widget.membre.competences[1].enabled
                      ? Row(
                          children: [
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Image(
                              image: AssetImage('assets/icons/Vaccination.png'),
                              height: height * 0.025,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              'Vaccination',
                              style: paragraph,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  widget.membre.competences[2].enabled
                      ? Row(
                          children: [
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Image(
                              image: AssetImage('assets/icons/payantIcon.png'),
                              height: height * 0.025,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              'Gestion du tiers payant',
                              style: paragraph,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  widget.membre.competences[3].enabled
                      ? Row(
                          children: [
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Image(
                              image:
                                  AssetImage('assets/icons/TesttubeIcon.png'),
                              height: height * 0.025,
                            ),
                            SizedBox(
                              width: width * 0.025,
                            ),
                            Text(
                              'Gestion des labos',
                              style: paragraph,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        widget.membre.langues.isNotEmpty
            ? Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: height * 0.17,
                width: width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(31, 92, 103, 0.17),
                      offset: Offset(3, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Text(
                          'Langues',
                          style: heading,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Column(
                      children: List.generate(
                          widget.membre.langues.length,
                          (index) => Row(children: [
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                CustomSliderConsul(
                                  assetImage: 'assets/icons/computerIcon.png',
                                  categoryCount: 3,
                                  parent: Langue(
                                      niveau:
                                          widget.membre.langues[index].niveau,
                                      nom: widget.membre.langues[index].nom),
                                )
                              ])),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: height * 0.025,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              showExperience = !showExperience;
            });
          },
          child: CountContainer(
            count: widget.membre.experiences.length,
            text: 'Expériences',
            icon: !showExperience
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_up,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        if (showExperience)
          ...List.generate(
            widget.membre.experiences.length,
            (index) => Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              height: height * 0.1,
              width: width * 0.9,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(31, 92, 103, 0.17),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Text(
                        widget.membre.experiences[index].nomPharmacie,
                        style: heading,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Text(
                        '${widget.membre.experiences[index].anneeDebut} - ${widget.membre.experiences[index].anneeFin}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        const TabBarButton(),
        SizedBox(
          height: height * 0.015,
        ),
      ],
    );
  }
}

class SpecialisationsItem extends StatelessWidget {
  final String text;
  const SpecialisationsItem({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.05,
        ),
        Image(
          image: AssetImage('assets/icons/checkIcon.png'),
          height: height * 0.025,
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Text(
          'Homéopathie',
          style: paragraph,
        ),
      ],
    );
  }
}

class UniversiteItem extends StatelessWidget {
  final String text;
  const UniversiteItem({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.05,
        ),
        Image(
          image: AssetImage('assets/icons/universityIcon.png'),
          height: height * 0.025,
        ),
        SizedBox(
          width: width * 0.015,
        ),
        Text(
          text,
          style: paragraph,
        ),
      ],
    );
  }
}
