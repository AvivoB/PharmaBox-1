import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/Home/HomePage.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/constant.dart';
import 'package:pharmabox/general/regTextFieldAjouter.dart';
import 'package:pharmabox/general/widgets/custom_registration_date_picker.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';
import 'package:pharmabox/general/widgets/custom_slider_with_gradient.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';

import 'package:pharmabox/general/widgets/custom_elevated_button.dart';

import '../Widgets/bottomsheet.dart';
import '../Widgets/gradientText.dart';
import '../member_registration/member_registration_screen.dart';

class ProfilTabEdit extends StatelessWidget {
  const ProfilTabEdit({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Faculté ou école',
                      style: heading,
                    ),
                  ),
                  AjouterContainerReg(
                    label: 'Faculté ou école',
                    image: 'assets/icons/universityIcon.png',
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.035,
                  ),
                  Image(
                    image: const AssetImage('assets/icons/deleteicon.png'),
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Image(
                    image: const AssetImage('assets/icons/universityIcon.png'),
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.03,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Spécialisations',
                      style: heading,
                    ),
                  ),
                  AjouterContainerReg(
                    label: 'Spécialisations',
                    image: 'assets/icons/checkIcon.png',
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.035,
                  ),
                  Image(
                    image: const AssetImage('assets/icons/deleteicon.png'),
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Image(
                    image: const AssetImage('assets/icons/checkIcon.png'),
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.03,
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
          height: height * 0.18,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'LGO',
                      style: heading,
                    ),
                  ),
                  AjouterContainerReg(
                    label: 'LGO',
                    image: 'assets/icons/computerIcon.png',
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const CustomTextWithGradientSlider(
                title: 'WinPharma',
                assetImage: 'assets/icons/computerIcon.png',
                initialValue: 60,
                categoryCount: 2,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const CustomTextWithGradientSlider(
                title: 'PharmaLand',
                assetImage: 'assets/icons/computerIcon.png',
                initialValue: 40,
                categoryCount: 2,
              ),
              SizedBox(
                height: height * 0.01,
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          height: height * 0.3,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Image(
                            image: const AssetImage('assets/icons/covid.png'),
                            height: height * 0.025,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            'Test COVID',
                            style: paragraph,
                          ),
                        ],
                      ),
                       Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomSwitch(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Image(
                            image: const AssetImage(
                                'assets/icons/Vaccination.png'),
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
                       Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CustomSwitch(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Image(
                            image:
                                const AssetImage('assets/icons/payantIcon.png'),
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
                       Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CustomSwitch(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Image(
                            image: const AssetImage(
                                'assets/icons/TesttubeIcon.png'),
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
                       Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CustomSwitch(),
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
          height: height * 0.24,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Langues',
                      style: heading,
                    ),
                  ),
                  AjouterContainerReg(
                    label: 'Langues',
                    image: 'assets/icons/worldIcon.png',
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const CustomTextWithGradientSlider(
                title: 'Français',
                assetImage: 'assets/icons/worldIcon.png',
                initialValue: 40,
                categoryCount: 3,
              ),
              SizedBox(height: height * 0.01),
              const CustomTextWithGradientSlider(
                title: 'Anglais',
                assetImage: 'assets/icons/worldIcon.png',
                initialValue: 86,
                categoryCount: 3,
              ),
              SizedBox(height: height * 0.01),
              const CustomTextWithGradientSlider(
                title: 'Allemand',
                assetImage: 'assets/icons/worldIcon.png',
                initialValue: 60,
                categoryCount: 3,
              ),
              SizedBox(height: height * 0.01),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Expériences',
                      style: heading,
                    ),
                  ),
                  AjouterContainerReg(
                    label: 'Expériences',
                    image: 'assets/icons/breifcase.png',
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
                        width: width * 0.035,
                      ),
                      Image(
                        image: const AssetImage('assets/icons/deleteicon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Image(
                        image: const AssetImage('assets/icons/breifcase.png'),
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Pharmacie Centrale, 2019 - 2022',
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
                        width: width * 0.035,
                      ),
                      Image(
                        image: const AssetImage('assets/icons/deleteicon.png'),
                        height: height * 0.025,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Image(
                        image: const AssetImage('assets/icons/breifcase.png'),
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Pharmacie de la Gare, 2016 - 2019',
                        style: paragraph,
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
                    'Autres',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Text(
                            "Je donne le droit à PharmaBox de \nm'envoyer des offres d'emploi",
                            style: paragraph,
                          ),
                        ],
                      ),
                       Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CustomSwitch(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
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
                            "Je suis d'accord avec les\nConditions Générales d'Utilisation",
                            style: paragraph,
                          ),
                        ],
                      ),
                       Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CustomSwitch(),
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
      ],
    );
  }
}
