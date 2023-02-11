import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/Widgets/utility.dart';
import 'package:pharmabox/pharmacyProfile/gradientSlider.dart';
import 'package:pharmabox/pharmacyProfile/pharmacy_controller.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyrow.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';
import 'package:sizer/sizer.dart';

import '../Home/search_place.dart';
import '../Theme/text.dart';
import '../Widgets/color_constants.dart';
import '../Widgets/space_values.dart';
import '../model/pharmacy_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gmap;

class ProfilEditPharmacy extends StatelessWidget {
  TextEditingController? pharNameController;
  TextEditingController? pharUserNameController;
  TextEditingController? pharDesController;
  PharmacyModel? myPharmacy;
  bool nonStop = false;

  var placeText = ''.obs;

  ProfilEditPharmacy(
      {Key? key,
      this.pharNameController,
      this.pharUserNameController,
      this.pharDesController,
      this.myPharmacy})
      : super(key: key);

  PharmacyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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

    bool nonStop = false;

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

    var searchedItem = <AutocompletePrediction>[].obs;
    final List<PlaceField> _placeFields = [
      PlaceField.Location,
      PlaceField.Name,
    ];
    GoogleMapController? googleMapController;

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

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final places = FlutterGooglePlacesSdk(kGoogleApiKey);

    ///editing controllers
    ///team
    final TextEditingController pharmaistsNumController =
        TextEditingController();
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

    if (myPharmacy != null) {
      emailController.text = myPharmacy?.email ?? '';
      phoneController.text = myPharmacy?.phone ?? '';
      addressController.text = myPharmacy?.address ?? '';
      rerController.text = myPharmacy?.rer ?? '';
      metroController.text = myPharmacy?.metro ?? '';
      busController.text = myPharmacy?.bus ?? '';
      tramController.text = myPharmacy?.tram ?? '';
      stationController.text = myPharmacy?.station ?? '';
      prepaersNumController.text = myPharmacy?.preparersCount ?? '';
      pharmaistsNumController.text = myPharmacy?.pharmacistsCount ?? '';
      nonStop = myPharmacy?.nonStop ?? false;

      typocc = myPharmacy?.typocc ?? false;
      typocv = myPharmacy?.typocv ?? false;
      typoAero = myPharmacy?.typoAero ?? false;
      typoGare = myPharmacy?.typoGare ?? false;
      typoQuartier = myPharmacy?.typoQuartier ?? false;
      typoTour = myPharmacy?.typoTour ?? false;
      typoRula = myPharmacy?.typoRula ?? false;
      noPatientPerDay.text = myPharmacy?.noPatientPerDay ?? '';

      testCovid = myPharmacy?.testCovid ?? false;
      vaccination = myPharmacy?.vaccination ?? false;
      pMaintaince = myPharmacy?.pMaintaince ?? false;
      pbTeam = myPharmacy?.pbTeam ?? false;
      tTerminal = myPharmacy?.tTerminal ?? false;

      breakRoom = myPharmacy?.breakRoom ?? false;
      robot = myPharmacy?.robot ?? false;
      eLabels = myPharmacy?.eLabels ?? false;
      autoCm = myPharmacy?.autoCm ?? false;
      ac = myPharmacy?.ac ?? false;
      heating = myPharmacy?.heating ?? false;
      vigil = myPharmacy?.vigil ?? false;
      workConcil = myPharmacy?.workConcil ?? false;
    }

    return Column(
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
                prefixIcon: Icon(Icons.email_outlined),
                controller: emailController,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomPharmacyTextField(
                label: 'Téléphone',
                prefixIcon: Icon(Icons.phone),
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
              SizedBox(
                height: height * 0.02,
              ),
              CustomPharmacyTextField(
                label: 'Préférences contact téléphone',
                prefixIcon: Icon(Icons.settings),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),

        //localisation
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          //height: height * 0.4,
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
          child: Stack(
            children: [
              Column(children: [
                SizedBox(
                  height: height * 0.015,
                ),

                //title
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
                // GestureDetector(
                //   onTap: () async {
                //     _navigateAndRefresh();
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color:  Colors.black87,
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     width: width * 0.8,
                //     child: Row(
                //       children: [
                //         const Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: Icon(
                //             Icons.location_on_outlined,
                //             size: 25,
                //             color: Color.fromRGBO(208, 209, 222, 1),
                //           ),
                //         ),
                //         Obx(() {
                //           return Text(placeText.value);
                //         })
                //
                //       ],
                //     ),
                //   ),
                //
                // ),

                CustomPharmacyTextField(
                  label: 'Adresse',
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                  ),
                  onTextChange: (val) async {
                    if (val.isNotEmpty) {
                      final predictions =
                      await places.findAutocompletePredictions(val);
                      print('Result: $predictions');
                      searchedItem.clear();
                      searchedItem.addAll(predictions.predictions);
                    }
                    else {
                      searchedItem.clear();
                    }

                  },
                  controller: addressController,
                  textInputType: TextInputType.none,
                ),

                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.2,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: GoogleMap(
                      onMapCreated: (controller){
                        googleMapController = controller;
                      },
                      compassEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,

                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: Gmap.LatLng(45.521563, -122.677433),
                        zoom: 12.0,
                      )
                  ),
                ),

                Spaces.y2,
              ]),

              //suggestion view
              Obx(() {
                return Visibility(
                    visible: searchedItem.isNotEmpty,
                    child: Container(
                        height: 22.h,
                        margin: EdgeInsets.only(top: 14.h),
                        width: double.maxFinite,
                        decoration: BoxDecoration(color: Colors.white),
                        child: ListView.builder(
                            itemCount: searchedItem.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  var res = await places.fetchPlace(
                                      searchedItem[index].placeId,
                                      fields: _placeFields);
                                  addressController.text =
                                      res.place?.name ?? '';
                                  var latLng = Gmap.LatLng(res.place?.latLng?.lat ?? 0.0, res.place?.latLng?.lng ?? 0.0);
                                  googleMapController?.animateCamera(CameraUpdate.newLatLng(latLng));

                                  searchedItem.clear();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstants.grayLevel15),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 0.5.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 0.5.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(searchedItem[index].primaryText),
                                      Text(
                                        searchedItem[index].secondaryText,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })));
              }),
            ],
          ),
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
            // Column(
            //   children: List.generate(
            //     transport.length,
            //     (index) => CustomPharmacyTextField(
            //       label: transport[index],
            //       prefixIcon: transportIcon[index],
            //     ),
            //   ),
            // ),
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
          //height: height * 0.45,
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
                // children: List.generate(
                //   typologie.length,
                //   (index) => PharmacyRow(
                //     text: typologie[index],
                //     image: typologieImage[index],
                //   ),
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
          padding: EdgeInsets.all(8),
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
        Container(
          padding: EdgeInsets.all(8),
          height: height * 0.15,
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
            children: [
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  ModifierContainer(),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(
                          Icons.computer,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          'WindPharma',
                          style: const TextStyle(
                            color: Color.fromRGBO(89, 90, 112, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
              // children: confortList.map((e) {
              //   return Padding(
              //     padding: const EdgeInsets.only(top: 10),
              //     child: CustomSwitchWithIconAndText(
              //       text: confortList[confortList.indexOf(e)],
              //       icon: confortIcons[confortList.indexOf(e)],
              //     ),
              //   );
              // }).toList(),
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

                // PharmacyRow(
                //   text: confortList[7],
                //   image: confortIcons[7],
                //   initialSwitchValue: workConcil,
                //   onChanged: (value) {
                //     workConcil = value;
                //   },
                // ),
              ],
            ),
          ]),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          padding: EdgeInsets.all(8),
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
          padding: EdgeInsets.all(8),
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
            children: [
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Text(
                        'Equipe',
                        style: heading,
                      ),
                    ],
                  ),
                  // Image(
                  //     height: height * 0.06,
                  //     image: AssetImage(
                  //       'assets/images/Button Add.png',
                  //     )),
                ],
              ),
              Column(
                children: [
                  CustomPharmacyTextField(
                    label: 'Nombre de pharmaciens',
                    prefixIcon: Icon(Icons.person),
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
                    prefixIcon: Icon(Icons.person),
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
            if ((pharNameController?.text ?? '').isEmpty) {
              Utility.showSnack('alert'.tr, 'add_pharmacy_name'.tr);
              return;
            }

            if (emailController.text.isEmpty) {
              Utility.showSnack('alert'.tr, 'add_pharmacy_email'.tr);
              return;
            }
            if (phoneController.text.isEmpty) {
              Utility.showSnack('alert'.tr, 'add_pharmacy_phone'.tr);
              return;
            }

            if (addressController.text.isEmpty) {
              Utility.showSnack('alert'.tr, 'add_pharmacy_address'.tr);
              return;
            }

            var pharModel = PharmacyModel();
            pharModel.email = emailController.text;
            pharModel.phone = phoneController.text;
            pharModel.address = addressController.text;
            pharModel.rer = rerController.text;
            pharModel.metro = metroController.text;
            pharModel.bus = busController.text;
            pharModel.tram = tramController.text;
            pharModel.pharName = pharNameController?.text ?? '';
            pharModel.userName = pharUserNameController?.text ?? '';
            pharModel.des = pharDesController?.text ?? '';
            pharModel.preparersCount = prepaersNumController.text ?? '';
            pharModel.pharmacistsCount = pharmaistsNumController.text ?? '';
            pharModel.nonStop = nonStop;

            ///typo
            pharModel.typocc = typocc;
            pharModel.typocv = typocv;
            pharModel.typoAero = typoAero;
            pharModel.typoGare = typoGare;
            pharModel.typoQuartier = typoQuartier;
            pharModel.typoTour = typoTour;
            pharModel.typoRula = typoRula;
            pharModel.noPatientPerDay = noPatientPerDay.text ?? '';

            ///mission
            pharModel.testCovid = testCovid;
            pharModel.vaccination = vaccination;
            pharModel.pMaintaince = pMaintaince;
            pharModel.pbTeam = pbTeam;
            pharModel.tTerminal = tTerminal;

            pharModel.breakRoom = breakRoom;
            pharModel.robot = robot;
            pharModel.eLabels = eLabels;
            pharModel.autoCm = autoCm;
            pharModel.ac = ac;
            pharModel.heating = heating;
            pharModel.vigil = vigil;

            if (myPharmacy == null) {
              controller.createOrUpdatePharmacy(pharModel, null);
            } else {
              controller.createOrUpdatePharmacy(pharModel, myPharmacy?.id);
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
                  myPharmacy == null ? 'Enregistrer' : 'save'.tr,
                  style: bigWhite,
                ),
              )),
        ),
      ],
    );
  }

  void _navigateAndRefresh() async {
    final result = await Get.to(() => AutoCompleteSearch());
    if (result != null) {
      var place = result as Place?;

      if (place != null && place.latLng != null) {
        placeText.value = place.name ?? '';

        //latLng = Gmap.LatLng(place.latLng?.lat ?? 0.0, place.latLng?.lng ?? 0.0);
        //widget.googleMapController?.animateCamera(CameraUpdate.newLatLng(latLng!));

      }

      // setState(() {
      //   placeText = place?.name ?? '';
      //
      // });

    }
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
              child: Text(
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
