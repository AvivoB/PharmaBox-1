import 'package:flutter/material.dart';
import 'package:pharmabox/Widgets/button.dart';

import '../Widgets/ContainerAdvisor.dart';

class AdvisorTabEdit extends StatefulWidget {
  const AdvisorTabEdit({Key? key}) : super(key: key);

  @override
  State<AdvisorTabEdit> createState() => _AdvisorTabEditState();
}

class _AdvisorTabEditState extends State<AdvisorTabEdit> {
  bool invent = true;
  bool transaction = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        ContainerAdvisor(
            logo: 'assets/icons/Pharmadvisor (2).png', text: 'LGO'),
        SizedBox(
          height: height * 0.02,
        ),
        ContainerAdvisor(
            logo: 'assets/icons/Pharmadvisor (3).png', text: 'Groupement'),
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
            logo: 'assets/icons/Pharmadvisor (5).png', text: 'Génériqueur'),
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
        ContainerAdvisor(
            logo: 'assets/icons/Pharmadvisor (6).png', text: 'Banque'),
        SizedBox(
          height: height * 0.02,
        ),
        ContainerAdvisor(
            logo: 'assets/icons/Pharmadvisor (7).png', text: 'Enseigniste'),
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
            text: 'Architecte - agenceur'),
        SizedBox(
          height: height * 0.02,
        ),
        ContainerAdvisor(
            logo: 'assets/icons/Pharmadvisor (11).png', text: 'Destockeurs'),
        SizedBox(
          height: height * 0.02,
        ),
        ContainerAdvisor(
            logo: 'assets/icons/Pharmadvisor (12).png', text: 'Emballages'),
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
            logo: 'assets/icons/Pharmadvisor (15).png', text: 'Leasing'),
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
            text: 'Concentrateurs de\nfactures'),
        SizedBox(
          height: height * 0.02,
        ),
        ContainerAdvisor(
            logo: 'assets/icons/Pharmadvisor (18).png',
            text: 'Création de \ncarte fidélité'),
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
            logo: 'assets/icons/Pharmadvisor (20).png', text: 'Formations'),
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
    );
  }
}
