import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/recherche_bloc.dart';
import 'package:pharmabox/model/user_models/recherche.dart';
import 'package:pharmabox/pharmacyProfile/localisation_search.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyrow.dart';
import 'package:sizer/sizer.dart';

import '../Theme/color.dart';
import '../Theme/text.dart';
import '../general/widgets/custom_registration_date_picker.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../general/widgets/custom_switch_widget.dart';
import '../mainpages/mult_selection.dart';
import '../pharmaJob/bottomsheet.dart';
import 'offer_screen.dart';

class RechercheDisplay extends StatefulWidget {
  Recherche recherche;
  RechercheDisplay({Key? key, required this.recherche}) : super(key: key);

  @override
  State<RechercheDisplay> createState() => _RechercheDisplayState();
}

class _RechercheDisplayState extends State<RechercheDisplay> {
  @override
  void initState() {
    super.initState();
    locationController.text = widget.recherche.localisation;
    routeController.text = widget.recherche.rayon.toString();
    contractController.text = '';
    posteController.text = widget.recherche.poste;
    timeController.text = widget.recherche.temps;
    dateController.text = widget.recherche.date;
    durationController.text = widget.recherche.duree;
    salaryController.text = widget.recherche.salaireNet.toString();
    stations[0] = widget.recherche.rer;
    stations[1] = widget.recherche.metro;
    stations[2] = widget.recherche.bus;
    stations[3] = widget.recherche.tramway;
    stations[4] = widget.recherche.gareAccess;
    stations[5] = widget.recherche.parking;
    salaireCreche[0] = widget.recherche.salaireEnsemble;
    salaireCreche[1] = widget.recherche.creche;
    salaireCreche[2] = widget.recherche.frais;
    salaireCreche[3] = widget.recherche.logement;
    salaireCreche[4] = widget.recherche.emploisDuTemps;
  }

  final List<String> salaireCrecheList = <String>[
    'Salaire négocier ensemble',
    "Crêche d'entreprise",
    'Frais de déplacement',
    'Logement',
    'Emploi du temps à discuter ensemble'
  ];
  TextEditingController locationController = TextEditingController();

  TextEditingController routeController = TextEditingController();

  TextEditingController contractController = TextEditingController();
  TextEditingController posteController = TextEditingController();

  TextEditingController timeController = TextEditingController();
  TextEditingController salaireController = TextEditingController();

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
    'Robot',
    'Etiquettes electronique',
    'Salle de pause',
    'Vigile',
  ];
  final List<bool> stations = [false, false, false, false, false, false];

  final List<IconData> confortIcons = [
    Icons.smart_toy_outlined,
    Icons.qr_code_2_outlined,
    Icons.self_improvement_outlined,
    Icons.local_police_outlined,
  ];

  final List<IconData> transportIcon = [
    Icons.directions_car_outlined,
    Icons.subway_outlined,
    Icons.directions_bus_outlined,
    Icons.tram_outlined,
    Icons.directions_railway_outlined,
    Icons.local_parking_outlined,
  ];
  List<IconData> salaireIcons = [
    Icons.payment_outlined,
    Icons.cruelty_free_outlined,
    Icons.airplane_ticket_outlined,
    Icons.cottage_outlined,
    Icons.calendar_month
  ];
  final List<bool> salaireCreche = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> _options = ['CDD', 'CDI', 'Alternance', 'STAGE'];

  void _onSelectedValuesChanged(List<String> selectedValues) {
    setState(() {
      widget.recherche.contrat = selectedValues;
      if (selectedValues.isNotEmpty) {
        contractController.text = selectedValues[0];
      } else {
        contractController.text = '';
      }
    });
  }

  bool arrow = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                        Text(
                          widget.recherche.poste,
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
                        ? Form(
                            key: formKey,
                            child: Column(children: [
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          decoration: BoxDecoration(
                                              color: widget.recherche.state
                                                  ? Color.fromRGBO(
                                                      106, 214, 151, 1)
                                                  : Colors.red,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: lightGreen
                                                      .withOpacity(0.6),
                                                  spreadRadius: 6,
                                                  blurRadius: 6,
                                                )
                                              ]),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(widget.recherche.state
                                            ? "Active"
                                            : "Inactive"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15,
                                  top: 5,
                                  bottom: 10,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PharmacyRowWithoutSwitch(
                                        icon: CupertinoIcons.bag,
                                        text: posteController.text,
                                      ),
                                      Visibility(
                                          visible:
                                              widget.recherche.localisation !=
                                                  "",
                                          child: const SizedBox(height: 5)),
                                      Visibility(
                                        visible:
                                            widget.recherche.localisation != "",
                                        child: PharmacyRowWithoutSwitch(
                                          text: widget.recherche.localisation,
                                          icon: Icons.map_outlined,
                                        ),
                                      ),
                                      Visibility(
                                          visible: widget.recherche.rayon != 0,
                                          child: const SizedBox(height: 5)),
                                      Visibility(
                                        visible: widget.recherche.rayon != 0,
                                        child: PharmacyRowWithoutSwitch(
                                          text:
                                              widget.recherche.rayon.toString(),
                                          icon: const Icon(
                                            Icons.map_outlined,
                                            color: Color(0xfF161730),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible:
                                              widget.recherche.temps.isNotEmpty,
                                          child: const SizedBox(height: 5)),
                                      Visibility(
                                        visible:
                                            widget.recherche.temps.isNotEmpty,
                                        child: PharmacyRowWithoutSwitch(
                                          text: widget.recherche.temps,
                                          icon: CupertinoIcons.bag,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Visibility(
                                          visible: widget
                                              .recherche.contrat.isNotEmpty,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                              ),
                                              const Icon(Icons.description),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                              ),
                                              ...List.generate(
                                                  widget
                                                      .recherche.contrat.length,
                                                  (index) => index !=
                                                          widget
                                                                  .recherche
                                                                  .contrat
                                                                  .length -
                                                              1
                                                      ? Text(
                                                          widget.recherche
                                                                      .contrat[
                                                                  index] +
                                                              ', ',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    89,
                                                                    90,
                                                                    112,
                                                                    1),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      : Text(
                                                          widget.recherche
                                                              .contrat[index],
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    89,
                                                                    90,
                                                                    112,
                                                                    1),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: widget.recherche.debut,
                                        child: PharmacyRowWithoutSwitch(
                                          text: 'Début immédiate',
                                          icon: Icons.calendar_today_outlined,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Visibility(
                                        visible: widget.recherche.date !=
                                            "DD/MM/YYYY",
                                        child: PharmacyRowWithoutSwitch(
                                          text: widget.recherche.date,
                                          icon: Icons.calendar_today_outlined,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Visibility(
                                          visible:
                                              widget.recherche.duree.isNotEmpty,
                                          child: PharmacyRowWithoutSwitch(
                                            text: widget.recherche.duree,
                                            icon: Icons.calendar_month_outlined,
                                          )),
                                      const SizedBox(height: 5),
                                      Visibility(
                                          visible:
                                              widget.recherche.salaireNet > 0,
                                          child: PharmacyRowWithoutSwitch(
                                            text: widget.recherche.salaireNet
                                                .toString(),
                                            icon: Icons.money,
                                          )),
                                      const SizedBox(height: 5),
                                      Column(
                                          children: List.generate(
                                        salaireCrecheList.length,
                                        (index) => Visibility(
                                          visible: salaireCreche[index],
                                          child: PharmacyRowWithoutSwitch(
                                            text: salaireCrecheList[index],
                                            icon: salaireIcons[index],
                                          ),
                                        ),
                                      )),
                                      const SizedBox(height: 5),
                                      Visibility(
                                        visible: !widget.recherche.semainePaire,
                                        child: Row(
                                          children: const [
                                            Text(
                                              "Grille horaires semaines paires",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Visibility(
                                        visible: !widget.recherche.semainePaire,
                                        child: CustomTable(
                                          horraires: widget.recherche.horaires,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Visibility(
                                        visible: !widget.recherche.semainePaire,
                                        child: PharmacyRowWithoutSwitch(
                                          text:
                                              "Semaires paires et impaires identiques",
                                          icon: Icons.calendar_month,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Visibility(
                                        visible:
                                            !widget.recherche.salaireEnsemble,
                                        child: Row(
                                          children: const [
                                            Text(
                                              "Grille horaires semaines impaires",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Visibility(
                                        visible:
                                            !widget.recherche.salaireEnsemble,
                                        child: CustomTable(
                                          horraires:
                                              widget.recherche.horairesImpaires,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Accessibilité',
                                        style: heading,
                                      ),
                                      Column(
                                          children: List.generate(
                                        transport.length,
                                        (index) => Visibility(
                                          visible: stations[index],
                                          child: PharmacyRowWithoutSwitch(
                                            text: transport[index],
                                            icon: transportIcon[index],
                                          ),
                                        ),
                                      )),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Confort',
                                        style: heading,
                                      ),
                                      Column(
                                        children: [
                                          Visibility(
                                            visible: widget.recherche.robot,
                                            child: PharmacyRowWithoutSwitch(
                                              text: confortList[0],
                                              icon: Icons.cruelty_free_outlined,
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget
                                                .recherche.electronicLabels,
                                            child: PharmacyRowWithoutSwitch(
                                              text: confortList[1],
                                              icon: Icons.smart_toy_outlined,
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                widget.recherche.salleDePause,
                                            child: PharmacyRowWithoutSwitch(
                                              text: confortList[2],
                                              icon: Icons.qr_code_2_outlined,
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.recherche.vigile,
                                            child: PharmacyRowWithoutSwitch(
                                              text: confortList[3],
                                              icon: Icons
                                                  .self_improvement_outlined,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Missions',
                                        style: heading,
                                      ),
                                      const SizedBox(height: 5),
                                      Column(children: [
                                        widget.recherche.testCovid
                                            ? PharmacyRowWithoutSwitch(
                                                text: 'Test COVID',
                                                image: 'assets/icons/covid.png',
                                              )
                                            : const SizedBox(),
                                        widget.recherche.vaccination
                                            ? PharmacyRowWithoutSwitch(
                                                text: 'Vaccination',
                                                image:
                                                    'assets/icons/Vaccination.png',
                                              )
                                            : const SizedBox(),
                                        widget.recherche.entretien
                                            ? PharmacyRowWithoutSwitch(
                                                text:
                                                    'Entretien pharmaceutique',
                                                image:
                                                    'assets/icons/missions (3).png',
                                              )
                                            : const SizedBox(),
                                      ]),
                                      const SizedBox(height: 5),
                                    ]),
                              )
                            ]))
                        : const SizedBox(),
                  ])))
    ]);
  }
}
