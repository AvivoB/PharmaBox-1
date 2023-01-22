import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Home/pharmajob.dart';
import 'package:pharmabox/Onboarding/SignUp.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/configurations/mainConfig.dart';
import 'package:pharmabox/local/my_hive.dart';
import 'package:pharmabox/mainpages/Profilnavbar.dart';
import 'package:pharmabox/mainpages/explorer.dart';
import 'package:pharmabox/mainpages/pharmacieEdit.dart';
import 'package:pharmabox/mainpages/pharmadvisor.dart';
import 'package:pharmabox/mainpages/pharmajobNav.dart';
import 'package:pharmabox/mainpages/profil.dart';
import 'package:pharmabox/mainpages/reseau.dart';
import 'package:pharmabox/pharmacyProfile/pharmacy_controller.dart';

import '../enums/user_type.dart';
import '../main.dart';

class BottomNavbar extends StatefulWidget {
  var startIndex;

  BottomNavbar({super.key, required this.startIndex});

  PharmacyController pharmacyController = Get.find();

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  bool isMember = true;
  List tabs = [
    Explorer(),
    PharmaJobNav(),
    PharmAdvisor(),
    ReseauTab(),
    ProfilTabBar(),
  ];
  var color = const Color.fromRGBO(89, 90, 113, 1);

  var userType = MyHive.getUser()?.type ?? '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (userType == UserType.PharmacyOwner) {
      tabs.removeLast();
      tabs.add(PharmacieEdit(
        myPharmacy: null,
      ));
      Future.delayed(const Duration(seconds: 1), () {
        widget.pharmacyController.getMyPharmacy((pharmacy) {
          // setState(() {
          //   tabs.removeLast();
          //   tabs.add(PharmacieEdit(
          //     myPharmacy: pharmacy,
          //   ));
          //   Navigator.pop(context);
          // });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: appBarCustom(),
      body: tabs[widget.startIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.startIndex,
        onTap: (index) {
          setState(() {
            widget.startIndex = index;
          });
          if (index == 4) {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              context: context,
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    if (userType == UserType.tutor ||
                        userType == UserType.nonTutor)
                      InkWell(
                        onTap: () {
                          setState(() {
                            tabs.removeLast();
                            tabs.add(ProfilTabBar());
                            Navigator.pop(context);
                          });
                        },
                        child: Row(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.person),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Profil membre',
                              style: paragraph,
                            ),
                          ),
                        ]),
                      ),

                    ///profile pramacy
                    if (userType == UserType.PharmacyOwner)
                      InkWell(
                        onTap: () {

                          setState(() {
                            tabs.removeLast();
                            tabs.add(PharmacieEdit(
                              myPharmacy: null,
                            ));
                            Navigator.pop(context);
                          });

                        },
                        child: Row(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.local_hospital),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Profil pharmacie',
                              style: paragraph,
                            ),
                          ),
                        ]),
                      ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Configuration(),
                          ),
                        );
                      },
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.settings),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Configurations',
                            style: paragraph,
                          ),
                        ),
                      ]),
                    ),
                    InkWell(
                      onTap: () {
                        GoogleSignIn().signOut();
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ));
                        FirebaseAuth.instance.signOut().then(
                              (value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              ),
                            );
                      },
                      child: Row(children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.logout, color: Colors.red),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Deconnexion',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                child: PharmaJob(),
                isIos: true,
                duration: Duration(milliseconds: 400),
              ),
            );
          }
        },
        backgroundColor: Colors.white,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 2.0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: AssetImage('assets/images/search.png'),
            ),
            icon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: const AssetImage('assets/images/search.png'),
              color: color,
            ),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: AssetImage('assets/images/Pharmajob green.png'),
            ),
            icon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: AssetImage('assets/images/pharmjob.png'),
            ),
            label: 'PharmaJob',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: const AssetImage('assets/icons/PharmadvisorGreen.png'),
            ),
            icon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: AssetImage('assets/images/like.png'),
            ),
            label: 'PharmAdvisor',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              height: MediaQuery.of(context).size.height * 0.032,
              image: const AssetImage('assets/images/persongreen.png'),
            ),
            icon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: AssetImage('assets/images/person.png'),
            ),
            label: 'Réseau',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: AssetImage('assets/images/profilegreen.png'),
            ),
            icon: Image(
              height: MediaQuery.of(context).size.height * 0.035,
              image: AssetImage('assets/images/Profil.png'),
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
