import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/constant.dart';
import 'package:pharmabox/offer/offer_screen.dart';
import 'package:pharmabox/pharmacyProfile/pharmacyTab.dart';
import 'package:pharmabox/tabview/Advisor.dart';
import 'package:pharmabox/tabview/ProfilTab.dart';
import 'package:pharmabox/tabview/Reseau.dart';

import '../model/user_models/non_titulaire.dart';

class PharmacyProfile extends StatefulWidget {
  const PharmacyProfile({Key? key}) : super(key: key);

  @override
  State<PharmacyProfile> createState() => _PharmacyProfileState();
}

class _PharmacyProfileState extends State<PharmacyProfile>
    with TickerProviderStateMixin {
  final List<String> _tabs = ['Profil', 'Advisor', 'Réseau', 'Offres'];
  late TabController tabController;
  final List<String> imgList = [
    'assets/images/PharmacyMain.png',
    'assets/images/pharmacy 2.png',
  ];
   String? imgPath;
  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: _tabs.length, initialIndex: 0, vsync: this);
    imgPath = BlocProvider.of<UsersBlocBloc>(context).imagePath;
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: appBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                height: height * 0.4,
                viewportFraction: 1,
              ),
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: height * 0.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            i,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 15),
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
                                Row(
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          'assets/images/flag icon.png'),
                                      width: width * 0.12,
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Image(
                                      image: const AssetImage(
                                          'assets/images/Button Add.png'),
                                      width: width * 0.12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Container(
                                      width: width * 0.3,
                                      height: height * 0.06,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                            'assets/images/GoldMember.png',
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.35,
                                      height: height * 0.07,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: AssetImage(
                                            'assets/images/Securitie.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      child: LikeButton(isLiked: false),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      imgList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.black)
                                                    .withOpacity(
                                                        _current == entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Container(
              height: height * 0.007,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(124, 237, 172, 1),
                  Color.fromRGBO(66, 210, 255, 1),
                ],
              )),
            ),
            Container(
              color: Colors.white,
              height: height * 0.02,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
              ),
              child: Column(children: [
                Text(
                  "Grande Pharmacie D'Aulnay",
                  style: heading,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Image(
                            height: height * 0.055,
                            image:
                            imgPath!=null ? FileImage(File(imgPath!)) as ImageProvider :    const AssetImage('assets/images/profile.png')),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          children: [
                            Text(
                              'Titulaire',
                              style: heading,
                            ),
                            Text(
                              'Jimmy Azoulay',
                              style: paragraph,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image(
                            height: height * 0.045,
                            image: const AssetImage(
                                'assets/images/CroppedBall.png')),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          children: [
                            Text(
                              'Groupement',
                              style: heading,
                            ),
                            Text(
                              'Leader Santé',
                              style: paragraph,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "Notre équipe vous conseillera aussi bien en hméopathie, qu'en phytothérapie, aromathérapie ou nutrithérapie...",
                      style: paragraph,
                    ),
                    Text(
                      'Afficher plus',
                      style: blueNorm,
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(children: [
                  Image(
                    image: const AssetImage('assets/icons/universityIcon.png'),
                    width: width * 0.06,
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Text(
                    'Pharmacie maître de stage',
                    style: paragraph,
                  ),
                ]),
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
                    CustomSwitch(initialSwitchValue: false, onTap: (val) {}),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              height: height * 0.07,
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                bottom: TabBar(
                  labelColor: Colors.black,
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
                  labelPadding: const EdgeInsets.only(bottom: 4.0, right: 0.0),
                  indicator: const BoxDecoration(
                    gradient: kTabBarIndicatorGradient,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  indicatorWeight: 3,
                  indicatorPadding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                  ),
                  controller: tabController,
                  tabs: _tabs.map((element) => Text(element)).toList(),
                ),
              ),
            ),
            SizedBox(
              height: height * 31,
              child: TabBarView(
                controller: tabController,
                children: [
                  const PharmacyTabBar(),
                  const AdvisorTab(),
                  const Reseau(),
                  OfferScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
