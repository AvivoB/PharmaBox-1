import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/member_registration/specialisations_widget.dart';

import '../member_registration/autres_widget.dart';
import '../member_registration/competences_widget.dart';
import '../member_registration/experience_widgets.dart';
import '../member_registration/langues_widgets.dart';
import '../member_registration/lgo_widgets.dart';
import '../member_registration/universite_widgets.dart';

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
    return Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        UniversiteContainer(height: height, width: width),
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
      ],
    );
  }
}
