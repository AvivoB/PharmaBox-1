import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/standard_indicator.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_custom_tab_bar/transform/scale_transform.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';
import 'package:pharmabox/local/my_hive.dart';
import 'package:pharmabox/offer/offer_screen.dart';
import 'package:pharmabox/tabview/Advisor.dart';
import 'package:pharmabox/tabview/ProfilTab.dart';
import 'package:pharmabox/tabview/Reseau.dart';
import 'package:pharmabox/tabview/offres.dart';
import 'package:pharmabox/tabviewEditmode/AdvisorEdit.dart';
import 'package:pharmabox/tabviewEditmode/ProfilTabEdit.dart';
import 'package:pharmabox/tabviewEditmode/ReseauEdit.dart';
import 'package:pharmabox/tabviewEditmode/offresEdit.dart';

import '../constants.dart';
import '../general/widgets/custom_registration_date_picker.dart';
import '../general/widgets/custom_registration_textfield.dart';

class ProfilTabBar extends StatefulWidget {
  const ProfilTabBar({Key? key}) : super(key: key);

  @override
  State<ProfilTabBar> createState() => _ProfilTabBarState();
}

class _ProfilTabBarState extends State<ProfilTabBar>
    with TickerProviderStateMixin {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dateOfBirthController =
      TextEditingController(text: 'DD/MM/YYYY');
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<String> _tabs = ['Profil', 'Advisor', 'Réseau', 'Offres'];
  late TabController tabController;

  var user = MyHive.getUser();

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: _tabs.length, initialIndex: 0, vsync: this);

    if (user != null) {
      firstNameController.text = user?.fname ?? '';
      lastNameController.text = user?.lname ?? '';
      jobTitleController.text = user?.type ?? '';
      phoneController.text = user?.phone ?? '';
      postalCodeController.text = user?.postalCode ?? '';
      emailController.text = user?.email ?? '';
      dateOfBirthController.text = user?.dob ?? '';
      addressController.text = user?.ville ?? '';
      descriptionController.text = user?.presentation ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: appBarCustom(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
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
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Stack(
                                  children: [
                                    Image(
                                      height: height * 0.25,
                                      image: AssetImage(
                                          'assets/images/profilTabBar.png'),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      user?.fname ?? '',
                                      style: bigWhite,
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      user?.type ?? '',
                                      style: smallWhite,
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                31, 92, 103, 0.17),
                                            offset: Offset(3, 3),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: lightGreen,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                            ),
                                            width: width * 0.18,
                                            height: height * 0.05,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                                Text(
                                                  '535',
                                                  style: headingWhite,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            width: width * 0.08,
                                            height: height * 0.05,
                                            child: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color.fromRGBO(
                                                  89, 90, 113, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomRegistrationTextField(
                        label: 'Nom',
                        prefixIcon: const Icon(
                          CupertinoIcons.person,
                        ),
                        controller: firstNameController,
                      ),
                      CustomRegistrationTextField(
                        label: 'Prénom',
                        prefixIcon: const Icon(
                          CupertinoIcons.person,
                        ),
                        controller: lastNameController,
                      ),
                      CustomRegistrationTextField(
                        label: 'Poste',
                        prefixIcon: const Icon(
                          CupertinoIcons.bag,
                        ),
                        controller: jobTitleController,
                      ),
                      CustomRegistrationTextField(
                        label: 'Email',
                        prefixIcon: const Icon(
                          CupertinoIcons.mail,
                        ),
                        controller: emailController,
                      ),
                      // CustomRegistrationTextField(
                      //   label: 'Nouveau mot de passe',
                      //   prefixIcon: const Icon(
                      //     Icons.lock_outline,
                      //   ),
                      //   showSuffix: true,
                      //   obsecureText: true,
                      //   controller: passwordController,
                      // ),
                      // CustomRegistrationTextField(
                      //   label: 'Confirmation mot de passe',
                      //   prefixIcon: const Icon(
                      //     Icons.lock_outline,
                      //   ),
                      //   showSuffix: true,
                      //   obsecureText: true,
                      //   controller: confirmPasswordController,
                      // ),
                      CustomRegistrationDatePicker(
                        label: 'Date de naissance',
                        prefixIcon: const Icon(
                          Icons.cake_outlined,
                        ),
                        controller: dateOfBirthController,
                      ),
                      CustomRegistrationTextField(
                        label: 'Téléphone',
                        prefixIcon: const Icon(
                          CupertinoIcons.phone,
                        ),
                        controller: phoneController,
                      ),
                      CustomRegistrationTextField(
                        label: 'Code postal',
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                        ),
                        controller: postalCodeController,
                      ),
                      CustomRegistrationTextField(
                        label: 'Ville',
                        prefixIcon: const Icon(
                          Icons.location_city_outlined,
                        ),
                        controller: addressController,
                      ),
                      CustomRegistrationTextField(
                        label: 'Presentation',
                        prefixIcon: const Icon(
                          Icons.location_city_outlined,
                        ),
                        controller: descriptionController,
                        maxLines: 13,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color.fromRGBO(245, 245, 245, 1),
                  child: Column(
                    children: [
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
                            tabs:
                                _tabs.map((element) => Text(element)).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 25,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            ProfilTabEdit(),
                            AdvisorTabEdit(),
                            ReseauEdit(),
                            OfferScreen(),
                          ],
                        ),
                      ),
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
