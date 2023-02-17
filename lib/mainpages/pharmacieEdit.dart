import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';
import 'package:pharmabox/constant.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:pharmabox/offer/offer_screen.dart';
import 'package:pharmabox/pharmacyProfile/titulaires_widget.dart';
import 'package:pharmabox/tabview/Advisor.dart';
import 'package:pharmabox/tabview/Reseau.dart';

import '../Widgets/space_values.dart';
import '../firebase/image_service.dart';
import '../pharmacyProfile/pharmacieprofil.dart';
import '../pharmacyProfile/textfield.dart';

///phromicy screen

class PharmacieEdit extends StatefulWidget {
  final Pharmacie? myPharmacy;
  PharmacieEdit({Key? key, required this.myPharmacy}) : super(key: key);

  @override
  State<PharmacieEdit> createState() => _PharmacieEditState();
}

class _PharmacieEditState extends State<PharmacieEdit>
    with TickerProviderStateMixin {
  final List<String> _tabs = ['Profil', 'Advisor', 'Réseau', 'Offres'];
  late TabController tabController;
  TextEditingController pharmacyName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController presentation = TextEditingController();
  bool maitre = false;
  late List<CustomSwitch> switches;
  Pharmacie? myPharmacy;
  @override
  void initState() {
    super.initState();

    tabController =
        TabController(length: _tabs.length, initialIndex: 0, vsync: this);
    Pharmacie? pharmacie = widget.myPharmacy;
    if (pharmacie != null) {
      myPharmacy = pharmacie;
      maitre = myPharmacy!.maitre;
      pharmacyName.text = myPharmacy?.nom ?? '';
      name.text = myPharmacy?.nom ?? '';
      presentation.text = myPharmacy?.presentation ?? '';
    }
  }

  final List<String> imgList = [
    'assets/images/PharmacyMain.png',
    'assets/images/pharmacy 2.png',
  ];
  XFile? image;
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
                        BlocProvider.of<PharmacieBloc>(context).imagePath =
                            image!.path;
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
                        BlocProvider.of<PharmacieBloc>(context).imagePath =
                            image!.path;
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

  GlobalKey<FormState> formKey = GlobalKey();
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      // appBar: appBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(127, 127, 213, 1),
                    Color.fromRGBO(134, 168, 231, 1),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spaces.y7,
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
                                backgroundImage: image != null
                                    ? FileImage(File(
                                        image!.path,
                                      ))
                                    : null,
                                backgroundColor: const Color.fromRGBO(
                                  208,
                                  209,
                                  222,
                                  1,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: image != null
                                      ? null
                                      : Image.asset(
                                          'assets/images/pharma_img.png',
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                     Positioned(
                          bottom: 3,
                          right: 0,
                          child:   GestureDetector(
                        onTap: () {
                          _showBottomSheet(context);
                        },
                        child:Card(
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
                  Spaces.y3,
                ],
              ),
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
              child: Form(
                key: formKey,
                child: Column(children: [
                  CustomPharmacyTextField(
                    label: 'Nom pharmacie',
                    prefixIcon: Icon(Icons.local_hospital),
                    controller: pharmacyName,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TitulaireContainer(width: width, height: height),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        ModifierContainer(),
                      ],
                    ),
                  ),*/
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomPharmacyTextField(
                    label: 'Presentation',
                    maxLines: 10,
                    controller: presentation,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Image(
                            image: const AssetImage(
                                'assets/icons/universityIcon.png'),
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
                        CustomSwitch(
                            initialSwitchValue: maitre,
                            onTap: (val) {
                              setState(() {
                                maitre = !maitre;
                              });
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ]),
              ),
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
                  ProfilEditPharmacy(
                    formKey: formKey,
                    pharNameController: pharmacyName,
                    pharUserNameController: name,
                    pharDesController: presentation,
                    maitre: maitre,
                    myPharmacy: myPharmacy,
                  ),
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
