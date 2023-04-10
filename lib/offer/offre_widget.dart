import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/model/user_models/offre.dart';
import 'package:sizer/sizer.dart';

import '../Theme/color.dart';
import '../Theme/text.dart';
import '../general/widgets/custom_registration_date_picker.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../general/widgets/custom_switch_widget.dart';
import '../mainpages/mult_selection.dart';
import '../pharmaJob/bottomsheet.dart';
import '../pharmacyProfile/localisation_search.dart';
import '../pharmacyProfile/pharmacyrow.dart';
import 'offer_screen.dart';

class OffreWidget extends StatefulWidget {
  Offre offre;
  OffreWidget({Key? key, required this.offre}) : super(key: key);

  @override
  State<OffreWidget> createState() => _OffreWidgetState();
}

class _OffreWidgetState extends State<OffreWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationController.text = widget.offre.localisation;
    routeController.text = widget.offre.rayon.toString();
    contractController.text = '';
    posteController.text = widget.offre.poste;
    timeController.text = widget.offre.temps;
    dateController.text = widget.offre.date;
    durationController.text = widget.offre.duree;
    salaryController.text = widget.offre.salaireNet.toString();

    descriptionController.text = widget.offre.description;
    stations[0] = widget.offre.rer;
    stations[1] = widget.offre.metro;
    stations[2] = widget.offre.bus;
    stations[3] = widget.offre.tramway;
    stations[4] = widget.offre.gareAccess;
    stations[5] = widget.offre.parking;
    salaireCreche[0] = widget.offre.salaireEnsemble;
    contractController.text = widget.offre.contrat[0];
    salaireCreche[1] = salaireCreche[1];
  }

  final List<String> salaireCrecheList = <String>[
    'Salaire négocier ensemble',
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
  TextEditingController descriptionController = TextEditingController();

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
    Icons.payment_outlined,
    Icons.card_giftcard,
    Icons.restaurant,
    Icons.person,
    Icons.card_giftcard,
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
      widget.offre.contrat = selectedValues;
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.offre.poste,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
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
                                              color: widget.offre.state
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
                                        Text(widget.offre.state
                                            ? "Active"
                                            : "Inactive"),
                                      ],
                                    ),
                                    CustomSwitch(
                                        initialSwitchValue: widget.offre.state,
                                        onTap: (val) {
                                          widget.offre.state = val;
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
                                      Stack(
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
                                          Positioned(
                                            right: 7.w,
                                            child: DropdownButton<String>(
                                              items: <String>[
                                                'Rayonniste',
                                                'Conseiller',
                                                'Préparateur',
                                                'Apprenti',
                                                'Etudiant pharmacie',
                                                'Etudiant 6éme année validée',
                                                'Pharmacien',
                                                'Pharmacien(ne) Titulaire'
                                              ].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (val) {
                                                posteController.text =
                                                    val ?? '';
                                              },
                                            ),
                                          ),
                                        ],
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
                                                    widget.offre.contrat)),
                                      ]),
                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        spacing: 8,
                                        children: widget.offre.contrat
                                            .map((value) => Chip(
                                                  label: Text(value),
                                                  onDeleted: () {
                                                    setState(() {
                                                      widget.offre.contrat
                                                          .remove(value);
                                                      _onSelectedValuesChanged(
                                                          widget.offre.contrat);
                                                    });
                                                  },
                                                ))
                                            .toList(),
                                      ),
                                      PharmacyRow(
                                        text: 'Début immédiate',
                                        icon: Icons.calendar_today_outlined,
                                        initialSwitchValue: widget.offre.debut,
                                        onChanged: (value) {
                                          widget.offre.debut = value;
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
                                          color: Color(0xfF161730),
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
                                          color: Color(0xfF161730),
                                        ),
                                        controller: durationController,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible: !widget.offre.salaireEnsemble,
                                        child: CustomRegistrationTextField(
                                          padding: 1,
                                          label: 'Salaire net mensuel',
                                          textInputType: TextInputType.number,
                                          prefixIcon: const Icon(
                                            Icons.money,
                                            color: Color(0xfF161730),
                                          ),
                                          controller: salaryController,
                                        ),
                                      ),
                                      ...List.generate(
                                        salaireCrecheList.length,
                                        (index) => SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: PharmacyRow(
                                            text: salaireCrecheList[index],
                                            icon: salaireIcons[index],
                                            initialSwitchValue:
                                                salaireCreche[index],
                                            onChanged: (value) {
                                              salaireCreche[index] = value;
                                              if (index == 1) {
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible: !widget.offre.salaireEnsemble,
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
                                        visible: !salaireCreche[1],
                                        child: CustomTable(
                                          horraires: widget.offre.horaires,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible: !salaireCreche[1],
                                        child: PharmacyRow(
                                          text:
                                              "Semaires paires et impaires identiques",
                                          icon: Icons.calendar_month,
                                          initialSwitchValue:
                                              widget.offre.semainePaire,
                                          onChanged: (value) {
                                            widget.offre.semainePaire = value;
                                            if (value) {
                                              widget.offre.horairesImpaires =
                                                  widget.offre.horaires;
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible: !salaireCreche[1],
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
                                        height: 10,
                                      ),
                                      Visibility(
                                        visible: !salaireCreche[1],
                                        child: CustomTable(
                                          horraires:
                                              widget.offre.horairesImpaires,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      /* Text(
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
                                        height: 10,
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
                                                widget.offre.robot,
                                            onChanged: (value) {
                                              widget.offre.robot = value;
                                            },
                                          ),
                                          PharmacyRow(
                                            text: confortList[1],
                                            icon: Icons.smart_toy_outlined,
                                            initialSwitchValue:
                                                widget.offre.electronicLabels,
                                            onChanged: (value) {
                                              widget.offre.electronicLabels =
                                                  value;
                                            },
                                          ),
                                          PharmacyRow(
                                            text: confortList[2],
                                            icon: Icons.qr_code_2_outlined,
                                            initialSwitchValue:
                                                widget.offre.salleDePause,
                                            onChanged: (value) {
                                              widget.offre.salleDePause = value;
                                            },
                                          ),
                                          PharmacyRow(
                                            text: confortList[3],
                                            icon:
                                                Icons.self_improvement_outlined,
                                            initialSwitchValue:
                                                widget.offre.vigile,
                                            onChanged: (value) {
                                              widget.offre.vigile = value;
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
                                              widget.offre.testCovid,
                                          onChanged: (value) {
                                            widget.offre.testCovid = value;
                                          },
                                        ),
                                        PharmacyRow(
                                          text: 'Vaccination',
                                          image: 'assets/icons/Vaccination.png',
                                          initialSwitchValue:
                                              widget.offre.vaccination,
                                          onChanged: (value) {
                                            widget.offre.vaccination = value;
                                          },
                                        ),
                                        PharmacyRow(
                                          text: 'Entretien pharmaceutique',
                                          image:
                                              'assets/icons/missions (3).png',
                                          initialSwitchValue:
                                              widget.offre.entretien,
                                          onChanged: (value) {
                                            widget.offre.entretien = value;
                                          },
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomRegistrationTextField(
                                        padding: 1,
                                        maxLines: 10,
                                        label: 'Description',
                                        prefixIcon: const Icon(
                                          Icons.money,
                                          color: Color(0xfF161730),
                                        ),
                                        controller: descriptionController,
                                      ),*/
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            widget.offre.localisation =
                                                BlocProvider.of<PharmacieBloc>(
                                                        context)
                                                    .pharmacie!
                                                    .localisation
                                                    .ville;
                                            widget.offre.rayon =
                                                int.parse(routeController.text);
                                            widget.offre.poste =
                                                posteController.text;

                                            widget.offre.temps =
                                                timeController.text;
                                            dateController.text =
                                                widget.offre.date;
                                            widget.offre.duree =
                                                durationController.text;
                                            widget.offre.salaireNet =
                                                double.parse(
                                                    salaryController.text);
                                            widget.offre.description =
                                                descriptionController.text;
                                            widget.offre.rer = stations[0];
                                            widget.offre.metro = stations[1];
                                            widget.offre.bus = stations[2];

                                            widget.offre.tramway = stations[3];
                                            widget.offre.gareAccess =
                                                stations[4];
                                            widget.offre.parking = stations[5];

                                            widget.offre.salaireEnsemble =
                                                salaireCreche[0];
                                            widget.offre.creche =
                                                salaireCreche[1];
                                            widget.offre.frais =
                                                salaireCreche[2];
                                            widget.offre.logement =
                                                salaireCreche[3];
                                            widget.offre.ticketsCadeau =
                                                salaireCreche[4];
                                            widget.offre.ticketsRestaurent =
                                                salaireCreche[5];
                                            widget.offre.offre =
                                                salaireCreche[6];
                                            widget.offre.prime =
                                                salaireCreche[7];
                                            salaireCreche[1] = salaireCreche[8];
                                            BlocProvider.of<OffresBloc>(context)
                                                .add(CreateOffre(
                                                    offre: widget.offre));
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
