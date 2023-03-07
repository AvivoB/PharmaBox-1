import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Home/pharmajob.dart';
import 'package:pharmabox/Home/pharmajob_non_titu.dart';
import 'package:pharmabox/Onboarding/SignUp.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/bloc/titulaires_bloc.dart';
import 'package:pharmabox/business_logic/competences_bloc/competences_bloc.dart';
import 'package:pharmabox/business_logic/experiences_bloc/experiences_bloc.dart';
import 'package:pharmabox/business_logic/langues_bloc/langues_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';
import 'package:pharmabox/business_logic/specialisations_bloc/specialisations_bloc.dart';
import 'package:pharmabox/business_logic/universites_bloc/universites_bloc.dart';
import 'package:pharmabox/configurations/mainConfig.dart';
import 'package:pharmabox/pharmaJob/pharmaJobNav_non_titu.dart';
import 'package:pharmabox/mainpages/profile_member_header.dart';
import 'package:pharmabox/mainpages/explorer.dart';
import 'package:pharmabox/pharmacyProfile/pharmacie_content.dart';
import 'package:pharmabox/pharmacyProfile/pharmacie_list.dart';
import 'package:pharmabox/mainpages/pharmadvisor.dart';
import 'package:pharmabox/pharmaJob/pharmajobNav.dart';
import 'package:pharmabox/mainpages/reseau.dart';
import 'package:pharmabox/pharmacyProfile/pharmcie_header.dart';

import '../business_logic/users_bloc/users_bloc_bloc.dart';
import '../enums/user_type.dart';
import '../model/competence.dart';

class BottomNavbar extends StatefulWidget {
  var startIndex;

  BottomNavbar({super.key, required this.startIndex});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  bool isMember = true;
  List tabs = [const Explorer(),const PharmaJob(),const ProfilTabBar()];
  var color = const Color.fromRGBO(89, 90, 113, 1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = BlocProvider.of<UsersBlocBloc>(context).currentUser;
    if (user != null) {
      if (user.poste != UserType.tutor) {
        tabs = const [Explorer(), PharmaJobNonTitu(), ProfilTabBar()];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBlocBloc, UsersBlocState>(
      builder: (context, state) {
        if (state is UserAdded) {
          return Scaffold(
            backgroundColor: Colors.white,
            //appBar: appBarCustom(),
            body: tabs[widget.startIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: widget.startIndex,
              onTap: (index) {
                setState(() {
                  widget.startIndex = index;
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
                              //GoogleSignIn().signOut();
                              /*showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ));*/
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
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.topToBottom,
                      child: state.user!.poste == UserType.tutor
                          ? PharmaJob()
                          : PharmaJobNonTitu(),
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
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
