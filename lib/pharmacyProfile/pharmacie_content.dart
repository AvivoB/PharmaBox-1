import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/bloc/titulaires_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/general/widgets/present_field.dart';
import 'package:pharmabox/member_registration/lgo_widgets.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:pharmabox/model/work_hours.dart';
import 'package:pharmabox/pharmacyProfile/gradientSlider.dart';
import 'package:pharmabox/pharmacyProfile/locali_final.dart';
import 'package:pharmabox/pharmacyProfile/localisation_widget.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyrow.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';
import 'package:sizer/sizer.dart';

import '../Theme/text.dart';
import '../Widgets/space_values.dart';
import '../business_logic/lgo_bloc/lgo_bloc.dart';
import '../model/localisation.dart';
import '../model/telephone.dart';
import '../model/tendance.dart';
import '../pharmaJob/bottomsheet.dart';
import 'horraires_ouvreture.dart';
import 'lgo_pharmacie.dart';

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

class _ProfilEditPharmacyState extends State<ProfilEditPharmacy>
    with SingleTickerProviderStateMixin {
  bool nonStop = false;
  List<TextEditingController> equipeController =
      List.generate(6, (index) => TextEditingController());
  List<WorkHours> work_hours = [
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
    WorkHours(
      startDate: const TimeOfDay(hour: 0, minute: 0),
      endDate: const TimeOfDay(hour: 0, minute: 0),
      open: false,
    ),
  ];
  late AnimationController controller;
  GoogleMapController? mapController;
  late Marker marker;

  late GlobalKey<FormState> formKey11;
  @override
  void initState() {
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
      typologieController.text = widget.myPharmacy?.typologie ?? '';
      prepaersNumController.text =
          widget.myPharmacy?.nbPreparateurs.toString() ?? '';
      pharmaistsNumController.text =
          widget.myPharmacy?.nbPharmaciens.toString() ?? '';
      equipeController[0].text =
          widget.myPharmacy?.nbRayonnistes.toString() ?? '';
      equipeController[1].text =
          widget.myPharmacy?.nbConseillers.toString() ?? '';
      equipeController[2].text =
          widget.myPharmacy?.nbApprentis.toString() ?? '';
      equipeController[3].text =
          widget.myPharmacy?.nbEtudiants.toString() ?? '';
      equipeController[4].text =
          widget.myPharmacy?.nbEtudiants6.toString() ?? '';
      nonStop = widget.myPharmacy?.nonStop ?? false;
      work_hours = widget.myPharmacy!.workHours;
      premirere_tendance = widget.myPharmacy!.tendances[0];
      deuxieme_tendance = widget.myPharmacy!.tendances[1];
      troisieme_tendance = widget.myPharmacy!.tendances[2];
      quatrieme_tendance = widget.myPharmacy!.tendances[3];
      cinqieme_tendance = widget.myPharmacy!.tendances[4];

      noPatientPerDay.text = widget.myPharmacy?.nbPatients.toString() ?? '';
      gareController.text = widget.myPharmacy!.gareAccess;
      prefEmailController.text = widget.myPharmacy!.prefEmail;
      testCovid = widget.myPharmacy?.testCovid ?? false;
      vaccination = widget.myPharmacy?.vaccination ?? false;
      pMaintaince = widget.myPharmacy?.entretien ?? false;
      pbTeam = widget.myPharmacy?.preparation ?? false;
      tTerminal = widget.myPharmacy?.borneTelemedcine ?? false;

      breakRoom = widget.myPharmacy?.breakRoom ?? false;
      robot = widget.myPharmacy?.robot ?? false;
      eLabels = widget.myPharmacy?.electronicLabels ?? false;
      monnaie = widget.myPharmacy?.monnaie ?? false;
      climat = widget.myPharmacy?.climat ?? false;
      chauffage = widget.myPharmacy?.chauffage ?? false;
      vigil = widget.myPharmacy?.vigil ?? false;
      workConcil = widget.myPharmacy?.workConcil ?? false;
      typologieController.text = widget.myPharmacy?.typologie ?? "";
      for (int i = 0; i < typologie.length; i++) {
        if (widget.myPharmacy?.typologie == typologie[i]) {
          print(typologieController.text);
          switch (i) {
            case 0:
              typocc = true;
              break;
            case 1:
              typocv = true;
              break;
            case 2:
              typoAero = true;
              break;
            case 3:
              typoGare = true;
              break;
            case 4:
              typoQuartier = true;
              break;
            case 5:
              typoTour = true;
              break;
            case 6:
              typoRula = true;
          }
        }
      }
      controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );

      marker = Marker(
        markerId: const MarkerId("localisation"),
        position: LatLng(46, 2),
      );
    }
  }

  final List<String> confortList = <String>[
    'Salle de pause',
    'Robot',
    'Etiquettes éléctroniques',
    'Monnayeur/caisse classique',
    'Climatisation',
    'Chauffage',
    'Vigile',
    "Comité d'entreprise"
  ];
  Tendance premirere_tendance = Tendance(niveau: 0, nom: "Ordonnances");
  Tendance deuxieme_tendance = Tendance(niveau: 0, nom: "Cosmétiques");
  Tendance troisieme_tendance = Tendance(niveau: 0, nom: "Phyto/aroma");
  Tendance quatrieme_tendance = Tendance(niveau: 0, nom: "Nutrition");
  Tendance cinqieme_tendance = Tendance(niveau: 0, nom: "Conseil");
  bool breakRoom = false;
  bool robot = false;
  bool eLabels = false;
  bool monnaie = false;
  bool climat = false;
  bool chauffage = false;
  bool vigil = false;
  bool workConcil = false;

  final List<IconData> confortIcons = <IconData>[
    Icons.self_improvement_outlined,
    Icons.smart_toy_outlined,
    Icons.qr_code_2_outlined,
    Icons.fax_outlined,
    Icons.ac_unit,
    Icons.wb_sunny_outlined,
    Icons.local_police,
    Icons.groups,
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
  final TextEditingController typologieController = TextEditingController();

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
  final TextEditingController prefEmailController = TextEditingController();
  final TextEditingController gareController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50),
        child: Form(
            key: formKey11,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                        textInputType: TextInputType.phone,
                        controller: phoneController,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Stack(
                        children: [
                          CustomPharmacyTextField(
                            controller: prefEmailController,
                            label: 'Préférences contact',
                            prefixIcon: const Icon(Icons.settings),
                            readOnly: true,
                          ),
                          Positioned(
                            right: 7.w,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: <String>[
                                  'Tous',
                                  'Email uniquement',
                                  'Téléphone uniquement'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                alignment: Alignment.bottomCenter,
                                onChanged: (val) {
                                  prefEmailController.text = val ?? '';
                                },
                              ),
                            ),
                          ),
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
                    Container(
                      width: width * 0.9,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: MainMapProfile(
                        localisationController: addressController,
                        mapController: mapController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: GoogleMap(
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          compassEnabled: true,
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          markers: {
                            Marker(
                              markerId: const MarkerId("localisation"),
                              position: LatLng(46, 2),
                            ),
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(46, 2),
                            zoom: 12.0,
                          )),
                    ),
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
                    PresentField(
                      label: 'RER',
                      prefixIcon: transportIcon[0],
                      controller: rerController,
                    ),
                    Spaces.y2,
                    PresentField(
                      label: 'Metro',
                      prefixIcon: transportIcon[1],
                      controller: metroController,
                    ),
                    Spaces.y2,
                    PresentField(
                      label: 'Bus',
                      prefixIcon: transportIcon[2],
                      controller: busController,
                    ),
                    Spaces.y2,
                    PresentField(
                      label: 'Tramway',
                      prefixIcon: transportIcon[3],
                      controller: tramController,
                    ),
                    Spaces.y2,
                    PresentField(
                      label: 'Gare',
                      prefixIcon: transportIcon[4],
                      controller: gareController,
                    ),
                    Spaces.y2,
                    Stack(
                      children: [
                        PresentField(
                          label: 'Parking',
                          prefixIcon: transportIcon[5],
                          readOnly: true,
                          controller: parkingController,
                        ),
                        Positioned(
                          right: 7.w,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              items: <String>['Gratuit', 'Payant']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              alignment: Alignment.bottomCenter,
                              onChanged: (val) {
                                parkingController.text = val ?? '';
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spaces.y2,
                  ]),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
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
                            'Horaires',
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
                          setState(() {});
                        },
                        initialSwitchValue: nonStop,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Visibility(
                        visible: !nonStop,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.02,
                            ),
                            CalenderPharmacy(
                              workHours: work_hours,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                              typologieController.text = typologie[0];

                              setState(() {
                                typocv = false;
                                typoAero = false;
                                typoGare = false;
                                typoQuartier = false;
                                typoTour = false;
                                typoRula = false;
                              });
                            },
                          ),
                          PharmacyRow(
                            text: typologie[1],
                            image: typologieImage[1],
                            initialSwitchValue: typocv,
                            onChanged: (value) {
                              typocv = value;

                              typologieController.text = typologie[1];

                              setState(() {
                                typocc = false;
                                typoAero = false;
                                typoGare = false;
                                typoQuartier = false;
                                typoTour = false;
                                typoRula = false;
                              });
                            },
                          ),
                          PharmacyRow(
                            text: typologie[2],
                            image: typologieImage[2],
                            initialSwitchValue: typoAero,
                            onChanged: (value) {
                              typoAero = value;
                              typologieController.text = typologie[2];

                              setState(() {
                                typocc = false;
                                typocv = false;
                                typoGare = false;
                                typoQuartier = false;
                                typoTour = false;
                                typoRula = false;
                              });
                            },
                          ),
                          PharmacyRow(
                            text: typologie[3],
                            image: typologieImage[3],
                            initialSwitchValue: typoGare,
                            onChanged: (value) {
                              typoGare = value;
                              typologieController.text = typologie[3];

                              setState(() {
                                typocc = false;
                                typocv = false;
                                typoAero = false;
                                typoQuartier = false;
                                typoTour = false;
                                typoRula = false;
                              });
                            },
                          ),
                          PharmacyRow(
                            text: typologie[4],
                            image: typologieImage[4],
                            initialSwitchValue: typoQuartier,
                            onChanged: (value) {
                              typoQuartier = value;
                              typologieController.text = typologie[4];
                              setState(() {
                                typocc = false;
                                typocv = false;
                                typoAero = false;
                                typoGare = false;
                                typoTour = false;
                                typoRula = false;
                              });
                            },
                          ),
                          PharmacyRow(
                            text: typologie[5],
                            image: typologieImage[5],
                            initialSwitchValue: typoTour,
                            onChanged: (value) {
                              typoTour = value;
                              typologieController.text = typologie[5];
                              setState(() {
                                typocc = false;
                                typocv = false;
                                typoAero = false;
                                typoGare = false;
                                typoQuartier = false;
                                typoRula = false;
                              });
                            },
                          ),
                          PharmacyRow(
                            text: typologie[6],
                            image: typologieImage[6],
                            initialSwitchValue: typoRula,
                            onChanged: (value) {
                              typoRula = value;
                              typologieController.text = typologie[6];

                              setState(() {
                                typocc = false;
                                typocv = false;
                                typoAero = false;
                                typoGare = false;
                                typoQuartier = false;
                                typoTour = false;
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Stack(
                        children: [
                          PresentField(
                            controller: noPatientPerDay,
                            label: 'Nombre de patients par jour',
                            prefixIcon: const Icon(Icons.settings),
                            readOnly: true,
                          ),
                          Positioned(
                            right: 7.w,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: <String>[
                                  '<100',
                                  '100-250',
                                  '250-400',
                                  '>400'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                alignment: Alignment.bottomCenter,
                                onChanged: (val) {
                                  noPatientPerDay.text = val ?? '';
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
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
                //LgoContainer(width: width, height: height),
                LgoPharmacie(),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.all(8),
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
                          icon: confortIcons[0],
                          initialSwitchValue: breakRoom,
                          onChanged: (value) {
                            breakRoom = value;
                          },
                        ),
                        PharmacyRow(
                          text: confortList[1],
                          icon: confortIcons[1],
                          initialSwitchValue: robot,
                          onChanged: (value) {
                            robot = value;
                          },
                        ),
                        PharmacyRow(
                          text: confortList[2],
                          icon: confortIcons[2],
                          initialSwitchValue: eLabels,
                          onChanged: (value) {
                            eLabels = value;
                          },
                        ),
                        PharmacyRow(
                          text: confortList[3],
                          icon: confortIcons[3],
                          initialSwitchValue: monnaie,
                          onChanged: (value) {
                            monnaie = value;
                          },
                        ),
                        PharmacyRow(
                          text: confortList[4],
                          icon: confortIcons[4],
                          initialSwitchValue: climat,
                          onChanged: (value) {
                            climat = value;
                          },
                        ),
                        PharmacyRow(
                          text: confortList[5],
                          icon: confortIcons[5],
                          initialSwitchValue: chauffage,
                          onChanged: (value) {
                            chauffage = value;
                          },
                        ),
                        PharmacyRow(
                          text: confortList[6],
                          icon: confortIcons[6],
                          initialSwitchValue: vigil,
                          onChanged: (value) {
                            vigil = value;
                          },
                        ),
                        PharmacyRow(
                          text: confortList[7],
                          icon: confortIcons[7],
                          initialSwitchValue: workConcil,
                          onChanged: (value) {
                            workConcil = value;
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
                          'Tendances',
                          style: heading,
                        ),
                      ],
                    ),
                    Flexible(
                      child: Column(children: [
                        CustomTextWithGradientSliderNoText(
                            title: 'Ordonnances',
                            tendance: premirere_tendance,
                            assetImage: 'assets/icons/Tendance (5).png',
                            categoryCount: 3),
                        CustomTextWithGradientSliderNoText(
                            title: 'Cosmétiques',
                            tendance: deuxieme_tendance,
                            assetImage: 'assets/icons/Tendance (4).png',
                            categoryCount: 3),
                        CustomTextWithGradientSliderNoText(
                            title: 'Phyto/aroma',
                            tendance: troisieme_tendance,
                            assetImage: 'assets/icons/Tendance (3).png',
                            categoryCount: 3),
                        CustomTextWithGradientSliderNoText(
                            title: 'Nutrition',
                            tendance: quatrieme_tendance,
                            assetImage: 'assets/icons/Tendance (2).png',
                            categoryCount: 3),
                        CustomTextWithGradientSliderNoText(
                            title: 'Conseil',
                            tendance: cinqieme_tendance,
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
                  padding: const EdgeInsets.all(16),
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
                          PresentField(
                            label: 'Nombre de pharmaciens',
                            prefixIcon: const Icon(Icons.person),
                            controller: pharmaistsNumController,
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          PresentField(
                            label: 'Nombre de préparateurs',
                            controller: prepaersNumController,
                            textInputType: TextInputType.number,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          PresentField(
                            label: 'Nombre de rayonnistes',
                            controller: equipeController[0],
                            textInputType: TextInputType.number,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          PresentField(
                            label: 'Nombre de conseillers',
                            controller: equipeController[1],
                            textInputType: TextInputType.number,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          PresentField(
                            label: "Nombre de d'apprentis",
                            controller: equipeController[2],
                            textInputType: TextInputType.number,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          PresentField(
                            label: "Nombre de d'étudiants pharmacie",
                            controller: equipeController[3],
                            textInputType: TextInputType.number,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          PresentField(
                            label: "Nombre de d'étudiants 6éme année",
                            controller: equipeController[4],
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
                        if (BlocProvider.of<PharmacieBloc>(context).lgo == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: const Color(0xFF7CEDAC),
                              content: const Text("Vous devez choisir un LGO!"),
                            ),
                          );
                        } else if (addressController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: const Color(0xFF7CEDAC),
                              content:
                                  const Text("Vous devez choisir une adresse!"),
                            ),
                          );
                        } else {
                          int nbClosed = 0;
                          for (WorkHours hour in work_hours) {
                            if (!hour.open) {
                              nbClosed = nbClosed + 1;
                            }
                          }
                          if (nbClosed == 14 && !nonStop) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: const Color(0xFF7CEDAC),
                                content: const Text(
                                    "Vous devez choisir au moins un horaire de travail!"),
                              ),
                            );
                          } else {
                            if (typologieController.text == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: const Color(0xFF7CEDAC),
                                content: const Text(
                                    "Vous devez choisir une typologie"),
                              ));
                            } else {
                              Pharmacie pharmacie = Pharmacie(
                                id: BlocProvider.of<UsersBlocBloc>(context)
                                    .currentUser!
                                    .id,
                                email: emailController.text,
                                typologie: typologieController.text,
                                workHours: work_hours,
                                lgoImage:
                                    BlocProvider.of<PharmacieBloc>(context)
                                        .lgoImage,
                                lgoName:
                                    BlocProvider.of<PharmacieBloc>(context).lgo,
                                groupementImage:
                                    BlocProvider.of<PharmacieBloc>(context)
                                        .groupementImage,
                                groupementName:
                                    BlocProvider.of<PharmacieBloc>(context)
                                        .groupement,
                                tendances: [
                                  premirere_tendance,
                                  deuxieme_tendance,
                                  troisieme_tendance,
                                  quatrieme_tendance,
                                  cinqieme_tendance
                                ],
                                images: BlocProvider.of<PharmacieBloc>(context)
                                        .images
                                        .isNotEmpty
                                    ? BlocProvider.of<PharmacieBloc>(context)
                                        .images
                                    : [],
                                prefEmail: prefEmailController.text,
                                parking: parkingController.text,
                                gareAccess: gareController.text,
                                monnaie: monnaie,
                                climat: climat,
                                chauffage: chauffage,
                                vigil: vigil,
                                workConcil: workConcil,
                                maitre: widget.maitre!,
                                telephone: Telephone(
                                    numeroTelephone:
                                        int.parse(phoneController.text),
                                    visible: false),
                                localisation: Localisation(
                                    ville: addressController.text,
                                    codePostal: 1),
                                rer: rerController.text,
                                metro: metroController.text,

                                bus: busController.text,
                                tramway: tramController.text,
                                nom: widget.pharNameController?.text ?? '',
                                titulaires:
                                    BlocProvider.of<TitulaireBloc>(context)
                                        .titulaires,
                                presentation:
                                    widget.pharDesController?.text ?? '',
                                nbPreparateurs:
                                    prepaersNumController.text.isNotEmpty
                                        ? int.parse(prepaersNumController.text)
                                        : 0,
                                nbPharmaciens: pharmaistsNumController
                                        .text.isNotEmpty
                                    ? int.parse(pharmaistsNumController.text)
                                    : 0,
                                nbRayonnistes:
                                    equipeController[0].text.isNotEmpty
                                        ? int.parse(equipeController[0].text)
                                        : 0,
                                nbConseillers:
                                    equipeController[1].text.isNotEmpty
                                        ? int.parse(equipeController[1].text)
                                        : 0,
                                nbApprentis: equipeController[2].text.isNotEmpty
                                    ? int.parse(equipeController[2].text)
                                    : 0,
                                nbEtudiants: equipeController[3].text.isNotEmpty
                                    ? int.parse(equipeController[3].text)
                                    : 0,
                                nbEtudiants6:
                                    equipeController[4].text.isNotEmpty
                                        ? int.parse(equipeController[4].text)
                                        : 0,
                                nonStop: nonStop,

                                ///typo

                                nbPatients: noPatientPerDay.text.isNotEmpty
                                    ? noPatientPerDay.text
                                    : "",

                                ///mission
                                testCovid: testCovid,
                                vaccination: vaccination,
                                entretien: pMaintaince,
                                preparation: pbTeam,
                                borneTelemedcine: tTerminal,
                                breakRoom: breakRoom,
                                robot: robot,
                                electronicLabels: eLabels,
                              );
                              BlocProvider.of<PharmacieBloc>(context)
                                  .add(AddPharmacie(pharmacie: pharmacie));
                              if (widget.myPharmacy == null) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Offre d'emploi?"),
                                      content: const Text(
                                          "Voulez vous créer une offre d'emploi?"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Oui'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            showModalBottomSheet(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(25.0),
                                                ),
                                              ),
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) =>
                                                  const FiltersBottomSheet(),
                                            );
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Non'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          }
                        }
                      }
                    } else {
                      /*  controller.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);*/
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
                          widget.myPharmacy == null
                              ? 'Créer la pharmacie'
                              : 'Enregistrer'.tr,
                          style: bigWhite,
                        ),
                      )),
                ),
              ],
            )));
  }
}

class CalenderPharmacy extends StatelessWidget {
  final List<WorkHours> workHours;
  const CalenderPharmacy({Key? key, required this.workHours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> month = [
      'Lun',
      'Mar',
      'Mer',
      'Jeu',
      'Ven',
      'Sam',
      'Dim',
    ];
    return Column(
        children: List.generate(
            7,
            (index) => Row(children: [
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
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Color.fromRGBO(231, 237, 237, 1),
                        width: 1.5,
                      )),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TimeRangePicker(
                            workHours: workHours[index * 2],
                            secondWorkHours: workHours[index * 2 + 1])),
                  ),
                ])));
  }
}
