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
import '../offer/offer_screen.dart';
import '../pharmaJob/bottomsheet.dart';
import '../pharmacyProfile/localisation_search.dart';
import '../pharmacyProfile/pharmacyrow.dart';
import 'widgets/custom_table_consultation.dart';

class OffreConslutationWidget extends StatefulWidget {
  Offre offre;
  OffreConslutationWidget({Key? key, required this.offre}) : super(key: key);

  @override
  State<OffreConslutationWidget> createState() =>
      _OffreConslutationWidgetState();
}

class _OffreConslutationWidgetState extends State<OffreConslutationWidget> {
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
              height: arrow
                  ? MediaQuery.of(context).size.height * 4
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
                          widget.offre.poste,
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
                                  ],
                                ),
                              ),
                              Container(
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
                                      PharmacyRowWithoutSwitch(
                                        text: widget.offre.temps,
                                        icon: CupertinoIcons.bag,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Visibility(
                                          visible:
                                              widget.offre.contrat.isNotEmpty,
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
                                                  widget.offre.contrat.length,
                                                  (index) => index !=
                                                          widget.offre.contrat
                                                                  .length -
                                                              1
                                                      ? Text(
                                                          widget.offre.contrat[
                                                                  index] +
                                                              ',',
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
                                                          widget.offre
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
                                        visible: widget.offre.debut,
                                        child: PharmacyRowWithoutSwitch(
                                          text: 'Démarrage immédiat',
                                          icon: Icons.calendar_today_outlined,
                                        ),
                                      ),
                                      Visibility(
                                        visible: !widget.offre.debut,
                                        child: PharmacyRowWithoutSwitch(
                                          text: widget.offre.date,
                                          icon: Icons.calendar_today_outlined,
                                        ),
                                      ),
                                      PharmacyRowWithoutSwitch(
                                        text: widget.offre.duree,
                                        icon: Icons.calendar_month_outlined,
                                      ),
                                      Visibility(
                                        visible: !widget.offre.salaireEnsemble,
                                        child: PharmacyRowWithoutSwitch(
                                          text: widget.offre.salaireNet
                                              .toString(),
                                          icon: Icons.money,
                                        ),
                                      ),
                                      ...List.generate(
                                        salaireCrecheList.length,
                                        (index) => SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: PharmacyRowWithoutSwitch(
                                            text: salaireCrecheList[index],
                                            icon: salaireIcons[index],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: !salaireCreche[1],
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
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
                                      ),
                                      Visibility(
                                        visible: !salaireCreche[1],
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: CustomTableConsultation(
                                            horraires: widget.offre.horaires,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: widget.offre.semainePaire,
                                        child: PharmacyRowWithoutSwitch(
                                          text:
                                              "Semaires paires et impaires identiques",
                                          icon: Icons.calendar_month,
                                        ),
                                      ),
                                      Visibility(
                                        visible: !widget.offre.semainePaire,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
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
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Visibility(
                                          visible: !widget.offre.semainePaire,
                                          child: CustomTableConsultation(
                                            horraires:
                                                widget.offre.horairesImpaires,
                                          ),
                                        ),
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
                                        icon: 
                                          Icons.money,
                                          color: Color(0xfF161730),
                                        ),
                                        controller: descriptionController,
                                      ),*/
                                    ]),
                              )
                            ]))
                        : const SizedBox(),
                  ])))
    ]);
  }
}
