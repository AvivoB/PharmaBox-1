import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/utility.dart';
import 'package:pharmabox/general/widgets/custom_registration_date_picker.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';
import 'package:pharmabox/general/widgets/custom_switch_with_suffix_and_text.dart';
import 'package:pharmabox/general/widgets/custom_textfield_with_dropdown.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyrow.dart';

import '../Widgets/space_values.dart';
import '../model/job_model.dart';
part 'heading_tile_widget.dart';
part 'table_text_widget.dart';
part 'custom_check_box.dart';
part 'custom_table.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});


  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  TextEditingController locationController = TextEditingController();

  TextEditingController routeController = TextEditingController();

  TextEditingController contractController = TextEditingController();

  TextEditingController timeController = TextEditingController();
  TextEditingController postController = TextEditingController();

  TextEditingController dateController =
      TextEditingController(text: 'DD/MM/YYYY');

  TextEditingController durationController = TextEditingController();

  TextEditingController salaryController = TextEditingController();

  bool lOffer = false;
  bool prime = false;
  bool companyCreche = false;
  bool tExpense = false;
  bool giftTickets = false;
  bool ticketsRes = false;
  bool accommodation = false;
  bool scheduleDiscussed = false;
  bool validForMonth = false;
  bool immediateStart = false;
  bool negotiateSalary = false;

  final List<String> transport = <String>[
    'RER',
    'Métro',
    'Bus',
    'Tramway',
    'Gare',
    'Parking',
  ];

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
  bool arrow = true;
  bool arrow2 = true;
  bool arrow3 = true;
  bool arrow4 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: arrow
                ? MediaQuery.of(context).size.height * 2.75
                : MediaQuery.of(context).size.height * 0.07,
            // width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    const Text(
                      "Pharmacien adjoint",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          arrow = !arrow;
                        });
                      },
                      child: Icon(
                        !arrow
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                arrow
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            dense: true,
                            // leading:
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(106, 214, 151, 1),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  lightGreen.withOpacity(0.6),
                                              spreadRadius: 6,
                                              blurRadius: 6,
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Actif'),
                                  ],
                                ),
                                /*CustomSwitch(onChanged: (val) {
                                  validForMonth = val;
                                },),*/
                                CustomSwitch(
                                    initialSwitchValue: false, onTap: (val) {}),
                              ],
                            ),
                            // trailing: CustomSwitch(),
                            subtitle: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                ),
                                Text(
                                    'Offre valable 1 mois  à compter du 24/02/2022'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // CustomTextfieldDropdown(
                          //   padding: 1,
                          //   label: 'Poste',
                          //   prefixIcon: const Icon(
                          //     Icons.shopping_bag_outlined,
                          //     color: Colors.black,
                          //   ),
                          //   controller: postController,
                          //   suffixIcon: const Icon(
                          //     Icons.arrow_drop_down,
                          //   ),
                          // ),

                          CustomRegistrationTextField(
                            padding: 1,
                            label: 'Poste',
                            prefixIcon: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.black,
                            ),
                            controller: postController,
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

                          PharmacyRow(
                            text: 'Début immédiate',
                            icon: Icons.calendar_today_outlined,
                            onChanged: (val) {
                              immediateStart = val;
                            },
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
                          PharmacyRow(
                            text: 'Salaire négocier ensemble',
                            icon: Icons.payments_outlined,
                            onChanged: (val) {
                              negotiateSalary = val;
                            },
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
                          Column(
                            children: [
                              PharmacyRow(
                                text: 'Offre à responsabilité',
                                icon: Icons.people,
                                onChanged: (val) {
                                  lOffer = val;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRow(
                                text: 'Prime',
                                image: 'assets/icons/trophy.png',
                                onChanged: (val) {
                                  prime = val;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRow(
                                text: "Crèche d'entreprise",
                                icon: Icons.cruelty_free_outlined,
                                onChanged: (val) {
                                  companyCreche = val;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRow(
                                text: "Frais de déplacement",
                                icon: Icons.airplane_ticket_outlined,
                                onChanged: (val) {
                                  tExpense = val;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRow(
                                text: 'Tickets cadeau',
                                icon: Icons.card_giftcard,
                                onChanged: (val) {
                                  giftTickets = val;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRow(
                                text: 'Tickets restaurant',
                                icon: Icons.restaurant,
                                onChanged: (val) {
                                  ticketsRes = val;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRow(
                                text: 'Logement',
                                icon: Icons.cottage,
                                onChanged: (val) {
                                  accommodation = val;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PharmacyRow(
                                text: 'Emplois du temps à discuter',
                                icon: Icons.calendar_month_outlined,
                                onChanged: (val) {
                                  scheduleDiscussed = val;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Grille horaires semaine paires",
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
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                              ),
                              Wrap(
                                children: const [
                                  Text(
                                      'Semaines paires et impaires identiques'),
                                ],
                              ),
                              CustomSwitch(
                                  initialSwitchValue: false, onTap: (val) {}),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Grille horaires semaines impaires",
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
                                "Description de poste",
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
                          CustomRegistrationTextField(
                            padding: 1,
                            label: 'Description',
                            maxLines: 10,
                            controller: locationController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  Color.fromRGBO(124, 237, 172, 1),
                                  Color.fromRGBO(66, 210, 255, 1),
                                ])),
                                child: Center(
                                    child: Text(
                                  'Enregistrer',
                                  style: smallWhite,
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: arrow2
                ? MediaQuery.of(context).size.height * 0.15
                : MediaQuery.of(context).size.height * 0.07,
            // width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(children: [
              Row(
                children: [
                  const Text(
                    "Préparateur en pharmacie",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        arrow2 = !arrow2;
                      });
                    },
                    child: Icon(
                      !arrow2
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_up_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              arrow2
                  ? ListTile(
                      dense: true,
                      // leading:
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                width: MediaQuery.of(context).size.width * 0.05,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(106, 214, 151, 1),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: lightGreen.withOpacity(0.6),
                                        spreadRadius: 6,
                                        blurRadius: 6,
                                      )
                                    ]),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Actif'),
                            ],
                          ),
                        ],
                      ),
                      // trailing: CustomSwitch(),
                      subtitle: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          Text('Offre valable 1 mois  à compter du 24/02/2022'),
                        ],
                      ),
                    )
                  : Container(),
            ]),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: arrow3
                ? MediaQuery.of(context).size.height * 0.15
                : MediaQuery.of(context).size.height * 0.07,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Pharmacien",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          arrow3 = !arrow3;
                        });
                      },
                      child: Icon(
                        !arrow3
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                arrow3
                    ? ListTile(
                        dense: true,
                        // leading:
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.025,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(106, 214, 151, 1),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: lightGreen.withOpacity(0.6),
                                          spreadRadius: 6,
                                          blurRadius: 6,
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Actif'),
                              ],
                            ),
                          ],
                        ),
                        // trailing: CustomSwitch(),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            Text(
                                'Offre valable 1 mois  à compter du 22/02/2022'),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: arrow4
                ? MediaQuery.of(context).size.height * 0.12
                : MediaQuery.of(context).size.height * 0.07,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Pharmacien",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          arrow4 = !arrow4;
                        });
                      },
                      child: Icon(
                        !arrow4
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                arrow4
                    ? ListTile(
                        dense: true,
                        // leading:
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.025,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(214, 125, 106, 1),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(214, 125, 106, 1)
                                                  .withOpacity(0.6),
                                          spreadRadius: 6,
                                          blurRadius: 6,
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Inactif'),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),

        Spaces.y3,

        //save btn
        GestureDetector(
          onTap: () {
            var jobModel = JobModel();

            if (postController.text.isEmpty) {
              Utility.showSnack('title', 'Enter post title first');
              return;
            }

            if (locationController.text.isEmpty) {
              Utility.showSnack('title', 'Enter job location first');
              return;
            }

            jobModel.postName = postController.text;
            jobModel.location = locationController.text;
            jobModel.route = routeController.text;
            jobModel.contract = contractController.text;
            jobModel.timeType = timeController.text;
            jobModel.immediateStart = immediateStart;
            jobModel.conStartDate = dateController.text;
            jobModel.salary = salaryController.text;
            jobModel.negotiateSalary = negotiateSalary;
            jobModel.lOffer = negotiateSalary;
            jobModel.prime = prime;
            jobModel.companyCreche = companyCreche;
            jobModel.tExpense = tExpense;
            jobModel.giftTickets = giftTickets;
            jobModel.accommodation = accommodation;
            jobModel.scheduleDiscussed = scheduleDiscussed;

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
                  'save'.tr,
                  style: bigWhite,
                ),
              )),
        ),
      ],
    );
  }
}
