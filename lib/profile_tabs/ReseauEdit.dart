import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/button.dart';

import '../Widgets/countContainer.dart';
import '../Widgets/jobsbox.dart';
import '../Widgets/membersBox.dart';
import '../Widgets/pharmaciesbox.dart';

class ReseauEdit extends StatelessWidget {
  const ReseauEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        CountContainer(
          count: 1,
          text: 'Membres titulaires',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        MembersBoxDelete(
          image: 'assets/images/profile 3.png',
          name: 'Arnaud Roche',
          text: "Grande Pharmacie\n D'Aulnay, 94160,\n Paris",
          icon: Icons.local_hospital,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        CountContainer(
          count: 1,
          text: 'Membres titulaires',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        MembersBoxDelete(
          image: 'assets/images/profile 1.png',
          name: 'Isabelle Rettig',
          text: '94161, Paris',
          icon: Icons.location_on_outlined,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        MembersBoxDelete(
          image: 'assets/images/profile 2.png',
          name: 'Valerie Balague',
          icon: Icons.location_on_outlined,
          text: '94160, Paris',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        CountContainer(
          count: 2,
          text: 'Pharmacies',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        PharmaciesBox(
          zip: '75016',
          pharm: "Grande Pharmacie D'Aulnay",
          
          imagePharm: 'assets/images/pharmacy 1.png',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        PharmaciesBox(
          zip: '94160',
          pharm: "Citypharma",
          imagePharm: 'assets/images/pharmacy 2.png',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        const TabBarButton(),
      ],
    );
  }
}
