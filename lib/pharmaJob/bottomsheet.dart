import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/mainpages/mult_selection.dart';
import 'package:pharmabox/model/horaire.dart';
import 'package:sizer/sizer.dart';

import '../general/widgets/custom_registration_date_picker.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../model/user_models/offre.dart';
import '../offer/offer_screen.dart';
import '../pharmacyProfile/localisation_search.dart';
import '../pharmacyProfile/pharmacyrow.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({Key? key}) : super(key: key);

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
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
  final List<String> salaireCrecheList = <String>[
    'Salaire négocier ensemble',
    'Emploi du temps à discuter ensemble'
    /* "Crêche d'entreprise",
    'Frais de déplacement',
    'Logement',
    'Tickets cadeau',
    'Tickets restaurent',
    'Offre à responsabilité',
    'Prime',
   */
  ];
  final List<Horaire> horraires = [
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
  ];
  List<Horaire> horrairesImpaires = [
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
    Horaire(matinee: '', apresMidi: '', soiree: '', nuit: ''),
  ];
  final List<bool> confort = [false, false, false, false];
  final List<bool> missions = [false, false, false];
  final List<bool> salaireCreche = [false, false];
  final List<bool> stations = [false, false, false, false, false, false];

  bool debut = false;
  bool state = false;
  bool semainesImpaires = false;
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
    Icons.calendar_month
    /* Icons.cruelty_free_outlined,
    Icons.airplane_ticket_outlined,
    Icons.cottage_outlined,
    Icons.payment_outlined,
    Icons.card_giftcard,
    Icons.restaurant,
    Icons.person,
    */
  ];

  List<String> _options = ['CDD', 'CDI', 'Alternance', 'STAGE'];

  List<String> _selectedValues = [];

  void _onSelectedValuesChanged(List<String> selectedValues) {
    setState(() {
      _selectedValues = selectedValues;
      if (selectedValues.isNotEmpty) {
        contractController.text = selectedValues[0];
      } else {
        contractController.text = '';
      }
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PharmacieBloc>(context).add(GetPharmacie());
    salaireController.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        height: height * 0.85,
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15,
          top: 20,
          bottom: 10,
        ),
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filtres',
                  style: heading,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
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
                      'Etudiant Pharmacie',
                      'Etudiant en 6ᵉ année validée',
                      'Pharmacien',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      posteController.text = val ?? '';
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
                      onSelectedValuesChanged: _onSelectedValuesChanged,
                      options: _options,
                      selectedValues: _selectedValues)),
            ]),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 8,
              children: _selectedValues
                  .map((value) => Chip(
                        label: Text(value),
                        onDeleted: () {
                          setState(() {
                            _selectedValues.remove(value);
                            _onSelectedValuesChanged(_selectedValues);
                          });
                        },
                      ))
                  .toList(),
            ),
            PharmacyRow(
              text: 'Début immédiate',
              icon: Icons.calendar_today_outlined,
              initialSwitchValue: debut,
              onChanged: (value) {
                debut = value;
                setState(() {});
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !debut,
              child: CustomRegistrationDatePicker(
                padding: 1,
                label: 'Début du contrat',
                prefixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xfF161730),
                ),
                controller: dateController,
              ),
            ),
            (_selectedValues.contains("CDD") ||
                    _selectedValues.contains("Alternance") ||
                    _selectedValues.contains("Stage"))
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CustomRegistrationTextField(
                      padding: 1,
                      label: 'Durée',
                      prefixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xfF161730),
                      ),
                      controller: durationController,
                    ),
                  )
                : const SizedBox(),
            Visibility(
              visible: !salaireCreche[0],
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: CustomRegistrationTextField(
                  padding: 1,
                  label: 'Salaire net mensuel',
                  textInputType: TextInputType.number,
                  prefixIcon: const Icon(
                    Icons.money,
                    color: Color(0xfF161730),
                  ),
                  controller: salaireController,
                ),
              ),
            ),
            Column(
                children: List.generate(
              salaireCreche.length,
              (index) => PharmacyRow(
                text: salaireCrecheList[index],
                icon: salaireIcons[index],
                initialSwitchValue: salaireCreche[index],
                onChanged: (value) {
                  salaireCreche[index] = value;
                  setState(() {});
                },
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !salaireCreche[1],
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
                horraires: horraires,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !salaireCreche[1],
              child: PharmacyRow(
                text: "Semaires paires et impaires identiques",
                icon: Icons.calendar_month,
                initialSwitchValue: semainesImpaires,
                onChanged: (value) {
                  semainesImpaires = value;
                  if (value) {
                    horrairesImpaires = horraires;
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
              height: 20,
            ),
            Visibility(
              visible: !salaireCreche[1],
              child: CustomTable(
                horraires: horrairesImpaires,
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
                  initialSwitchValue: confort[0],
                  onChanged: (value) {
                    confort[0] = value;
                  },
                ),
                PharmacyRow(
                  text: confortList[1],
                  icon: Icons.smart_toy_outlined,
                  initialSwitchValue: confort[1],
                  onChanged: (value) {
                    confort[1] = value;
                  },
                ),
                PharmacyRow(
                  text: confortList[2],
                  icon: Icons.qr_code_2_outlined,
                  initialSwitchValue: confort[2],
                  onChanged: (value) {
                    confort[2] = value;
                  },
                ),
                PharmacyRow(
                  text: confortList[3],
                  icon: Icons.self_improvement_outlined,
                  initialSwitchValue: confort[3],
                  onChanged: (value) {
                    confort[3] = value;
                  },
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              'Missions',
              style: heading,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Column(children: [
              PharmacyRow(
                text: 'Test COVID',
                image: 'assets/icons/covid.png',
                initialSwitchValue: missions[0],
                onChanged: (value) {
                  missions[0] = value;
                },
              ),
              PharmacyRow(
                text: 'Vaccination',
                image: 'assets/icons/Vaccination.png',
                initialSwitchValue: missions[1],
                onChanged: (value) {
                  missions[1] = value;
                },
              ),
              PharmacyRow(
                text: 'Entretien pharmaceutique',
                image: 'assets/icons/missions (3).png',
                initialSwitchValue: missions[2],
                onChanged: (value) {
                  missions[2] = value;
                },
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            CustomRegistrationTextField(
              padding: 1,
              maxLines: 2,
              label: 'Description',
              prefixIcon: const Icon(
                Icons.money,
                color: Color(0xfF161730),
              ),
              controller: descriptionController,
            ),
            const SizedBox(
              height: 20,
            ),*/
            InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  /*if (BlocProvider.of<PharmacieBloc>(context).pharmacie ==
                      null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color(0xFF7CEDAC),
                        content: const Text(
                            "Veuillez créer votre pharmacie avant de créer une offre d'emploi"),
                      ),
                    );
                  } else {*/
                  Offre offre = Offre(
                    state: true,
                    description: descriptionController.text,
                    bus: stations[2],
                    salaireNet: double.parse(salaireController.text),
                    rer: stations[0],
                    metro: stations[1],
                    tramway: stations[2],
                    gareAccess: stations[3],
                    parking: stations[4],
                    robot: confort[0],
                    electronicLabels: confort[1],
                    salleDePause: confort[2],
                    vigile: confort[3],
                    testCovid: missions[0],
                    vaccination: missions[1],
                    entretien: missions[2],
                    salaireEnsemble: salaireCreche[0],
                    creche: salaireCreche[0],
                    frais: salaireCreche[0],
                    logement: salaireCreche[0],
                    ticketsCadeau: salaireCreche[0],
                    ticketsRestaurent: salaireCreche[0],
                    offre: salaireCreche[0],
                    prime: salaireCreche[0],
                    emploisDuTemps: salaireCreche[1],
                    semainePaire: semainesImpaires,
                    horairesImpaires: horrairesImpaires,
                    debut: debut,
                    localisation:
                        BlocProvider.of<PharmacieBloc>(context).pharmacie !=
                                null
                            ? BlocProvider.of<PharmacieBloc>(context)
                                .pharmacie!
                                .localisation
                                .ville
                            : "",
                    rayon: int.parse("10"),
                    temps: timeController.text,
                    poste: posteController.text,
                    duree: durationController.text,
                    date: dateController.text,
                    horaires: horraires,
                    contrat: _selectedValues,
                  );
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return FiltersButtonBottomSheet(
                          offre: offre,
                        );
                      }).then((value) => value ? Navigator.pop(context) : null);
                }
              },
              // },
              child: FiltersButton(
                text: 'Enregistrer mon offre',
                icon: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        )));
  }
}

class FiltersButton extends StatelessWidget {
  var text;
  var icon;
  FiltersButton({Key? key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(31, 92, 103, 0.17),
              offset: Offset(3, 3),
              blurRadius: 3,
            ),
          ],
          gradient: LinearGradient(colors: [
            Color.fromRGBO(124, 237, 172, 1),
            Color.fromRGBO(66, 210, 255, 1),
          ])),
      width: width * 0.9,
      height: height * 0.065,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon == true
              ? Image(
                  height: height * 0.025,
                  image: const AssetImage(
                    'assets/icons/filterbuttonicon.png',
                  ),
                )
              : Container(),
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            text,
            style: bigWhite,
          ),
        ],
      ),
    );
  }
}

class FiltersButtonBottomSheet extends StatefulWidget {
  final Offre offre;
  FiltersButtonBottomSheet({Key? key, required this.offre}) : super(key: key);

  @override
  State<FiltersButtonBottomSheet> createState() =>
      _FiltersButtonBottomSheetState();
}

class _FiltersButtonBottomSheetState extends State<FiltersButtonBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enregistrer mon offre',
                  style: heading,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Form(
            key: formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: CustomRegistrationTextField(
                padding: 1,
                label: "Nom de l'offre",
                controller: nomController,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          InkWell(
            onTap: () {
              if (formKey.currentState!.validate()) {
                widget.offre.nom = nomController.text;
                BlocProvider.of<OffresBloc>(context)
                    .add(CreateOffre(offre: widget.offre));
                BlocProvider.of<MembresBloc>(context)
                    .add(GetMembres(offre: widget.offre));
                Navigator.pop(context, true);
              }
            },
            child: FiltersButton(
              text: 'Enregistrer mon offre',
              icon: true,
            ),
          ),
        ],
      ),
    );
  }
}
