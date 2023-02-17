import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/bloc/titulaires_bloc.dart';
import 'package:pharmabox/member_registration/lgo_widgets.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:pharmabox/pharmacyProfile/gradientSlider.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyrow.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';

import '../Theme/text.dart';
import '../Widgets/space_values.dart';
import '../model/localisation.dart';
import '../model/telephone.dart';

class ProfilEditPharmacy extends StatefulWidget {
  TextEditingController? pharNameController;
  TextEditingController? pharUserNameController;
  TextEditingController? pharDesController;
  final GlobalKey<FormState> formKey;
  bool? maitre;
  Pharmacie? myPharmacy;

  ProfilEditPharmacy(
      {Key? key,
      required this.formKey,
      this.pharNameController,
      required this.maitre,
      this.pharUserNameController,
      this.pharDesController,
      this.myPharmacy})
      : super(key: key);

  @override
  State<ProfilEditPharmacy> createState() => _ProfilEditPharmacyState();
}

class _ProfilEditPharmacyState extends State<ProfilEditPharmacy> {
  bool nonStop = false;

  late GlobalKey<FormState> formKey11;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey11 = GlobalKey<FormState>();
    if (widget.myPharmacy != null) {
      BlocProvider.of<TitulaireBloc>(context)
          .add(InitialiseTitulaire(titulaires: widget.myPharmacy!.titulaires));
      emailController.text = widget.myPharmacy?.email ?? '';
      phoneController.text =
          widget.myPharmacy?.telephone.numeroTelephone.toString() ?? '';
      addressController.text =
          widget.myPharmacy?.localisation.ville.toString() ?? '';
      rerController.text = widget.myPharmacy?.rer ?? '';
      parkingController.text = widget.myPharmacy?.parking ?? "";
      metroController.text = widget.myPharmacy?.metro ?? '';
      busController.text = widget.myPharmacy?.bus ?? '';
      tramController.text = widget.myPharmacy?.tramway ?? '';
      stationController.text = widget.myPharmacy?.parking ?? '';
      prepaersNumController.text =
          widget.myPharmacy?.nbPreparateurs.toString() ?? '';
      pharmaistsNumController.text =
          widget.myPharmacy?.nbPharmaciens.toString() ?? '';
      nonStop = widget.myPharmacy?.nonStop ?? false;

      typocc = widget.myPharmacy?.centreCommercial ?? false;
      typocv = widget.myPharmacy?.centreVille ?? false;
      typoAero = widget.myPharmacy?.aeroport ?? false;
      typoGare = widget.myPharmacy?.gareTyp ?? false;
      typoQuartier = widget.myPharmacy?.quartier ?? false;
      typoTour = widget.myPharmacy?.touristique ?? false;
      typoRula = widget.myPharmacy?.rurale ?? false;
      noPatientPerDay.text = widget.myPharmacy?.nbPatients.toString() ?? '';

      testCovid = widget.myPharmacy?.testCovid ?? false;
      vaccination = widget.myPharmacy?.vaccination ?? false;
      pMaintaince = widget.myPharmacy?.entretien ?? false;
      pbTeam = widget.myPharmacy?.preparation ?? false;
      tTerminal = widget.myPharmacy?.borneTelemedcine ?? false;

      breakRoom = widget.myPharmacy?.breakRoom ?? false;
      robot = widget.myPharmacy?.robot ?? false;
      eLabels = widget.myPharmacy?.electronicLabels ?? false;
      autoCm = widget.myPharmacy?.automatic ?? false;
      ac = widget.myPharmacy?.airCond ?? false;
      heating = widget.myPharmacy?.heating ?? false;
      vigil = widget.myPharmacy?.vigile ?? false;
    }
  }

  final List<String> confortList = <String>[
    'Break Room',
    'Robot',
    'Electronic labels',
    'Automatic coin mechanism',
    'air conditioning',
    'Heating',
    'Vigile',
  ];
  bool breakRoom = false;
  bool robot = false;
  bool eLabels = false;
  bool autoCm = false;
  bool ac = false;
  bool heating = false;
  bool vigil = false;
  bool workConcil = false;

  final List<Icon> confortIcons = <Icon>[
    const Icon(
      Icons.cruelty_free_outlined,
    ),
    const Icon(
      Icons.smart_toy_outlined,
    ),
    const Icon(
      Icons.qr_code_2_outlined,
    ),
    const Icon(
      Icons.self_improvement_outlined,
    ),
    const Icon(
      Icons.local_police_outlined,
    ),
    const Icon(
      Icons.cottage_outlined,
    ),
    const Icon(
      Icons.airplane_ticket_outlined,
    )
  ];

  final List<String> transport = <String>[
    'RER',
    'Métro',
    'Bus',
    'Tramway',
    'Gare',
    'Parking',
  ];
  final List<String> typologie = <String>[
    'Centre Commercial',
    'Centre ville',
    'Aeroport',
    'Gare',
    'Quartier',
    'Touristique',
    'Rurale',
  ];
  bool typocc = false;
  bool typocv = false;
  bool typoAero = false;
  bool typoGare = false;
  bool typoQuartier = false;
  bool typoTour = false;
  bool typoRula = false;
  final TextEditingController noPatientPerDay = TextEditingController();

  ///mission
  bool testCovid = false;
  bool vaccination = false;
  bool pMaintaince = false;
  bool pbTeam = false;
  bool tTerminal = false;

  final List<dynamic> typologieImage = [
    'assets/icons/Typologie.png',
    'assets/icons/Typologie (1).png',
    'assets/icons/Typologie (2).png',
    'assets/icons/Typologie (3).png',
    'assets/icons/Typologie (4).png',
    'assets/icons/Typologie (5).png',
    'assets/icons/Typologie (6).png',
  ];

  final List<Icon> transportIcon = [
    const Icon(
      Icons.directions_car_outlined,
    ),
    const Icon(
      Icons.subway_outlined,
    ),
    const Icon(
      Icons.directions_bus_outlined,
    ),
    const Icon(
      Icons.tram_outlined,
    ),
    const Icon(
      Icons.directions_railway_outlined,
    ),
    const Icon(
      Icons.local_parking_outlined,
    ),
  ];

  ///editing controllers
  ///team
  final TextEditingController pharmaistsNumController = TextEditingController();
  final TextEditingController prepaersNumController = TextEditingController();

  ///contact
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController rerController = TextEditingController();
  final TextEditingController metroController = TextEditingController();
  final TextEditingController busController = TextEditingController();
  final TextEditingController tramController = TextEditingController();
  final TextEditingController stationController = TextEditingController();
  final TextEditingController parkingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Form(
        key: formKey11,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              height: height * 0.45,
              width: width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
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
                        'Contact pharmacie',
                        style: heading,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomPharmacyTextField(
                    label: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    controller: emailController,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomPharmacyTextField(
                    label: 'Téléphone',
                    prefixIcon: const Icon(Icons.phone),
                    showSuffix: true,
                    controller: phoneController,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomPharmacyTextField(
                    label: 'Préférences contact email',
                    prefixIcon: Icon(Icons.settings),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              height: height * 0.4,
              width: width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
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
              child: Column(children: [
                SizedBox(
                  height: height * 0.015,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      'Localisation',
                      style: heading,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomPharmacyTextField(
                  label: 'Adresse',
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                  ),
                  controller: addressController,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                /*  Container(
                height: height * 0.2,
                width: width * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Maps(),
              )
           */
              ]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              // height: height * 0.55,
              width: width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
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
              child: Column(children: [
                SizedBox(
                  height: height * 0.015,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      'Accessibilité',
                      style: heading,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomPharmacyTextField(
                  label: 'RER',
                  prefixIcon: transportIcon[0],
                  controller: rerController,
                ),
                Spaces.y2,
                CustomPharmacyTextField(
                  label: 'Metro',
                  prefixIcon: transportIcon[1],
                  controller: metroController,
                ),
                Spaces.y2,
                CustomPharmacyTextField(
                  label: 'Bus',
                  prefixIcon: transportIcon[2],
                  controller: busController,
                ),
                Spaces.y2,
                CustomPharmacyTextField(
                  label: 'Tramway',
                  prefixIcon: transportIcon[3],
                  controller: tramController,
                ),
                Spaces.y2,
                CustomPharmacyTextField(
                  label: 'Gare',
                  prefixIcon: transportIcon[4],
                  controller: stationController,
                ),
                Spaces.y2,
                CustomPharmacyTextField(
                  label: 'Parking',
                  prefixIcon: transportIcon[5],
                  controller: addressController,
                ),
                Spaces.y2,
              ]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              height: height * 0.5,
              width: width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
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
                        'Horaire',
                        style: heading,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  PharmacyRow(
                    text: 'Non-stop',
                    image: 'assets/icons/24-7.png',
                    onChanged: (value) {
                      nonStop = value;
                    },
                    initialSwitchValue: nonStop,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.02,
                      ),
                      const CalenderPharmacy(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              height: height * 0.45,
              width: width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
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
                        'Typologie',
                        style: heading,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Column(
                    children: [
                      PharmacyRow(
                        text: typologie[0],
                        image: typologieImage[0],
                        initialSwitchValue: typocc,
                        onChanged: (value) {
                          typocc = value;
                        },
                      ),
                      PharmacyRow(
                        text: typologie[1],
                        image: typologieImage[1],
                        initialSwitchValue: typocv,
                        onChanged: (value) {
                          typocv = value;
                        },
                      ),
                      PharmacyRow(
                        text: typologie[2],
                        image: typologieImage[2],
                        initialSwitchValue: typoAero,
                        onChanged: (value) {
                          typoAero = value;
                        },
                      ),
                      PharmacyRow(
                        text: typologie[3],
                        image: typologieImage[3],
                        initialSwitchValue: typoGare,
                        onChanged: (value) {
                          typoGare = value;
                        },
                      ),
                      PharmacyRow(
                        text: typologie[4],
                        image: typologieImage[4],
                        initialSwitchValue: typoQuartier,
                        onChanged: (value) {
                          typoQuartier = value;
                        },
                      ),
                      PharmacyRow(
                        text: typologie[5],
                        image: typologieImage[5],
                        initialSwitchValue: typoTour,
                        onChanged: (value) {
                          typoTour = value;
                        },
                      ),
                      PharmacyRow(
                        text: typologie[6],
                        image: typologieImage[6],
                        initialSwitchValue: typoRula,
                        onChanged: (value) {
                          typoRula = value;
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomPharmacyTextField(
                    label: 'Nb patients par jour',
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    controller: noPatientPerDay,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              //height: height * 0.32,
              width: width * 0.9,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(31, 92, 103, 0.17),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(children: [
                SizedBox(
                  height: height * 0.015,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      'Missions',
                      style: heading,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Column(children: [
                  PharmacyRow(
                    text: 'Test COVID',
                    image: 'assets/icons/covid.png',
                    initialSwitchValue: testCovid,
                    onChanged: (value) {
                      testCovid = value;
                    },
                  ),
                  PharmacyRow(
                    text: 'Vaccination',
                    image: 'assets/icons/Vaccination.png',
                    initialSwitchValue: vaccination,
                    onChanged: (value) {
                      vaccination = value;
                    },
                  ),
                  PharmacyRow(
                    text: 'Entretien pharmaceutique',
                    image: 'assets/icons/missions (3).png',
                    initialSwitchValue: pMaintaince,
                    onChanged: (value) {
                      pMaintaince = value;
                    },
                  ),
                  PharmacyRow(
                    text: 'Préparation par léquipe',
                    image: 'assets/icons/missions (3).png',
                    initialSwitchValue: pbTeam,
                    onChanged: (value) {
                      pbTeam = value;
                    },
                  ),
                  PharmacyRow(
                    text: 'Borne télémédecine',
                    image: 'assets/icons/missions (1).png',
                    initialSwitchValue: tTerminal,
                    onChanged: (value) {
                      tTerminal = value;
                    },
                  ),
                ])
              ]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            LgoContainer(width: width, height: height),

            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: height * 0.4,
              width: width * 0.9,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(31, 92, 103, 0.17),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(children: [
                SizedBox(
                  height: height * 0.015,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      'Confort',
                      style: heading,
                    ),
                  ],
                ),
                Column(
                  children: [
                    PharmacyRow(
                      text: confortList[0],
                      icon: Icons.cruelty_free_outlined,
                      initialSwitchValue: breakRoom,
                      onChanged: (value) {
                        breakRoom = value;
                      },
                    ),
                    PharmacyRow(
                      text: confortList[1],
                      icon: Icons.smart_toy_outlined,
                      initialSwitchValue: robot,
                      onChanged: (value) {
                        robot = value;
                      },
                    ),
                    PharmacyRow(
                      text: confortList[2],
                      icon: Icons.qr_code_2_outlined,
                      initialSwitchValue: eLabels,
                      onChanged: (value) {
                        eLabels = value;
                      },
                    ),
                    PharmacyRow(
                      text: confortList[3],
                      icon: Icons.self_improvement_outlined,
                      initialSwitchValue: autoCm,
                      onChanged: (value) {
                        autoCm = value;
                      },
                    ),
                    PharmacyRow(
                      text: confortList[4],
                      icon: Icons.local_police_outlined,
                      initialSwitchValue: ac,
                      onChanged: (value) {
                        ac = value;
                      },
                    ),
                    PharmacyRow(
                      text: confortList[5],
                      icon: Icons.cottage_outlined,
                      initialSwitchValue: heating,
                      onChanged: (value) {
                        heating = value;
                      },
                    ),
                    PharmacyRow(
                      text: confortList[6],
                      icon: Icons.airplane_ticket_outlined,
                      initialSwitchValue: vigil,
                      onChanged: (value) {
                        vigil = value;
                      },
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: height * 0.3,
              width: width * 0.9,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(31, 92, 103, 0.17),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(children: [
                SizedBox(
                  height: height * 0.015,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      'Tendance',
                      style: heading,
                    ),
                  ],
                ),
                Flexible(
                  child: Column(children: const [
                    CustomTextWithGradientSliderNoText(
                        title: 'Ordonnances',
                        initialValue: 100,
                        assetImage: 'assets/icons/Tendance (5).png',
                        categoryCount: 3),
                    CustomTextWithGradientSliderNoText(
                        title: 'Cosmétiques',
                        initialValue: 60,
                        assetImage: 'assets/icons/Tendance (4).png',
                        categoryCount: 3),
                    CustomTextWithGradientSliderNoText(
                        title: 'Phyto/aroma',
                        initialValue: 30,
                        assetImage: 'assets/icons/Tendance (3).png',
                        categoryCount: 3),
                    CustomTextWithGradientSliderNoText(
                        title: 'Nutrition',
                        initialValue: 60,
                        assetImage: 'assets/icons/Tendance (2).png',
                        categoryCount: 3),
                    CustomTextWithGradientSliderNoText(
                        title: 'Conseil',
                        initialValue: 100,
                        assetImage: 'assets/icons/Tendance (1).png',
                        categoryCount: 3),
                  ]),
                ),
              ]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: height * 0.3,
              width: width * 0.9,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(31, 92, 103, 0.17),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Text(
                    'Equipe',
                    style: heading,
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Column(
                    children: [
                      CustomPharmacyTextField(
                        label: 'Nombre de pharmaciens',
                        prefixIcon: const Icon(Icons.person),
                        controller: pharmaistsNumController,
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomPharmacyTextField(
                        label: 'Nombre de préparateurs',
                        controller: prepaersNumController,
                        textInputType: TextInputType.number,
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),

            ///register button
            GestureDetector(
              onTap: () {
                if (widget.formKey.currentState!.validate()) {
                  if (formKey11.currentState!.validate()) {
                    print("weeeeeeeeeee");
                    print("alooo" +
                        BlocProvider.of<TitulaireBloc>(context)
                            .titulaires
                            .length
                            .toString());
                    Pharmacie pharmacie = Pharmacie(
                        email: emailController.text,
                        tendances: [],
                        images: [
                          BlocProvider.of<PharmacieBloc>(context).imagePath !=
                                  null
                              ? BlocProvider.of<PharmacieBloc>(context)
                                  .imagePath!
                              : 'https://firebasestorage.googleapis.com/v0/b/pharmabox-effd0.appspot.com/o/pharma_img.png?alt=media&token=9b977de8-d170-4e9e-99de-5cdd3456135e'
                        ],
                        prefEmail: "",
                        parking: parkingController.text,
                        gareAccess: "",
                        lgos: [],
                        maitre: widget.maitre!,
                        telephone: Telephone(
                            numeroTelephone: int.parse(phoneController.text),
                            visible: false),
                        localisation: Localisation(
                            ville: addressController.text, codePostal: 1),
                        rer: rerController.text ?? "",
                        metro: metroController.text ?? "",
                        bus: busController.text ?? "",
                        tramway: tramController.text,
                        nom: widget.pharNameController?.text ?? '',
                        titulaires:
                            BlocProvider.of<TitulaireBloc>(context).titulaires,
                        presentation: widget.pharDesController?.text ?? '',
                        nbPreparateurs: int.parse(prepaersNumController.text),
                        nbPharmaciens: int.parse(pharmaistsNumController.text),
                        nonStop: nonStop,

                        ///typo
                        centreCommercial: typocc,
                        centreVille: typocv,
                        aeroport: typoAero,
                        gareTyp: typoGare,
                        quartier: typoQuartier,
                        touristique: typoTour,
                        rurale: typoRula,
                        nbPatients: int.parse(noPatientPerDay.text),

                        ///mission
                        testCovid: testCovid,
                        vaccination: vaccination,
                        entretien: pMaintaince,
                        preparation: pbTeam,
                        borneTelemedcine: tTerminal,
                        breakRoom: breakRoom,
                        robot: robot,
                        electronicLabels: eLabels,
                        automatic: autoCm,
                        airCond: ac,
                        heating: heating,
                        vigile: vigil);
                    BlocProvider.of<PharmacieBloc>(context)
                        .add(AddPharmacie(pharmacie: pharmacie));
                  }
                } else {
                  /*  controller.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);*/
                  print("okey");
                }
              },
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(66, 210, 255, 1),
                        Color.fromRGBO(124, 237, 172, 1),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.myPharmacy == null ? 'Enregistrer' : 'save'.tr,
                      style: bigWhite,
                    ),
                  )),
            ),
          ],
        ));
  }
}

class CalenderPharmacy extends StatelessWidget {
  const CalenderPharmacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> month = [
      'Mar',
      'Mer',
      'Jeu',
      'Ven',
      'Sam',
    ];
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.14,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
                color: Color.fromRGBO(239, 246, 247, 1),
              ),
              child: const Center(
                child: Text(
                  'Lun',
                  style: TextStyle(
                    color: Color.fromRGBO(89, 90, 113, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Container(
              color: Color.fromRGBO(89, 90, 113, 1),
              width: MediaQuery.of(context).size.width * 0.005,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Color.fromRGBO(231, 237, 237, 1),
                  width: 1.5,
                )),
              ),
              child: Text(
                '   9h - 20h',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(89, 90, 113, 1)),
              ),
            ),
          ],
        ),
        Column(
          children: List.generate(
            5,
            (index) => Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.14,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(239, 246, 247, 1),
                  ),
                  child: Center(
                    child: Text(
                      month[index],
                      style: const TextStyle(
                        color: Color.fromRGBO(89, 90, 113, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromRGBO(89, 90, 113, 1),
                  width: MediaQuery.of(context).size.width * 0.005,
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: Color.fromRGBO(231, 237, 237, 1),
                      width: 1.5,
                    )),
                  ),
                  child: const Text(
                    '   9h - 20h',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(89, 90, 113, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.14,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                color: Color.fromRGBO(239, 246, 247, 1),
              ),
              child: const Center(
                child: Text(
                  'Dim',
                  style: TextStyle(
                    color: Color.fromRGBO(89, 90, 113, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Container(
              color: Color.fromRGBO(89, 90, 113, 1),
              width: MediaQuery.of(context).size.width * 0.005,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Color.fromRGBO(231, 237, 237, 1),
                  width: 1.5,
                )),
              ),
              child: const Text(
                '   Fermé',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(248, 153, 153, 1)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
