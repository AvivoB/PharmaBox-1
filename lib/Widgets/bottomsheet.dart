import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';

import '../general/widgets/custom_registration_date_picker.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../general/widgets/custom_switch_widget.dart';
import '../general/widgets/custom_switch_with_suffix_and_text.dart';
import '../general/widgets/custom_textfield_with_dropdown.dart';
import '../offer/offer_screen.dart';

class FiltersBottomSheet extends StatelessWidget {
  FiltersBottomSheet({Key? key}) : super(key: key);

  TextEditingController locationController = TextEditingController();

  TextEditingController routeController = TextEditingController();

  TextEditingController contractController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController dateController =
      TextEditingController(text: 'DD/MM/YYYY');

  TextEditingController durationController = TextEditingController();

  TextEditingController salaryController = TextEditingController();

  final List<String> transport = <String>[
    'RER',
    'Métro',
    'Bus',
    'Tramway',
    'Gare',
    'Parking',
  ];

  final List<String> confortList = <String>[
    'Robot',
    'Etiquettes electronique',
    'Salle de pause',
    'Vigile',
  ];

  final List<Icon> confortIcons = <Icon>[
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      height: height * 0.85,
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15,
        top: 20,
        bottom: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filtres',
                  style: heading,
                ),
                GestureDetector(
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
            const SizedBox(
              height: 20,
            ),
            CustomRegistrationTextField(
              padding: 1,
              label: 'Localisation',
              prefixIcon: const Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              controller: locationController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomRegistrationTextField(
              padding: 1,
              label: 'Rayon km',
              prefixIcon: const Icon(
                Icons.map_outlined,
                color: Colors.black,
              ),
              controller: routeController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomRegistrationTextField(
              padding: 1,
              label: 'Contrat',
              prefixIcon: const Icon(
                Icons.description_outlined,
                color: Colors.black,
              ),
              controller: contractController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextfieldDropdown(
              padding: 1,
              label: 'Temps plein/partiel',
              prefixIcon: const Icon(
                Icons.schedule,
                color: Colors.black,
              ),
              controller: timeController,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomSwitchWithIconAndText(
              text: 'Début immédiate',
              icon: Icon(
                Icons.calendar_today_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomRegistrationDatePicker(
              padding: 1,
              label: 'Début du contrat',
              prefixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.black,
              ),
              controller: dateController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextfieldDropdown(
              padding: 1,
              label: 'Durée',
              prefixIcon: const Icon(
                Icons.calendar_month_outlined,
                color: Colors.black,
              ),
              controller: durationController,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomSwitchWithIconAndText(
              text: 'Salaire négocier ensemble',
              icon: Icon(
                Icons.payments_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomSwitchWithIconAndText(
              text: "Crèche d'entreprise",
              icon: Icon(
                Icons.cruelty_free_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomSwitchWithIconAndText(
              text: "Frais de déplacement",
              icon: Icon(
                Icons.airplane_ticket_outlined,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomSwitchWithIconAndText(
              text: 'Logement',
              icon: Icon(
                Icons.cottage_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomRegistrationTextField(
              padding: 1,
              label: 'Salaire net mensuel avant impôts',
              prefixIcon: const Icon(
                Icons.payments_outlined,
                color: Colors.black,
              ),
              controller: salaryController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  "Grille horaires",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTable(),
            const SizedBox(
              height: 20,
            ),
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
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomSwitchWithIconAndText(
                    text: transport[transport.indexOf(e)],
                    icon: transportIcon[transport.indexOf(e)],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
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
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomSwitchWithIconAndText(
                    text: confortList[confortList.indexOf(e)],
                    icon: confortIcons[confortList.indexOf(e)],
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Prefrences de LGO',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: height * 0.05,
                  width: width * 0.1,
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children:  [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Pas de preference de lgo',
                  style: TextStyle(
                      // fontWeight: FontWeight,
                      ),
                ),
                Spacer(),
                CustomSwitch(),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Image(
                  width: 20,
                  image: AssetImage(
                    'assets/icons/computerIcon.png',
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Microsoft Word'),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Image(
                  width: 20,
                  image: AssetImage(
                    'assets/icons/computerIcon.png',
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Microsoft Excel'),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
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
                          width: 10,
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
                          width: 10,
                        ),
                        Image(
                          image:
                              const AssetImage('assets/icons/Vaccination.png'),
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
                          width: 10,
                        ),
                        Icon(
                          Icons.local_police_outlined,
                          color: Colors.black,
                          size: height * 0.025,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Text(
                          'Entretien pharmaceutique',
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
            SizedBox(
              height: height * 0.2,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);

                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return FiltersButtonBottomSheet();
                    });
              },
              child: FiltersButton(
                text: 'Enregistrer ma recherche',
                icon: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class FiltersButton extends StatelessWidget {
  var text;
  var icon;
  FiltersButton({Key? key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(31, 92, 103, 0.17),
              offset: Offset(3, 3),
              blurRadius: 3,
            ),
          ],
          gradient: LinearGradient(colors: [
            Color.fromRGBO(124, 237, 172, 1),
            Color.fromRGBO(66, 210, 255, 1),
          ])),
      width: width * 0.9,
      height: height * 0.065,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon == true
              ? Image(
                  height: height * 0.025,
                  image: const AssetImage(
                    'assets/icons/filterbuttonicon.png',
                  ),
                )
              : Container(),
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            text,
            style: bigWhite,
          ),
        ],
      ),
    );
  }
}

class FiltersButtonBottomSheet extends StatelessWidget {
  const FiltersButtonBottomSheet({Key? key}) : super(key: key);

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
                  'Enregistrer ma recherche',
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
              label: 'Nom de la recherche',
              controller: nomController,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          FiltersButton(
            text: 'Enregistrer ma recherche',
            icon: true,
          ),
        ],
      ),
    );
  }
}
