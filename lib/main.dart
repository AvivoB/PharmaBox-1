import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pharmabox/Home/HomePage.dart';
import 'package:pharmabox/Home/bottomNavbar.dart';
import 'package:pharmabox/Onboarding/Login.dart';
import 'package:pharmabox/Onboarding/SignUp.dart';
import 'package:pharmabox/mainpages/pharmacieEdit.dart';
import 'package:pharmabox/member_registration/member_registration_screen.dart';
import 'package:sizer/sizer.dart';

import 'lang/translation_service.dart';
import 'local/my_hive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await MyHive.init();
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
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('en'), Locale('fr')],
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),

        scrollBehavior: MyBehavior(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                //return MemberRegistrationScreen();
                return SignUp();
              }
            }),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
