import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmabox/Home/map.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/general/widgets/custom_slider_with_gradient.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:pharmabox/pharmacyProfile/gradientSlider.dart';
import 'package:pharmabox/pharmacyProfile/pharmacie_content.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyrow.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';
import 'package:pharmabox/pharmacyProfile/widgets/calendar_consultation.dart';
import 'package:pharmabox/pharmacyProfile/widgets/gradient_no_switch.dart';
import 'package:pharmabox/utils/map_utils.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as geo;
import '../Theme/text.dart';
import '../Widgets/button.dart';
import '../general/widgets/custom_switch_widget.dart';
import '../general/widgets/custom_switch_with_suffix_and_text.dart';
import '../model/tendance.dart';

class PharmacyTabBar extends StatefulWidget {
  Pharmacie pharmacie;
  PharmacyTabBar({Key? key, required this.pharmacie}) : super(key: key);

  @override
  State<PharmacyTabBar> createState() => _PharmacyTabBarState();
}

class _PharmacyTabBarState extends State<PharmacyTabBar> {
  final List<String> confortList = [];
  late geo.LatLng lc;

  final List confortIcons = [
    Icons.cruelty_free_outlined,
    Icons.smart_toy_outlined,
    Icons.qr_code_2_outlined,
    Icons.self_improvement_outlined,
    Icons.local_police_outlined,
    Icons.cottage_outlined,
    Icons.airplane_ticket_outlined,
  ];

  final List<dynamic> typologieImage = [
    'assets/icons/Typologie.png',
    'assets/icons/Typologie (1).png',
  ];

  final List transportIcon = [
    Icons.directions_car_outlined,
    Icons.directions_bus_outlined,
    Icons.directions_car_outlined,
    Icons.directions_car_outlined,
    Icons.local_parking_outlined,
  ];
  Tendance premirere_tendance = Tendance(niveau: 0, nom: "Ordonnances");
  Tendance deuxieme_tendance = Tendance(niveau: 0, nom: "Cosmétiques");
  Tendance troisieme_tendance = Tendance(niveau: 0, nom: "Phyto/aroma");
  Tendance quatrieme_tendance = Tendance(niveau: 0, nom: "Nutrition");
  Tendance cinqieme_tendance = Tendance(niveau: 0, nom: "Conseil");

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      lc = await MapUtils.getLocationFromAddress(
          widget.pharmacie.localisation.ville);
    });
    if (widget.pharmacie.robot) {
      confortList.add('Robot');
    }
    if (widget.pharmacie.electronicLabels) {
      confortList.add('Etiquettes electronique');
    }
    if (widget.pharmacie.vigile) {
      confortList.add('Vigile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> transport = <String>[
      widget.pharmacie.rer,
      widget.pharmacie.bus,
      widget.pharmacie.metro,
      widget.pharmacie.tramway,
      widget.pharmacie.parking,
    ];
    final List<String> typologie = <String>[
      'Centre Commercial',
      '${widget.pharmacie.nbPatients} par jour',
    ];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
          // height: height * 0.2,
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
              PharmacyRowWithoutSwitch(
                text: widget.pharmacie.email,
                icon: Icons.email_outlined,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              PharmacyRowWithoutSwitch(
                text: widget.pharmacie.telephone.numeroTelephone.toString(),
                icon: Icons.phone,
              ),
            ],
          ),
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
                  'Situation Géographique',
                  style: heading,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            PharmacyRowWithoutSwitch(
              text: widget.pharmacie.localisation.ville,
              icon: Icons.location_on_outlined,
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
              child: Maps(
                latLng: geo.LatLng(lat: 46, lng: 2),
              ), //latLng: lc),
            )
          ]),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        (transport[0] != "" ||
                transport[1] != "" ||
                transport[2] != "" ||
                transport[3] != "" ||
                transport[4] != "")
            ? Container(
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
                  Column(
                    children: List.generate(
                      transport.length,
                      (index) => PharmacyRowWithoutSwitch(
                        text: transport[index],
                        icon: transportIcon[index],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ]),
              )
            : const SizedBox(),
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
                    'Horaire',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.02,
                  ),
                  ConsultationCalendar(
                    workHours: widget.pharmacie.workHours,
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
                    'Typologie',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Column(
                children: List.generate(
                  typologie.length,
                  (index) => PharmacyRowWithoutSwitch(
                    text: typologie[index],
                    image: typologieImage[index],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        (widget.pharmacie.testCovid ||
                widget.pharmacie.vaccination ||
                widget.pharmacie.borneTelemedcine ||
                widget.pharmacie.entretien ||
                widget.pharmacie.preparation)
            ? Container(
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
                    widget.pharmacie.testCovid
                        ? PharmacyRowWithoutSwitch(
                            text: 'Test COVID',
                            image: 'assets/icons/covid.png',
                          )
                        : const SizedBox(),
                    widget.pharmacie.vaccination
                        ? PharmacyRowWithoutSwitch(
                            text: 'Vaccination',
                            image: 'assets/icons/Vaccination.png',
                          )
                        : const SizedBox(),
                    widget.pharmacie.entretien
                        ? PharmacyRowWithoutSwitch(
                            text: 'Entretien pharmaceutique',
                            image: 'assets/icons/missions (3).png',
                          )
                        : const SizedBox(),
                    widget.pharmacie.preparation
                        ? PharmacyRowWithoutSwitch(
                            text: "Préparation par l'équipe",
                            image: 'assets/icons/missions (1).png',
                          )
                        : const SizedBox(),
                    widget.pharmacie.borneTelemedcine
                        ? PharmacyRowWithoutSwitch(
                            text: 'Borne télémédecine',
                            image: 'assets/icons/missions (1).png',
                          )
                        : const SizedBox(),
                  ])
                ]),
              )
            : const SizedBox(),
        SizedBox(
          height: height * 0.02,
        ),
        widget.pharmacie.lgoName.isNotEmpty
            ? Container(
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
                   /* Row(
                      children: List.generate(
                        widget.pharmacie.lgos.length,
                        (index) =>
                            LgoItem(text: widget.pharmacie.lgos[index].nom),
                      ),
                    ),*/
                  ],
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: height * 0.02,
        ),
        confortList.isNotEmpty
            ? Container(
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
                        'Confort',
                        style: heading,
                      ),
                    ],
                  ),
                  Column(
                    children: confortList.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: PharmacyRowWithoutSwitch(
                          text: confortList[confortList.indexOf(e)],
                          icon: confortIcons[confortList.indexOf(e)],
                        ),
                      );
                    }).toList(),
                  ),
                ]),
              )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          height: height * 0.25,
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
              child: Column(children: [
                GradientNoSwitch(
                    title: 'Ordonnances',
                    tendance: widget.pharmacie.tendances[0],
                    assetImage: 'assets/icons/Tendance (5).png',
                    categoryCount: 3),
                GradientNoSwitch(
                    title: 'Cosmétiques',
                    tendance: widget.pharmacie.tendances[1],
                    assetImage: 'assets/icons/Tendance (4).png',
                    categoryCount: 3),
                GradientNoSwitch(
                    title: 'Phyto/aroma',
                    tendance: widget.pharmacie.tendances[3],
                    assetImage: 'assets/icons/Tendance (3).png',
                    categoryCount: 3),
                GradientNoSwitch(
                    title: 'Nutrition',
                    tendance: widget.pharmacie.tendances[4],
                    assetImage: 'assets/icons/Tendance (2).png',
                    categoryCount: 3),
              ]),
            ),
          ]),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Equipe',
                  style: heading,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${widget.pharmacie.nbPharmaciens} pharmaciens, ${widget.pharmacie.nbPreparateurs} préparateurs ",
                  style: normGrey,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        const TabBarButton(),
      ],
    );
  }
}

class LgoItem extends StatelessWidget {
  final String text;
  const LgoItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            text,
            style: const TextStyle(
              color: Color.fromRGBO(89, 90, 112, 1),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
