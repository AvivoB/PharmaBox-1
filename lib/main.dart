import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharmabox/Home/HomePage.dart';
import 'package:pharmabox/Onboarding/Login.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/bloc/titulaires_bloc.dart';
import 'package:pharmabox/business_logic/competences_bloc/competences_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';
import 'package:pharmabox/business_logic/specialisations_bloc/specialisations_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/firebase/users_calls.dart';
import 'package:sizer/sizer.dart';

import 'business_logic/experiences_bloc/experiences_bloc.dart';
import 'business_logic/langues_bloc/langues_bloc.dart';
import 'business_logic/universites_bloc/universites_bloc.dart';
import 'lang/translation_service.dart';
import 'model/competence.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await [
    Permission.location,
    Permission.storage,
  ].request();

  runApp(const MyApp());
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ExperiencesBloc(
                  experiences: [],
                )),
        BlocProvider(
            create: (_) => UniversitesBloc(
                  universities: [],
                )),
        BlocProvider(
            create: (_) => SpecialisationsBloc(
                  specialisations: [],
                )),
        BlocProvider(
            create: (_) => LanguesBloc(
                  langues: [],
                )),
        BlocProvider(create: (_) => LgoBloc(lgos: [])),
        BlocProvider(
            create: (_) => CompetencesBloc(competences: [
                  Competence(
                      nom: "Test COVID",
                      enabled: false,
                      asset: "assets/icons/covid.png"),
                  Competence(
                      nom: "Vaccination",
                      enabled: false,
                      asset: "assets/icons/Vaccination.png"),
                  Competence(
                      nom: "Gestion du tiers payant",
                      enabled: false,
                      asset: "assets/icons/recherches (1).png"),
                  Competence(
                      nom: "Gestion des labos",
                      enabled: false,
                      asset: "assets/icons/TesttubeIcon.png"),
                ])),
        BlocProvider(create: (_) => UsersBlocBloc(userService: UserService())),
        BlocProvider(create: (_) => PharmacieBloc()),
        BlocProvider(create: (_)=> TitulaireBloc(titulaires: []),)
      ],
      child: const HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UsersBlocBloc>(context).add(GetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('en'), Locale('fr')],
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),
        scrollBehavior: MyBehavior(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: BlocBuilder<UsersBlocBloc, UsersBlocState>(
            builder: (context, state) {
          print(state);
         if(state is UserAdded) {
          
            return HomePage();
          }
          else{
            return const LogIn();

          }
        }),
      ),
    );
  }
}
