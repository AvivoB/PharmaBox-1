import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/button.dart';
import 'package:pharmabox/Widgets/gradientText.dart';

import '../Widgets/countContainer.dart';
import '../Widgets/jobsbox.dart';

class ProfilTab extends StatelessWidget {
  const ProfilTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.12,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
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
                    'Faculté ou école',
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
                    width: width * 0.05,
                  ),
                  Image(
                    image: AssetImage('assets/icons/universityIcon.png'),
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.015,
                  ),
                  Text(
                    'Université de Paris',
                    style: paragraph,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.12,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
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
                    'Spécialisations',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Image(
                    image: AssetImage('assets/icons/checkIcon.png'),
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text(
                    'Homéopathie',
                    style: paragraph,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.17,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
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
                    'LGO',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/computerIcon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Text(
                        'WinPharma',
                        style: paragraph,
                      ),
                      SizedBox(
                        width: width * 0.2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GradientText(
                                'Maitrise complète',
                                style: smallWhite,
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(66, 210, 255, 1),
                                    Color.fromRGBO(124, 237, 172, 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: height * 0.004,
                            width: width * 0.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(66, 210, 255, 1),
                                  Color.fromRGBO(124, 237, 172, 1),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/computerIcon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Text(
                        'WinPharmaLand',
                        style: paragraph,
                      ),
                      SizedBox(
                        width: width * 0.122,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GradientText(
                                'Moyen',
                                style: smallWhite,
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(253, 197, 133, 1),
                                    Color.fromRGBO(255, 244, 146, 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: height * 0.004,
                                width: width * 0.15,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(253, 197, 133, 1),
                                      Color.fromRGBO(255, 244, 146, 1),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.004,
                                width: width * 0.15,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(239, 246, 247, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.28,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
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
                    'Compétences',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/covid.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Test  COVID',
                        style: paragraph,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/Vaccination.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Vaccination',
                        style: paragraph,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/payantIcon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Gestion du tiers payant',
                        style: paragraph,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/TesttubeIcon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.025,
                      ),
                      Text(
                        'Gestion des labos',
                        style: paragraph,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.22,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
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
                    'Langues',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/worldIcon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Français',
                        style: paragraph,
                      ),
                      SizedBox(
                        width: width * 0.21,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GradientText(
                                'Couramment',
                                style: smallWhite,
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(66, 210, 255, 1),
                                    Color.fromRGBO(124, 237, 172, 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: height * 0.004,
                            width: width * 0.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(66, 210, 255, 1),
                                  Color.fromRGBO(124, 237, 172, 1),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/worldIcon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Anglais',
                        style: paragraph,
                      ),
                      SizedBox(
                        width: width * 0.22,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GradientText(
                                'Intérmédiaire',
                                style: smallWhite,
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(253, 197, 133, 1),
                                    Color.fromRGBO(255, 244, 146, 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: height * 0.004,
                                width: width * 0.15,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(253, 197, 133, 1),
                                      Color.fromRGBO(255, 244, 146, 1),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.004,
                                width: width * 0.15,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(239, 246, 247, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Image(
                        image: AssetImage('assets/icons/worldIcon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Allemand',
                        style: paragraph,
                      ),
                      SizedBox(
                        width: width * 0.2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GradientText(
                                'Basique',
                                style: smallWhite,
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(248, 153, 153, 1),
                                    Color.fromRGBO(255, 222, 172, 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: height * 0.004,
                                width: width * 0.05,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(248, 153, 153, 1),
                                      Color.fromRGBO(255, 222, 172, 1),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.004,
                                width: width * 0.25,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(239, 246, 247, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        CountContainer(
          count: 3,
          text: 'Expériences',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        JobBox(
          zip: '75016',
          pharm: "Grande Pharmacie D'Aulnay",
          imagePharm: 'assets/images/pharmacy 1.png',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.1,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
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
                    width: width * 0.015,
                  ),
                  Text(
                    'Pharmacie Centrale',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.015,
                  ),
                  Text(
                    '2019 - 2022',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
          height: height * 0.1,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
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
                    width: width * 0.015,
                  ),
                  Text(
                    'Pharmacie de la Gare',
                    style: heading,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.015,
                  ),
                  const Text(
                    '2016 - 2019',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        TabBarButton(),
        SizedBox(
          height: height * 0.015,
        ),
      ],
    );
  }
}
