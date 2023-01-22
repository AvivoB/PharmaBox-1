import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/general/widgets/custom_registration_date_picker.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';
import 'package:pharmabox/general/widgets/custom_switch_with_suffix_and_text.dart';
import 'package:pharmabox/general/widgets/custom_textfield_with_dropdown.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyrow.dart';

import 'offer_screen.dart';

class OfferScreenNorm extends StatefulWidget {
  OfferScreenNorm({super.key});

  @override
  State<OfferScreenNorm> createState() => _OfferScreenNormState();
}

class _OfferScreenNormState extends State<OfferScreenNorm> {
  TextEditingController locationController = TextEditingController();

  TextEditingController routeController = TextEditingController();

  TextEditingController contractController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController dateController =
      TextEditingController(text: 'DD/MM/YYYY');

  TextEditingController durationController = TextEditingController();

  TextEditingController salaryController = TextEditingController();

  final List<String> transport = <String>[
    'RER',
    'Métro',
    'Bus',
    'Tramway',
    'Gare',
    'Parking',
  ];

  final List<String> confortList = <String>[
    'Crèche d\'entreprise',
    'Robot',
    'Etiquettes electronique',
    'Salle de pause',
    'Vigile',
    'Logement',
    'Frais de déplacement',
  ];

  final List<Icon> confortIcons = <Icon>[
    const Icon(
      Icons.cruelty_free_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.smart_toy_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.qr_code_2_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.self_improvement_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.local_police_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.cottage_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.airplane_ticket_outlined,
    )
  ];

  final List<Icon> transportIcon = [
    const Icon(
      Icons.directions_car_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.subway_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.directions_bus_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.tram_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.directions_railway_outlined,
      color: Colors.black,
    ),
    const Icon(
      Icons.local_parking_outlined,
      color: Colors.black,
    ),
  ];
  bool arrow = true;
  bool arrow2 = true;
  bool arrow3 = true;
  bool arrow4 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: arrow
                ? MediaQuery.of(context).size.height * 1.72
                : MediaQuery.of(context).size.height * 0.07,
            // width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    const Text(
                      "Pharmacien adjoint",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          arrow = !arrow;
                        });
                      },
                      child: Icon(
                        !arrow
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                arrow
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            dense: true,
                            // leading:
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(106, 214, 151, 1),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  lightGreen.withOpacity(0.6),
                                              spreadRadius: 6,
                                              blurRadius: 6,
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Actif'),
                                  ],
                                ),
                                CustomSwitch(),
                              ],
                            ),
                            // trailing: CustomSwitch(),
                            subtitle: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                ),
                                Text(
                                    'Offre valable 1 mois  à compter du 24/02/2022'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PharmacyRowWithoutSwitch(
                            text:
                                '4 Pl. des Étangs, 93600 Aulnay-sous\n-Bois, France',
                            icon: Icons.location_on,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PharmacyRowWithoutSwitch(
                            text: 'CDI',
                            icon: Icons.description_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PharmacyRowWithoutSwitch(
                            text: 'Temps plein',
                            icon: Icons.schedule,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PharmacyRowWithoutSwitch(
                            text: 'Début immédiate',
                            icon: Icons.calendar_today_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PharmacyRowWithoutSwitch(
                            text: '3 mois',
                            icon: Icons.calendar_month_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PharmacyRowWithoutSwitch(
                            text: '4346 € net/mois',
                            icon: Icons.payments_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              PharmacyRowWithoutSwitch(
                                text: 'Offre à responsabilité',
                                icon: Icons.people,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRowWithoutSwitch(
                                text: 'Prime',
                                image: 'assets/icons/trophy.png',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRowWithoutSwitch(
                                text: "Crèche d'entreprise",
                                icon: Icons.cruelty_free_outlined,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRowWithoutSwitch(
                                text: "Frais de déplacement",
                                icon: Icons.airplane_ticket_outlined,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRowWithoutSwitch(
                                text: 'Tickets cadeau',
                                icon: Icons.card_giftcard,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRowWithoutSwitch(
                                text: 'Tickets restaurant',
                                icon: Icons.restaurant,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRowWithoutSwitch(
                                text: 'Logement',
                                icon: Icons.cottage,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRowWithoutSwitch(
                                text: 'Emplois du temps à discuter',
                                icon: Icons.calendar_month_outlined,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Grille horaires",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const CustomTable(),
                          const SizedBox(
                            height: 20,
                          ),
                          PharmacyRowWithoutSwitch(
                            text: 'Semaines paires et impaires identiques',
                            icon: Icons.calendar_month_outlined,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Description de poste",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Wrap(
                            children: [
                              Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vitae ornare nibh. Quisque metus lectus, convallis porta consectetur a, luctus dapibus ante. Proin venenatis, tellus ac hendrerit sollicitudin.'),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  Color.fromRGBO(124, 237, 172, 1),
                                  Color.fromRGBO(66, 210, 255, 1),
                                ])),
                                child: Center(
                                    child: Text(
                                  'Enregistrer',
                                  style: smallWhite,
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: arrow2
                ? MediaQuery.of(context).size.height * 0.15
                : MediaQuery.of(context).size.height * 0.07,
            // width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(children: [
              Row(
                children: [
                  const Text(
                    "Préparateur en pharmacie",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        arrow2 = !arrow2;
                      });
                    },
                    child: Icon(
                      !arrow2
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_up_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              arrow2
                  ? ListTile(
                      dense: true,
                      // leading:
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                width: MediaQuery.of(context).size.width * 0.05,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(106, 214, 151, 1),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: lightGreen.withOpacity(0.6),
                                        spreadRadius: 6,
                                        blurRadius: 6,
                                      )
                                    ]),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Actif'),
                            ],
                          ),
                        ],
                      ),
                      // trailing: CustomSwitch(),
                      subtitle: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          Text('Offre valable 1 mois  à compter du 24/02/2022'),
                        ],
                      ),
                    )
                  : Container(),
            ]),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: arrow3
                ? MediaQuery.of(context).size.height * 0.15
                : MediaQuery.of(context).size.height * 0.07,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Pharmacien",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          arrow3 = !arrow3;
                        });
                      },
                      child: Icon(
                        !arrow3
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                arrow3
                    ? ListTile(
                        dense: true,
                        // leading:
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.025,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(106, 214, 151, 1),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: lightGreen.withOpacity(0.6),
                                          spreadRadius: 6,
                                          blurRadius: 6,
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Actif'),
                              ],
                            ),
                          ],
                        ),
                        // trailing: CustomSwitch(),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            Text(
                                'Offre valable 1 mois  à compter du 22/02/2022'),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: arrow4
                ? MediaQuery.of(context).size.height * 0.12
                : MediaQuery.of(context).size.height * 0.07,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Pharmacien",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          arrow4 = !arrow4;
                        });
                      },
                      child: Icon(
                        !arrow4
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                arrow4
                    ? ListTile(
                        dense: true,
                        // leading:
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.025,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(214, 125, 106, 1),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(214, 125, 106, 1)
                                                  .withOpacity(0.6),
                                          spreadRadius: 6,
                                          blurRadius: 6,
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Inactif'),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
