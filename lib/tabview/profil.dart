import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:pharmabox/tabview/profile_membre_consultation.dart';

import '../constants.dart';
import '../firebase/firebase_calls.dart';
import '../model/user_models/pharmacie.dart';

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
                  height: height * 0.25,
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
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/backButton.png'),
                                    ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              FutureBuilder<Pharmacie?>(
                                  future: FirebaseCalls()
                                      .getPharmacie(widget.membre),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: [
                                          Container(
                                            height: width * 0.15,
                                            width: width * 0.15,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              image: DecorationImage(
                                                image: snapshot
                                                        .data!.images.isNotEmpty
                                                    ? NetworkImage(
                                                        snapshot
                                                            .data!.images[0],
                                                      ) as ImageProvider
                                                    : AssetImage(
                                                        'assets/images/pharmacy 1.png',
                                                      ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                          Text(
                                            snapshot.data!.nom,
                                            style: smallWhiteUnderline,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
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
                const SizedBox(
                  height: 10,
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
                    ],
                  ),
                ),

                ProfilTab(
                  membre: widget.membre,
                ),
                //    OfferScreenNorm(),
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
