import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/business_logic/specialisations_bloc/specialisations_bloc.dart';
import 'package:pharmabox/business_logic/universites_bloc/universites_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/firebase/image_service.dart';
import 'package:pharmabox/general/widgets/present_field.dart';
import 'package:pharmabox/member_registration/code_postal.dart';

import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:pharmabox/offer/recherches_screen.dart';

import 'package:pharmabox/profile_tabs/profile_membre_content.dart';

import '../business_logic/competences_bloc/competences_bloc.dart';
import '../business_logic/experiences_bloc/experiences_bloc.dart';
import '../business_logic/langues_bloc/langues_bloc.dart';
import '../business_logic/lgo_bloc/lgo_bloc.dart';
import '../constants.dart';
import '../general/widgets/custom_registration_date_picker.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../model/localisation.dart';
import '../model/telephone.dart';

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
  final List<String> _tabs = ['Profile', 'Recherches'];
  late List<bool> conditions;

  late TabController tabController;
  late NonTitulaire? user;
  ScrollController controller = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLocalImage(String imageUrl) {
    return imageUrl.startsWith('/data/');
  }

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: _tabs.length, initialIndex: 0, vsync: this);
    user = BlocProvider.of<UsersBlocBloc>(context).state.user;
    if (user != null) {
      BlocProvider.of<LgoBloc>(context).add(InitialiseLgo(lgos: user!.lgos));
      firstNameController.text = user!.nom;
      lastNameController.text = user!.prenom;
      jobTitleController.text = user!.poste;
      phoneController.text = user!.telephone.numeroTelephone.toString();
      postalCodeController.text = user!.localisation.codePostal.toString();
      emailController.text = user?.email ?? '';
      dateOfBirthController.text = user?.dateNaissance ?? '';
      addressController.text = user?.localisation.ville ?? '';
      imgPath = user!.photoUrl;
      conditions = List.generate(2, (index) => false);
      conditions[0] =
          BlocProvider.of<UsersBlocBloc>(context).state.user!.droitOffres;
      conditions[1] = BlocProvider.of<UsersBlocBloc>(context)
          .state
          .user!
          .accepterConditions;
    }
  }

  late ExperiencesBloc _experiencesBloc;
  late UniversitesBloc _universitesBloc;
  late CompetencesBloc _competencesBloc;
  late SpecialisationsBloc _specialisationsBloc;
  late LanguesBloc _languesBloc;
  late LgoBloc _lgoBloc;
  late UsersBlocBloc _usersBlocBloc;
  @override
  void didChangeDependencies() {
    _experiencesBloc = BlocProvider.of<ExperiencesBloc>(context);
    _universitesBloc = BlocProvider.of<UniversitesBloc>(context);
    _specialisationsBloc = BlocProvider.of<SpecialisationsBloc>(context);
    _languesBloc = BlocProvider.of<LanguesBloc>(context);
    _competencesBloc = BlocProvider.of<CompetencesBloc>(context);
    _lgoBloc = BlocProvider.of<LgoBloc>(context);
    _usersBlocBloc = BlocProvider.of<UsersBlocBloc>(context);
    super.didChangeDependencies();
  }

  String? imgPath;
  XFile? image;

  @override
  void dispose() {
    print(_lgoBloc.state.lgos.length);

    // TODO: implement didChangeDependencies
    NonTitulaire nonTitulaire = NonTitulaire.creation(
        nom: firstNameController.text,
        specialisations: _specialisationsBloc.state.specialisations,
        prenom: lastNameController.text,
        photoUrl: _usersBlocBloc.currentUser!.photoUrl,
        presentation: descriptionController.text,
        email: emailController.text,
        telephone: Telephone(
            numeroTelephone: int.parse(phoneController.text), visible: false),
        poste: jobTitleController.text,
        experiences: _experiencesBloc.state.experiences,
        lgos: _lgoBloc.state.lgos,
        universites: _universitesBloc.state.universities,
        naissance: dateOfBirthController.text,
        langues: _languesBloc.state.langues,
        localisation: Localisation(
            codePostal: int.parse(postalCodeController.text),
            ville: addressController.text),
        competences: _competencesBloc.state.competences,
        droitOffres: conditions[0],
        accepterConditions: conditions[1]);
    _usersBlocBloc.add(AddUser(user: nonTitulaire));
    super.dispose();
  }

  _showBottomSheet(BuildContext context) {
    ImageService imageService = ImageService();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: ListTile(
                    onTap: () async {
                      image = await imageService.pickImageFromGallery();
                      if (image != null) {
                        _usersBlocBloc.imagePath = image!.path;
                        _usersBlocBloc.currentUser!.photoUrl = image!.path;
                      }
                      setState(() {});
                    },
                    title: const Text("Gallery"),
                    leading: Icon(Icons.image),
                  ),
                ),
                Container(
                  child: ListTile(
                    onTap: () async {
                      image = await imageService.pickImageFromCamera();
                      if (image != null) {
                        _usersBlocBloc.imagePath = image!.path;
                        _usersBlocBloc.currentUser!.photoUrl = image!.path;
                      }
                      setState(() {});
                    },
                    title: const Text("Camera"),
                    leading: Icon(Icons.camera),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    ImageService imageService = ImageService();
    return SizedBox(
      height: height - 56,
      child: NestedScrollView(
        headerSliverBuilder: (context, val) => [
          SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: height * 0.2,
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
                              Container(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 65,
                                        backgroundImage: BlocProvider.of<
                                                        UsersBlocBloc>(context)
                                                    .currentUser!
                                                    .photoUrl ==
                                                ''
                                            ? AssetImage(
                                                'assets/images/user.png')
                                            : isLocalImage(BlocProvider.of<
                                                        UsersBlocBloc>(context)
                                                    .currentUser!
                                                    .photoUrl)
                                                ? FileImage(File(BlocProvider.of<
                                                        UsersBlocBloc>(context)
                                                    .currentUser!
                                                    .photoUrl))
                                                : NetworkImage(BlocProvider.of<
                                                        UsersBlocBloc>(context)
                                                    .currentUser!
                                                    .photoUrl) as ImageProvider,
                                        backgroundColor: const Color.fromRGBO(
                                          208,
                                          209,
                                          222,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context);
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    elevation: 10,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          5,
                                        ),
                                        child: Image.asset(
                                          'assets/images/Vector.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                user?.nom ?? '',
                                style: bigWhite,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                user?.poste ?? '',
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
                                      color: Color.fromRGBO(31, 92, 103, 0.17),
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
                                        borderRadius: const BorderRadius.only(
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
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      width: width * 0.08,
                                      height: height * 0.05,
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color.fromRGBO(89, 90, 113, 1),
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
                )),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  CodePostalWidget(
                    localisationController: postalCodeController,
                    villeController: addressController,
                  ),
                  // VilleWidget(pharmacyName: addressController),
                  CustomRegistrationTextField(
                    label: 'Ville',
                    prefixIcon: const Icon(
                      CupertinoIcons.location,
                    ),
                    controller: addressController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: PresentField(
                      label: 'Presentation',
                      padding: 20,
                      prefixIcon: const Icon(
                        Icons.location_city_outlined,
                      ),
                      controller: descriptionController,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
            height: height * 0.07,
            child: TabBar(
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
              indicator: const BoxDecoration(
                gradient: kTabBarIndicatorGradient,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              indicatorWeight: 0.1,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: const EdgeInsets.only(
                top: 50,
                //left: 15,
                //right: 15,
              ),
              controller: tabController,
              tabs: _tabs.map((element) => Text(element)).toList(),
            ),
          )),
        ],
        body: TabBarView(
          controller: tabController,
          children: [
            ProfilTabEdit(
              conditions: conditions,
              callbacks: [
                (val) {
                  setState(() {
                    conditions[0] = !conditions[0];
                  });
                },
                (val) {
                  setState(() {
                    conditions[1] = !conditions[1];
                  });
                }
              ],
            ),
            //AdvisorTabEdit(),
            // ReseauEdit(),
            RechercheScreen(),
          ],
        ),
      ),
    );
  }
}
