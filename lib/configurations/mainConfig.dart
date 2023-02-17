import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/membersBox.dart';

import '../Widgets/bottomsheet.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../general/widgets/custom_switch_widget.dart';
import '../general/widgets/custom_switch_with_suffix_and_text.dart';

class Configuration extends StatelessWidget {
  const Configuration({Key? key}) : super(key: key);

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

    final List<Icon> confortIcons = <Icon>[
      const Icon(
        Icons.cruelty_free_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.smart_toy_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.qr_code_2_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.self_improvement_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.local_police_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.cottage_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.airplane_ticket_outlined,
      )
    ];

    final List<String> transport = <String>[
      'RER',
      'Métro',
      'Bus',
      'Tramway',
      'Gare',
      'Parking',
    ];
    final List<String> profileMembreName = <String>[
      'Nom',
      'Prénom',
      'Poste',
      'Email',
      'Nouveau mot de passe',
      'Confirmation mot de passe',
      'Date de naissance',
      'Téléphone',
    ];

    final List<Icon> profileMembreIcon = [
      const Icon(
        Icons.person,
        color: Colors.black,
      ),
      const Icon(
        Icons.person,
        color: Colors.black,
      ),
      const Icon(
        Icons.shopping_bag_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.email_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.lock_outline,
        color: Colors.black,
      ),
      const Icon(
        Icons.lock_outline,
        color: Colors.black,
      ),
      const Icon(
        Icons.cake,
        color: Colors.black,
      ),
      const Icon(
        Icons.phone,
        color: Colors.black,
      ),
    ];

    final List<String> recherchesName = [
      'Lieu de job ',
      'Pharmacien adjoint',
      'Date publication',
      'Contrat',
      "Crèche d'entreprise",
      'Frais de déplacement',
      'Tickets restaurant',
      'Logement',
      'Semaines paires et impaires \nidentiques',
    ];

    final List<Icon> recherchesIcon = [
      const Icon(
        Icons.location_on_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.shopping_bag_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.calendar_today_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.file_copy,
        color: Colors.black,
      ),
      const Icon(
        Icons.cruelty_free_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.airplane_ticket_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.restaurant,
        color: Colors.black,
      ),
      const Icon(
        Icons.cottage_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.calendar_month_outlined,
        color: Colors.black,
      ),
    ];

    final List<Icon> transportIcon = [
      const Icon(
        Icons.directions_car_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.subway_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.directions_bus_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.tram_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.directions_railway_outlined,
        color: Colors.black,
      ),
      const Icon(
        Icons.local_parking_outlined,
        color: Colors.black,
      ),
    ];

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 246, 247, 1),
      body: Center(
        child: SizedBox(
          width: width * 0.9,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  fit: BoxFit.fitWidth,
                                  image: const AssetImage(
                                      'assets/images/backButton.png'),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Configurations',
                            style: heading,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Image(
                              width: MediaQuery.of(context).size.width * 0.12,
                              image: const AssetImage(
                                'assets/icons/notificationAppbar.png',
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Text(
                        "Profil membre - Common",
                        style: heading,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    height: height * 0.42,
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
                      children: profileMembreName.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomSwitchWithIconAndText(
                            text:
                                profileMembreName[profileMembreName.indexOf(e)],
                            icon:
                                profileMembreIcon[profileMembreName.indexOf(e)],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Text(
                        "Profil membre - Recherches",
                        style: heading,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    height: height * 0.7,
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
                        Column(
                          children: recherchesName.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CustomSwitchWithIconAndText(
                                text: recherchesName[recherchesName.indexOf(e)],
                                icon: recherchesIcon[recherchesName.indexOf(e)],
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 2.5),
                          child: Row(
                            children: [
                              Image(
                                color: Colors.black,
                                image: AssetImage(
                                  'assets/icons/recherches (1).png',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Salaire net mensuel avant impôts',
                                style: TextStyle(
                                    // fontWeight: FontWeight,
                                    ),
                              ),
                              Spacer(),
                              CustomSwitch(
                                  initialSwitchValue: false, onTap: (val) {}),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/icons/recherches (2).png',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Statut',
                                style: TextStyle(
                                    // fontWeight: FontWeight,
                                    ),
                              ),
                              Spacer(),
                              CustomSwitch(
                                  initialSwitchValue: false, onTap: (val) {}),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 2.5),
                          child: Row(
                            children: [
                              Image(
                                color: Colors.black,
                                image: AssetImage(
                                  'assets/icons/recherches (3).png',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Temps plein',
                                style: TextStyle(
                                    // fontWeight: FontWeight,
                                    ),
                              ),
                              Spacer(),
                              CustomSwitch(
                                  initialSwitchValue: false, onTap: (val) {}),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 2.5),
                          child: Row(
                            children: [
                              Image(
                                color: Colors.black,
                                image: AssetImage(
                                  'assets/icons/recherches (4).png',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Tickets cadeau',
                                style: TextStyle(
                                    // fontWeight: FontWeight,
                                    ),
                              ),
                              Spacer(),
                              CustomSwitch(
                                  initialSwitchValue: false, onTap: (val) {}),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 2.5),
                          child: Row(
                            children: [
                              Image(
                                color: Colors.black,
                                image: AssetImage(
                                  'assets/icons/recherches (5).png',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Prime',
                                style: TextStyle(
                                    // fontWeight: FontWeight,
                                    ),
                              ),
                              Spacer(),
                              CustomSwitch(
                                  initialSwitchValue: false, onTap: (val) {}),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Text(
                        "Profil pharmacie - Profil",
                        style: heading,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    height: height * 0.17,
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
                      Row(
                        children: const [
                          Text(
                            "Contact",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const CustomSwitchWithIconAndText(
                          text: 'Email',
                          icon: Icon(Icons.email_outlined),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        const CustomSwitchWithIconAndText(
                          text: 'Téléphone',
                          icon: Icon(Icons.phone),
                        ),
                      ])
                    ]),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    height: height * 0.36,
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
                      Row(
                        children: const [
                          Text(
                            "Accessibilité",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: transport.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomSwitchWithIconAndText(
                              text: transport[transport.indexOf(e)],
                              icon: transportIcon[transport.indexOf(e)],
                            ),
                          );
                        }).toList(),
                      )
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
                      Row(
                        children: const [
                          Text(
                            "Missions",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(children: const [
                        CustomSwitchWithIconAndPicture(
                            text: 'Test COVID',
                            picture: 'assets/icons/covid.png'),
                        CustomSwitchWithIconAndPicture(
                            text: 'Vaccination',
                            picture: 'assets/icons/Vaccination.png'),
                        CustomSwitchWithIconAndPicture(
                            text: 'Entretien pharmaceutique',
                            picture: 'assets/icons/missions (3).png'),
                        CustomSwitchWithIconAndPicture(
                            text: "Préparation par l'équipe",
                            picture: 'assets/icons/missions (2).png'),
                        CustomSwitchWithIconAndPicture(
                            text: 'Borne télémédecine',
                            picture: 'assets/icons/missions (1).png'),
                      ])
                    ]),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    height: height * 0.4,
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
                      Row(
                        children: const [
                          Text(
                            "Confort",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: confortList.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomSwitchWithIconAndText(
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
                      Row(
                        children: const [
                          Text(
                            "Listes des valeurs",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Listes(
                                      hint: 'Type de contrat',
                                      icon: const Icon(
                                        Icons.file_copy_outlined,
                                        color: Colors.black,
                                      ),
                                    );
                                  });
                            },
                            child: const ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.file_copy_outlined,
                                color: Colors.black,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: -10),
                              trailing: AjouterContainer(),
                              title: Text('Type contrat'),
                              subtitle: Text(
                                  "CDI, CDD, Alternance, Contrat de professionnalisation, Stage, Apprenti"),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Listes(
                                      hint: 'Nb patient par jour',
                                      icon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                    );
                                  });
                            },
                            child: const ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: -10),
                              trailing: AjouterContainer(),
                              title: Text('Nb patient par jour'),
                              subtitle: Text("<100, 100-250, 250-400, >400"),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Listes extends StatelessWidget {
  var hint;
  var icon;
  Listes({Key? key, this.hint, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nomController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Listes des valeurs',
                  style: heading,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: CustomRegistrationTextField(
              padding: 1,
              prefixIcon: icon,
              label: hint,
              controller: nomController,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          FiltersButton(
            text: 'Enregistrer',
            icon: false,
          ),
        ],
      ),
    );
  }
}
