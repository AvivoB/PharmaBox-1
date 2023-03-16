import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Home/pharmajob.dart';
import 'package:pharmabox/Home/pharmajob_non_titu.dart';
import 'package:pharmabox/Onboarding/SignUp.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/bloc/navigation_bloc.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/business_logic/competences_bloc/competences_bloc.dart';
import 'package:pharmabox/business_logic/experiences_bloc/experiences_bloc.dart';
import 'package:pharmabox/business_logic/langues_bloc/langues_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';
import 'package:pharmabox/business_logic/specialisations_bloc/specialisations_bloc.dart';
import 'package:pharmabox/business_logic/universites_bloc/universites_bloc.dart';
import 'package:pharmabox/configurations/mainConfig.dart';
import 'package:pharmabox/mainpages/profile_member_header.dart';
import 'package:pharmabox/mainpages/explorer.dart';
import 'package:pharmabox/pharmaJob/non_titu/pharmaJobNav_non_titu.dart';
import 'package:pharmabox/pharmaJob/pharmajobNav.dart';

import '../enums/user_type.dart';
import '../business_logic/users_bloc/users_bloc_bloc.dart';
import '../model/competence.dart';
import '../pharmacyProfile/pharmcie_header.dart';

class BottomNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final DraggableScrollableController draggableScrollableController;
  BottomNavbar(
      {super.key,
      required this.scrollController,
      required this.draggableScrollableController});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  bool isMember = true;
  late List tabs;
  late DraggableScrollableController controller;
  var color = const Color.fromRGBO(89, 90, 113, 1);
  bool result = false;
  int startIndex = 0;
  @override
  void initState() {
    super.initState();
    tabs = [
      const Explorer(),
      const PharmaJobNavNonTitu(),
      const ProfilTabBar()
    ];
    controller = widget.draggableScrollableController;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        print(controller.size);
        if (controller.size == 0.1) {
          //BlocProvider.of<NavigationBloc>(context).add(Reset());
        }
        bool oldResult = result;
        result = controller.size > 0.3 ? true : false;
        if (oldResult != result) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBlocBloc, UsersBlocState>(
      builder: (context, state) {
        if (state is UserAdded) {
          if (state.user!.poste == UserType.tutor) {
            tabs.removeAt(1);
            tabs.insert(1, const PharmaJobNav());
          }
        }
        return Scaffold(
          backgroundColor: Colors.white,
          //appBar: appBarCustom(),
          body: SingleChildScrollView(
              controller: widget.scrollController,
              child: SizedBox(
                child: tabs[startIndex],
                height: MediaQuery.of(context).size.height,
              )),
          bottomNavigationBar: Visibility(
            visible: result,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: startIndex,
              onTap: (index) {
                BlocProvider.of<NavigationBloc>(context)
                    .add(NavItemClicked(currentIndex: index));
                setState(() {
                  startIndex = index;
                });
                if (index == 2) {
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

                          ///profile pramacy
                          if (state.user!.poste == UserType.tutor)
                            InkWell(
                              onTap: () {
                                BlocProvider.of<PharmacieBloc>(context)
                                    .add(GetPharmacie());
                                setState(() {
                                  tabs.removeLast();
                                  tabs.add(PharmacieHeader());
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
                              setState(() {
                                tabs.removeLast();
                                tabs.add(const ProfilTabBar());
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Configuration(),
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
                              FirebaseAuth.instance.signOut().then(
                                    (value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignUp(),
                                      ),
                                    ),
                                  );
                              BlocProvider.of<CompetencesBloc>(context)
                                  .add(InitialiseCompetence(competences: [
                                Competence(
                                    nom: "Test COVID",
                                    enabled: false,
                                    asset: "assets/icons/covid.png"),
                                Competence(
                                    nom: "Vaccination",
                                    enabled: false,
                                    asset: "assets/icons/covid.png"),
                                Competence(
                                    nom: "Gestion du tiers payant",
                                    enabled: false,
                                    asset: "assets/icons/covid.png"),
                                Competence(
                                    nom: "Gestion des labos",
                                    enabled: false,
                                    asset: "assets/icons/covid.png"),
                              ]));
                              BlocProvider.of<ExperiencesBloc>(context).add(
                                  InitialiseExperience(experiences: const []));
                              BlocProvider.of<LanguesBloc>(context)
                                  .add(InitialiseLangue(langues: const []));
                              BlocProvider.of<LgoBloc>(context)
                                  .add(InitialiseLgo(lgos: const []));
                              BlocProvider.of<UniversitesBloc>(context)
                                  .add(Initi());
                              BlocProvider.of<SpecialisationsBloc>(context).add(
                                  InitialiseSpecialisation(
                                      specialisations: const []));
                              // BlocProvider.of<TitulaireBloc>(context).add(InitTitu());
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
                /* BottomNavigationBarItem(
                    activeIcon: Image(
                      height: MediaQuery.of(context).size.height * 0.035,
                      image:
                          const AssetImage('assets/icons/PharmadvisorGreen.png'),
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
                  ),*/
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
          ),
        );
      },
    );
  }
}
