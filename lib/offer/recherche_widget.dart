import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/recherche_bloc.dart';
import 'package:pharmabox/model/user_models/recherche.dart';
import 'package:pharmabox/pharmacyProfile/localisation_search.dart';
import 'package:sizer/sizer.dart';

import '../Theme/color.dart';
import '../Theme/text.dart';
import '../general/widgets/custom_registration_date_picker.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../general/widgets/custom_switch_widget.dart';
import '../mainpages/mult_selection.dart';
import '../pharmaJob/non_titu_bottomsheet.dart';
import '../pharmacyProfile/pharmacyrow.dart';
import 'offer_screen.dart';

class RechercheWidget extends StatefulWidget {
  Recherche recherche;
  RechercheWidget({Key? key, required this.recherche}) : super(key: key);

  @override
  State<RechercheWidget> createState() => _RechercheWidgetState();
}

class _RechercheWidgetState extends State<RechercheWidget> {
  @override
  void initState() {
    // TODO: implement initState
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
              height: arrow
                  ? MediaQuery.of(context).size.height * 2.8
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
                                    CustomSwitch(
                                        initialSwitchValue:
                                            widget.recherche.state,
                                        onTap: (val) {
                                          widget.recherche.state = val;
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
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
                                  top: 20,
                                  bottom: 10,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomRegistrationTextField(
                                        label: 'Poste',
                                        readOnly: true,
                                        padding: 1,
                                        prefixIcon: const Icon(
                                          CupertinoIcons.bag,
                                        ),
                                        controller: posteController,
                                        textInputType: TextInputType.none,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                     LocalisationSearch(localisationController: locationController),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomRegistrationTextField(
                                        padding: 1,
                                        label: 'Rayon km',
                                        textInputType: TextInputType.number,
                                        prefixIcon: const Icon(
                                          Icons.map_outlined,
                                          color: Colors.black,
                                        ),
                                        controller: routeController,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          CustomRegistrationTextField(
                                            padding: 1,
                                            label: 'Temps Plein/Temps Partiel',
                                            readOnly: true,
                                            prefixIcon: const Icon(
                                              CupertinoIcons.bag,
                                            ),
                                            controller: timeController,
                                            textInputType: TextInputType.none,
                                          ),
                                          Positioned(
                                            right: 7.w,
                                            child: DropdownButton<String>(
                                              items: <String>[
                                                'Temps Plein',
                                                'Temps Partiel',
                                              ].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (val) {
                                                timeController.text = val ?? '';
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Stack(children: [
                                        CustomRegistrationTextField(
                                          padding: 1,
                                          label: 'Contrat',
                                          readOnly: true,
                                          prefixIcon: const Icon(
                                            CupertinoIcons.bag,
                                          ),
                                          controller: contractController,
                                          textInputType: TextInputType.none,
                                        ),
                                        Positioned(
                                            right: 7.w,
                                            child: MultiSelectDropdown(
                                                onSelectedValuesChanged:
                                                    _onSelectedValuesChanged,
                                                options: _options,
                                                selectedValues:
                                                    widget.recherche.contrat)),
                                      ]),
                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        spacing: 8,
                                        children: widget.recherche.contrat
                                            .map((value) => Chip(
                                                  label: Text(value),
                                                  onDeleted: () {
                                                    setState(() {
                                                      widget.recherche.contrat
                                                          .remove(value);
                                                      _onSelectedValuesChanged(
                                                          widget.recherche
                                                              .contrat);
                                                    });
                                                  },
                                                ))
                                            .toList(),
                                      ),
                                      PharmacyRow(
                                        text: 'Début immédiate',
                                        icon: Icons.calendar_today_outlined,
                                        initialSwitchValue:
                                            widget.recherche.debut,
                                        onChanged: (value) {
                                          widget.recherche.debut = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomRegistrationDatePicker(
                                        padding: 1,
                                        label: 'Début du contrat',
                                        prefixIcon: const Icon(
                                          Icons.calendar_today_outlined,
                                          color: Colors.black,
                                        ),
                                        controller: dateController,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomRegistrationTextField(
                                        padding: 1,
                                        label: 'Durée',
                                        prefixIcon: const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.black,
                                        ),
                                        controller: durationController,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible:
                                            !widget.recherche.salaireEnsemble,
                                        child: CustomRegistrationTextField(
                                          padding: 1,
                                          label: 'Salaire Net',
                                          textInputType: TextInputType.number,
                                          prefixIcon: const Icon(
                                            Icons.money,
                                            color: Colors.black,
                                          ),
                                          controller: salaireController,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                          children: List.generate(
                                        salaireCrecheList.length,
                                        (index) => PharmacyRow(
                                          text: salaireCrecheList[index],
                                          icon: salaireIcons[index],
                                          initialSwitchValue:
                                              salaireCreche[index],
                                          onChanged: (value) {
                                            salaireCreche[index] = value;
                                            if (index == 4) {
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible:
                                            !widget.recherche.salaireEnsemble,
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible:
                                            !widget.recherche.salaireEnsemble,
                                        child: CustomTable(
                                          horraires: widget.recherche.horaires,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible:
                                            !widget.recherche.salaireEnsemble,
                                        child: PharmacyRow(
                                          text:
                                              "Semaires paires et impaires identiques",
                                          icon: Icons.calendar_month,
                                          initialSwitchValue:
                                              widget.recherche.semainePaire,
                                          onChanged: (value) {
                                            widget.recherche.semainePaire =
                                                value;
                                            if (value) {
                                              widget.recherche
                                                      .horairesImpaires =
                                                  widget.recherche.horaires;
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible:
                                            !widget.recherche.salaireEnsemble,
                                        child: CustomTable(
                                          horraires:
                                              widget.recherche.horairesImpaires,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Accessibilité',
                                        style: heading,
                                      ),
                                      Column(
                                          children: List.generate(
                                        transport.length,
                                        (index) => PharmacyRow(
                                          text: transport[index],
                                          icon: transportIcon[index],
                                          initialSwitchValue: stations[index],
                                          onChanged: (value) {
                                            stations[index] = value;
                                          },
                                        ),
                                      )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Confort',
                                        style: heading,
                                      ),
                                      Column(
                                        children: [
                                          PharmacyRow(
                                            text: confortList[0],
                                            icon: Icons.cruelty_free_outlined,
                                            initialSwitchValue:
                                                widget.recherche.robot,
                                            onChanged: (value) {
                                              widget.recherche.robot = value;
                                            },
                                          ),
                                          PharmacyRow(
                                            text: confortList[1],
                                            icon: Icons.smart_toy_outlined,
                                            initialSwitchValue: widget
                                                .recherche.electronicLabels,
                                            onChanged: (value) {
                                              widget.recherche
                                                  .electronicLabels = value;
                                            },
                                          ),
                                          PharmacyRow(
                                            text: confortList[2],
                                            icon: Icons.qr_code_2_outlined,
                                            initialSwitchValue:
                                                widget.recherche.salleDePause,
                                            onChanged: (value) {
                                              widget.recherche.salleDePause =
                                                  value;
                                            },
                                          ),
                                          PharmacyRow(
                                            text: confortList[3],
                                            icon:
                                                Icons.self_improvement_outlined,
                                            initialSwitchValue:
                                                widget.recherche.vigile,
                                            onChanged: (value) {
                                              widget.recherche.vigile = value;
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Missions',
                                        style: heading,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(children: [
                                        PharmacyRow(
                                          text: 'Test COVID',
                                          image: 'assets/icons/covid.png',
                                          initialSwitchValue:
                                              widget.recherche.testCovid,
                                          onChanged: (value) {
                                            widget.recherche.testCovid = value;
                                          },
                                        ),
                                        PharmacyRow(
                                          text: 'Vaccination',
                                          image: 'assets/icons/Vaccination.png',
                                          initialSwitchValue:
                                              widget.recherche.vaccination,
                                          onChanged: (value) {
                                            widget.recherche.vaccination =
                                                value;
                                          },
                                        ),
                                        PharmacyRow(
                                          text: 'Entretien pharmaceutique',
                                          image:
                                              'assets/icons/missions (3).png',
                                          initialSwitchValue:
                                              widget.recherche.entretien,
                                          onChanged: (value) {
                                            widget.recherche.entretien = value;
                                          },
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            widget.recherche.localisation =
                                                locationController.text;
                                            widget.recherche.rayon =
                                                int.parse(routeController.text);
                                            widget.recherche.poste =
                                                posteController.text;

                                            widget.recherche.temps =
                                                timeController.text;
                                            dateController.text =
                                                widget.recherche.date;
                                            widget.recherche.duree =
                                                durationController.text;
                                            widget.recherche.salaireNet =
                                                double.parse(
                                                    salaryController.text);

                                            widget.recherche.rer = stations[0];
                                            widget.recherche.metro =
                                                stations[1];
                                            widget.recherche.bus = stations[2];

                                            widget.recherche.tramway =
                                                stations[3];
                                            widget.recherche.gareAccess =
                                                stations[4];
                                            widget.recherche.parking =
                                                stations[5];

                                            widget.recherche.salaireEnsemble =
                                                salaireCreche[0];
                                            widget.recherche.creche =
                                                salaireCreche[1];
                                            widget.recherche.frais =
                                                salaireCreche[2];
                                            widget.recherche.logement =
                                                salaireCreche[3];

                                            widget.recherche.emploisDuTemps =
                                                salaireCreche[4];
                                            BlocProvider.of<RechercheBloc>(
                                                    context)
                                                .add(CreateRecherche(
                                                    recherche:
                                                        widget.recherche));
                                          }
                                        },
                                        child: FiltersButton(
                                          text: 'Enregistrer',
                                          icon: true,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ]),
                              )
                            ]))
                        : const SizedBox(),
                  ])))
    ]);
  }
}
