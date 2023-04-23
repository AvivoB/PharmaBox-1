import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharmabox/Onboarding/SignUp.dart';
import 'package:pharmabox/bloc/chat_display_bloc.dart';
import 'package:pharmabox/bloc/chat_managment_bloc.dart';
import 'package:pharmabox/bloc/discussions_bloc.dart';
import 'package:pharmabox/bloc/lgosearch_bloc.dart';
import 'package:pharmabox/bloc/mainmap_bloc.dart';
import 'package:pharmabox/bloc/membres_gestion_bloc.dart';
import 'package:pharmabox/bloc/membres_titualaires_reseau_bloc.dart';
import 'package:pharmabox/bloc/navigation_bloc.dart';
import 'package:pharmabox/bloc/recherche_pharmajob_bloc.dart';
import 'package:pharmabox/bloc/verifier_membre_bloc.dart';
import 'package:pharmabox/firebase/notifications_service.dart';
import 'package:pharmabox/mainpages/HomePage.dart';
import 'package:pharmabox/bloc/groupement_bloc.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/bloc/pharmacierecherche_bloc.dart';
import 'package:pharmabox/bloc/recherche_bloc.dart';
import 'package:pharmabox/bloc/titulaires_bloc.dart';
import 'package:pharmabox/business_logic/competences_bloc/competences_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';
import 'package:pharmabox/business_logic/specialisations_bloc/specialisations_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/firebase/users_calls.dart';
import 'package:pharmabox/mainpages/splash_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';
import 'dart:typed_data';

import 'bloc/specialisationsearch_bloc.dart';
import 'business_logic/experiences_bloc/experiences_bloc.dart';
import 'business_logic/langues_bloc/langues_bloc.dart';
import 'business_logic/universites_bloc/universites_bloc.dart';
import 'lang/translation_service.dart';
import 'model/competence.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  await showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

final onNotifications = BehaviorSubject<String?>();

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
bool isFlutterLocalNotificationsInitialized = false;
Future<void> setupFlutterNotifications() async {
  const ios = IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  const android = AndroidInitializationSettings("@mipmap/ic_launcher");
  await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onSelectNotification: (payload) async => {onNotifications.add(payload)});
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );
  print("here");
  isFlutterLocalNotificationsInitialized = true;
}

Future showFlutterNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    print(channel.name);
    await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            ticker: 'ticker',
            priority: Priority.high,
            additionalFlags: Int32List.fromList([67108864]),
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
        payload: "payload");
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [
    Permission.location,
    Permission.storage,
  ].request();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  //flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Received notification: ${message.notification!.title}');
    await _firebaseMessagingBackgroundHandler(message);
  });

  // Set the background messaging handler early on, as a named top-level function
  /* FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }*/

  /*await Firebase.initializeApp();
  await NotificationsService.init();
  await [
    Permission.location,
    Permission.storage,
  ].request();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  alert: true, // Required to display a heads up notification
  badge: true,
  sound: true,
);
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

await flutterLocalNotificationsPlugin
  .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  ?.createNotificationChannel(channel);
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  _firebaseMessaging.requestPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            icon: android.smallIcon,
            // other properties...
          ),
        ));
  }
});
 /* FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.data.containsKey('message') &&
        message.data.containsKey('recipientToken') &&
        message.data['recipientToken'] ==
            FirebaseMessaging.instance.getToken()) {
      String messageContent = message.data['message'];
      NotificationsService.showScheduledNotifcation(
          body: messageContent,
          title: 'Message',
          id: messageContent.length,
          payload: 'payload',
          scheduledDate: DateTime.now());
    }
  });*/*/
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

/*    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(
            () {
              print(value?.data.toString());
            },
          ),
        );

    //FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = UsersBlocBloc(userService: UserService());
    final membresBloc = MembresBloc();
    final offresBloc = OffresBloc();
    final pharmacieRechercheBloc = PharmacierechercheBloc();
    final membreTitulairesBloc = MembresTitualairesReseauBloc();
    final recherchesJobBloc = RecherchePharmajobBloc();
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
                  Competence(
                      nom: "TROD",
                      enabled: false,
                      asset: "assets/icons/trod.png"),
                ])),
        BlocProvider(create: (_) => authenticationBloc),
        BlocProvider(create: (_) => PharmacieBloc()),
        BlocProvider(create: (_) => GroupementBloc()),
        BlocProvider(
          create: (_) =>
              TitulaireBloc(titulaires: [], usersBlocBloc: authenticationBloc),
        ),
        BlocProvider(
          create: (_) => offresBloc,
        ),
        BlocProvider(
          create: (_) => RechercheBloc(),
        ),
        BlocProvider(
          create: (_) => membresBloc,
        ),
        BlocProvider(
          create: (_) => pharmacieRechercheBloc,
        ),
          BlocProvider(
          create: (_) => recherchesJobBloc,
        ),
        BlocProvider(
          create: (_) => MainmapBloc(
              membresBloc: membresBloc,
              offresBloc: offresBloc,
              recherchePharmajobBloc: recherchesJobBloc,
              pharmacierechercheBloc: pharmacieRechercheBloc),
        ),
        BlocProvider(create: (_) => LgosearchBloc()),
        BlocProvider(create: (_) => SpecialisationsearchBloc()),
        BlocProvider(
          create: (context) => DiscussionsBloc(),
        ),
        BlocProvider(create: (context) => ChatManagmentBloc()),
        BlocProvider(create: (context) => ChatDisplayBloc()),
        BlocProvider(
            create: (_) =>
                NavigationBloc(authenticationBloc: authenticationBloc)),
        BlocProvider(
          create: (_) => membreTitulairesBloc,
        ),
        BlocProvider(
          create: (_) => VerifierMembreBloc(),
        ),
        BlocProvider(
          create: (_) => MembresGestionBloc(
              membresTitualairesReseauBloc: membreTitulairesBloc,
              membresBloc: membresBloc),
        ),
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
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate
              ],
              //supportedLocales: const [Locale('en'), Locale('fr')],
              locale: TranslationService.locale,
              fallbackLocale: TranslationService.fallbackLocale,
              translations: TranslationService(),
              scrollBehavior: MyBehavior(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Poppins',
                primaryColor: Color.fromRGBO(124, 237, 172, 1),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                ),
              ),
              home: SafeArea(
                child: Scaffold(
                  body: BlocBuilder<UsersBlocBloc, UsersBlocState>(
                      buildWhen: (previous, current) =>
                          !(previous is UserAdded && current is UserLoading),
                      builder: (context, state) {
                        if (state is UserAdded) {
                          return HomePage();
                        } else if (state is UserLoading) {
                          return const Center(child: SplashScreen());
                        } else {
                          return const SignUp();
                        }
                      }),
                ),
              ),
            ));
  }
}
