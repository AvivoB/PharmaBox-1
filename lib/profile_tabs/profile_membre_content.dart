import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/member_registration/specialisations_widget.dart';

import '../Theme/text.dart';
import '../member_registration/autres_widget.dart';
import '../member_registration/competences_widget.dart';
import '../member_registration/experience_widgets.dart';
import '../member_registration/langues_widgets.dart';
import '../member_registration/lgo_widgets.dart';

class ProfilTabEdit extends StatelessWidget {
  final List<bool> conditions;
  final List<Function(bool)> callbacks;
  const ProfilTabEdit(
      {Key? key, required this.conditions, required this.callbacks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          // UniversiteContainer(height: height, width: width),
          SpecialisationContainer(width: width, height: height),
          LgoContainer(height: height, width: width),
          CompetencesContainer(height: height, width: width),
          LanguesContainer(height: height, width: width),
          ExperiencesContainer(width: width, height: height),
          AutresContainer(
            height: height,
            width: width,
            conditions: conditions,
            callbacks: callbacks,
          ),
          SizedBox(
            height: height * 0.025,
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: height * 0.02,
          ),

          ///register button
          GestureDetector(
            onTap: () async {
              callbacks[2];
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
                    'Enregistrer',
                    style: bigWhite,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
