import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/ContainerAdvisor.dart';
import 'package:pharmabox/mainpages/profil.dart';

import '../Widgets/customAppbar.dart';

class PharmAdvisor extends StatefulWidget {
  const PharmAdvisor({Key? key}) : super(key: key);

  @override
  State<PharmAdvisor> createState() => _PharmAdvisorState();
}

class _PharmAdvisorState extends State<PharmAdvisor> {
  bool transaction = true;
  bool invent = true;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarCustom(),
      backgroundColor: Color.fromRGBO(242, 253, 255, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: width * 0.9,
                height: height * 0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'PharmAdvisor',
                          style: heading,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.11,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(145, 234, 228, 1),
                          Color.fromRGBO(134, 168, 231, 1),
                          Color.fromRGBO(127, 127, 213, 1),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Container(
                        width: width * 0.95,
                        height: height * 0.09,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Recommandez et aidez vos confrères\n faire le bon choix!',
                            textAlign: TextAlign.center,
                            style: headingWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Column(
                children: [
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (2).png', text: 'LGO'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (3).png',
                      text: 'Groupement'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (4).png',
                      text: 'Grossiste répartiteur'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (5).png',
                      text: 'Génériqueur'),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    transaction = !transaction;
                  });
                },
                child: ContainerAdvisor2(
                  icon: transaction == true
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  logo: 'assets/icons/Pharmadvisor (24).png',
                  number: '1',
                  text: 'Transactionnaire',
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              transaction == true
                  ? ExtensionWidget(
                      image: 'assets/icons/extension (1).png',
                      name: 'Winpharma',
                    )
                  : Container(),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    invent = !invent;
                  });
                },
                child: ContainerAdvisor2(
                  icon: invent == true
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  logo: 'assets/icons/Pharmadvisor (23).png',
                  number: '3',
                  text: 'Inventoriste',
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              invent == true
                  ? ExtensionWidget(
                      image: 'assets/icons/extension (2).png',
                      name: 'Stock 12',
                    )
                  : Container(),
              SizedBox(
                height: height * 0.02,
              ),
              invent == true
                  ? ExtensionWidget(
                      image: 'assets/icons/extension (2).png',
                      name: 'Stock 12',
                    )
                  : Container(),
              invent == true
                  ? SizedBox(
                      height: height * 0.02,
                    )
                  : Container(),
              invent == true
                  ? ExtensionWidget(
                      image: 'assets/icons/extension (2).png',
                      name: 'Stock 12',
                    )
                  : Container(),
              invent == true
                  ? SizedBox(
                      height: height * 0.02,
                    )
                  : Container(),
              Column(
                children: [
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (6).png',
                      text: 'Banque'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (7).png',
                      text: 'Enseigniste'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (8).png',
                      text: 'écran dynamique- \ncommunication'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (9).png',
                      text: 'Traitement \nadministratif'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (10).png',
                      text: 'Architecte - \nagenceur'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (11).png',
                      text: 'Destockeurs'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (12).png',
                      text: 'Emballages'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (13).png',
                      text: "Système d'alarme \net Vidéosurveillance"),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (14).png',
                      text: 'Chaine du froid'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (15).png',
                      text: 'Leasing'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (16).png',
                      text: 'Outils statistique'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (17).png',
                      text: 'Concentrateurs de\n factures'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (18).png',
                      text: 'Création de carte \nfidélité'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (19).png',
                      text: 'Porte \nOrdonnance/carte'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (20).png',
                      text: 'Formations'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (21).png',
                      text: 'Maintien à Domicile'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ContainerAdvisor(
                      logo: 'assets/icons/Pharmadvisor (22).png',
                      text: 'Croix de pharmacie'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
