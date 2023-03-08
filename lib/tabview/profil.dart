import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:pharmabox/offer/offerNorm.dart';
import 'package:pharmabox/tabview/Advisor.dart';
import 'package:pharmabox/tabview/profile_membre_consultation.dart';
import 'package:pharmabox/tabview/Reseau.dart';

import '../constants.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../pharmaJob/bottomsheet.dart';

class Profil extends StatefulWidget {
  NonTitulaire membre;
  Profil({Key? key, required this.membre}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> with TickerProviderStateMixin {
  final List<String> _tabs = ['Profil'];
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: _tabs.length, initialIndex: 0, vsync: this);
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        appBar: appBarCustom(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.3,
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
                  child: Column(
                    children: [
                      SizedBox(
                          width: width * 0.9,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/backButton.png'),
                                  ),
                                ),
                                /* Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) => Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Signaler contenu inaproprié',
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child:
                                                  CustomRegistrationTextField(
                                                maxLines: 5,
                                                padding: 1,
                                                label: 'Commentaire',
                                                controller: controller,
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.03,
                                            ),
                                            FiltersButton(
                                              text: 'Signaler',
                                              icon: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/flag icon.png'),
                                    width: width * 0.12,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Image(
                                  image: AssetImage(
                                      'assets/images/Button Add.png'),
                                  width: width * 0.12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),*/
                              ])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundImage: widget.membre.photoUrl != ''
                                    ? NetworkImage(widget.membre.photoUrl)
                                        as ImageProvider
                                    : const AssetImage(
                                        'assets/images/user.png',
                                      ),
                              ),
                              /*Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  // color: lightGreen,
                                  height: height * 0.28,
                                  width: width * 0.5,
                                  child: Image(
                                    height: height * 0.06,
                                    image: AssetImage(
                                        'assets/images/GoldMember.png'),
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                widget.membre.nom,
                                style: bigWhite,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                widget.membre.poste,
                                style: smallWhite,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.11,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/pharmacy 1.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  Text(
                                    "Grande Pharmacie \nD'Aulnay, 94160, Paris",
                                    style: smallWhiteUnderline,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              LikeButton(isLiked: false),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  color: Colors.white,
                  // width: width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.cake,
                            color: Color.fromRGBO(89, 90, 113, 1),
                          ),
                          Text(
                            widget.membre.localisation.codePostal.toString(),
                            style: biggerGrey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Color.fromRGBO(89, 90, 113, 1),
                          ),
                          Text(
                            widget.membre.localisation.ville.toString(),
                            style: biggerGrey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: Color.fromRGBO(89, 90, 113, 1),
                          ),
                          Text(
                            widget.membre.email,
                            style: biggerGrey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Color.fromRGBO(89, 90, 113, 1),
                          ),
                          Text(
                            widget.membre.telephone.numeroTelephone.toString(),
                            style: biggerGrey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      SizedBox(
                        width: width * 0.9,
                        child: Wrap(
                          children: [
                            Text(
                              widget.membre.prenom,
                              style: biggerGrey,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color.fromRGBO(89, 90, 113, 0.4),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.power_settings_new,
                                color: Color.fromRGBO(89, 90, 113, 1),
                              ),
                              Text(
                                '  Activer',
                                style: biggerGrey,
                              ),
                            ],
                          ),
                          CustomSwitch(),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    bottom: TabBar(
                      labelColor: Color(0xfF161730),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kSelectedIndicatorColor,
                        fontSize: 16,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kUnSelectedIndicatorColor,
                      ),
                      labelPadding:
                          const EdgeInsets.only(bottom: 4.0, right: 0.0),
                      indicator: const BoxDecoration(
                        gradient: kTabBarIndicatorGradient,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      indicatorWeight: 1.5,
                      indicatorPadding: const EdgeInsets.only(
                        top: 20,
                        left: 25,
                        right: 25,
                      ),
                      controller: tabController,
                      tabs: _tabs.map((element) => Text(element)).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 4,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ProfilTab(
                        membre: widget.membre,
                      ),
                      //    OfferScreenNorm(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  CustomSwitch({Key? key}) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FlutterSwitch(
      toggleSize: 17,
      height: height * 0.03,
      activeColor: const Color.fromRGBO(124, 237, 172, 1),
      width: 40,
      onToggle: (val) {
        setState(() {
          status = val;
        });
      },
      value: true,
    );
  }
}
