import 'package:flutter/material.dart';
import 'package:pharmabox/Home/map.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/general/widgets/custom_slider_with_gradient.dart';
import 'package:pharmabox/pharmacyProfile/gradientSlider.dart';
import 'package:pharmabox/pharmacyProfile/pharmacie_content.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyrow.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';

import '../Theme/text.dart';
import '../Widgets/button.dart';
import '../general/widgets/custom_switch_widget.dart';
import '../general/widgets/custom_switch_with_suffix_and_text.dart';
import '../model/tendance.dart';

class PharmacyTabBar extends StatelessWidget {
  const PharmacyTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> confortList = <String>[
      'Crèche d\'entreprise',
      'Robot',
      'Etiquettes electronique',
      'Salle de pause',
      'Vigile',
      'Logement',
      'Frais de déplacement',
    ];

    final List confortIcons = [
      Icons.cruelty_free_outlined,
      Icons.smart_toy_outlined,
      Icons.qr_code_2_outlined,
      Icons.self_improvement_outlined,
      Icons.local_police_outlined,
      Icons.cottage_outlined,
      Icons.airplane_ticket_outlined,
    ];

    final List<String> transport = <String>[
      'Rer B,  Gare d’Aulnay',
      'B104',
      'Gratuit',
    ];
    final List<String> typologie = <String>[
      'Centre Commercial',
      '250 patients par jour',
    ];

    final List<dynamic> typologieImage = [
      'assets/icons/Typologie.png',
      'assets/icons/Typologie (1).png',
    ];

    final List transportIcon = [
      Icons.directions_car_outlined,
      Icons.directions_bus_outlined,
      Icons.local_parking_outlined,
    ];
    Tendance premirere_tendance = Tendance(niveau: 0, nom: "Ordonnances");
    Tendance deuxieme_tendance = Tendance(niveau: 0, nom: "Cosmétiques");
    Tendance troisieme_tendance = Tendance(niveau: 0, nom: "Phyto/aroma");
    Tendance quatrieme_tendance = Tendance(niveau: 0, nom: "Nutrition");
    Tendance cinqieme_tendance = Tendance(niveau: 0, nom: "Conseil");
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.2,
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
                text: 'contact@grandepharmacie.com',
                icon: Icons.email_outlined,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              PharmacyRowWithoutSwitch(
                text: '01 22 51 00 23',
                icon: Icons.phone,
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
            PharmacyRowWithoutSwitch(
              text: '4 Pl. des Étangs, 93600 Aulnay-sous-\nBois, France',
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
              child: Maps(),
            )
          ]),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.22,
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
                  const CalenderPharmacy(
                    workHours: [],
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
          height: height * 0.18,
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
        Container(
          padding: EdgeInsets.all(8),
          height: height * 0.32,
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
              PharmacyRowWithoutSwitch(
                text: 'Test COVID',
                image: 'assets/icons/covid.png',
              ),
              PharmacyRowWithoutSwitch(
                text: 'Vaccination',
                image: 'assets/icons/Vaccination.png',
              ),
              PharmacyRowWithoutSwitch(
                text: 'Entretien pharmaceutique',
                image: 'assets/icons/missions (3).png',
              ),
              PharmacyRowWithoutSwitch(
                text: "Préparation par l'équipe",
                image: 'assets/icons/missions (1).png',
              ),
              PharmacyRowWithoutSwitch(
                text: 'Borne télémédecine',
                image: 'assets/icons/missions (1).png',
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
                          'XXXXXX',
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
          height: height * 0.48,
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
                Text(
                  "2 pharmaciens, 3 préparateurs ",
                  style: normGrey,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        MembersBoxDelete(
          image: 'assets/images/profile 1.png',
          name: 'Isabelle Rettig',
          zip: 'removeDelete',
          text: '94161, Paris',
          icon: Icons.location_on_outlined,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        MembersBoxDelete(
          image: 'assets/images/profile 2.png',
          name: 'Valerie Balague',
          zip: 'removeDelete',
          icon: Icons.location_on_outlined,
          text: '94160, Paris',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        TabBarButton(),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}
