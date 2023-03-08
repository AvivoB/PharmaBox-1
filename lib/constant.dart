import 'package:flutter/material.dart';

const LinearGradient kLinearAppBarGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[
    Color.fromRGBO(127, 127, 213, 1),
    Color.fromRGBO(145, 234, 228, 1),
  ],
);

const String kLeftChatMessage =
    'Hello, je recherche un poste de pharmacie, j’aimerais travailler uniquement le samedi et dimanche';
const String kRightChatMessage =
    'Bonjour Isabelle, votre profil m’intéresse, en effet je recherche quelqu’un qui serait disponible le samedi et dimanche.';

const LinearGradient kTabBarIndicatorGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[
    Color.fromRGBO(124, 237, 172, 1),
    Color.fromRGBO(66, 210, 255, 1)
  ],
);

const Color kUnSelectedIndicatorColor = Color.fromRGBO(95, 96, 119, 1);

const Color kSelectedIndicatorColor = Color(0xfF161730);
const String kRegistrationScreenHeaderText =
    'Les profils avec photo ont 80% de vues en plus';
