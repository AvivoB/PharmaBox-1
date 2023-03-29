import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';
import 'package:pharmabox/constant.dart';
import 'package:pharmabox/general/widgets/present_field.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:pharmabox/offer/offer_screen.dart';
import 'package:pharmabox/pharmacyProfile/groupement_widget.dart';
import 'package:pharmabox/pharmacyProfile/pharmacie_nom_widget.dart';
import 'package:pharmabox/pharmacyProfile/profile_carousel.dart';
import 'package:pharmabox/pharmacyProfile/titulaires_widget.dart';
import 'package:skeletons/skeletons.dart';

import '../bloc/titulaires_bloc.dart';
import '../firebase/image_service.dart';
import 'pharmacie_content.dart';

///phromicy screen

class PharmacieHeader extends StatefulWidget {
  PharmacieHeader({Key? key}) : super(key: key);

  @override
  State<PharmacieHeader> createState() => _PharmacieHeaderState();
}

class _PharmacieHeaderState extends State<PharmacieHeader>
    with TickerProviderStateMixin {
  final List<String> _tabs = ['Profile', 'Offres'];
  late TabController tabController;
  TextEditingController pharmacyName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController presentation = TextEditingController();
  bool maitre = false;
  List<XFile?>? images;
  late List<CustomSwitch> switches;
  _showBottomSheet(BuildContext context) {
    ImageService imageService = ImageService();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () async {
                  images = await imageService.multiImagePicker();
                  if (images != null) {
                    BlocProvider.of<PharmacieBloc>(context).images = [
                      ...BlocProvider.of<PharmacieBloc>(context).images,
                      ...images!.map((element) => element!.path).toList()
                    ];
                    setState(() {});
                  }
                },
                title: const Text("Gallery"),
                leading: const Icon(Icons.image),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: _tabs.length, initialIndex: 0, vsync: this);
    BlocProvider.of<TitulaireBloc>(context).add(InitTitu());
    BlocProvider.of<PharmacieBloc>(context).add(GetPharmacie());
  }

  Pharmacie? myPharmacy;
  /////google places api usage;

  GlobalKey<FormState> formKey = GlobalKey();
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<PharmacieBloc, PharmacieState>(
        builder: (context, state) {
      if (state is PharmacieReady) {
        BlocProvider.of<TitulaireBloc>(context)
            .add(InitialiseTitulaire(titulaires: state.pharmacie.titulaires));
        BlocProvider.of<PharmacieBloc>(context).groupement =
            state.pharmacie.groupementName;
        BlocProvider.of<PharmacieBloc>(context).groupementImage =
            state.pharmacie.groupementImage;

        myPharmacy = state.pharmacie;
        maitre = myPharmacy!.maitre;
        pharmacyName.text = myPharmacy!.nom;
        name.text = myPharmacy!.nom;
        presentation.text = myPharmacy!.presentation;
        return SizedBox(
          height: height - 56,
          child: NestedScrollView(
            headerSliverBuilder: (context, should) => [
              SliverToBoxAdapter(
                child: Container(
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
                  )),
                  child: BlocProvider.of<PharmacieBloc>(context).images.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
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
                                        backgroundColor: const Color.fromRGBO(
                                          208,
                                          209,
                                          222,
                                          1,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Image.asset(
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
                                left: 0,
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
                        )
                      : MyCarouselSlider(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
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
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  height: height * 0.02,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: width,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      PharmacieNom(pharmacyName: pharmacyName),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TitulaireContainer(width: width, height: height),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ModifierGroupement(),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      PresentField(
                        label: 'Presentation',
                        maxLines: 2,
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
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height * 0.02,
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
                ),
              ),
            ],
            body: TabBarView(
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

                // const AdvisorTab(),
                //const Reseau(),
                const OfferScreen(),
              ],
            ),
          ),
        );
      } else {
        BlocProvider.of<LgoBloc>(context).add(InitialiseLgo(lgos: []));
        return SizedBox(
          height: height - 56,
          child: NestedScrollView(
            headerSliverBuilder: (context, should) => [
              SliverToBoxAdapter(
                child: Container(
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
                  child: BlocProvider.of<PharmacieBloc>(context).images.isEmpty
                      ? Stack(
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
                                      backgroundColor: const Color.fromRGBO(
                                        208,
                                        209,
                                        222,
                                        1,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Image.asset(
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
                              left: 0,
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
                        )
                      : MyCarouselSlider(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
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
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  height: height * 0.02,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      PharmacieNom(pharmacyName: pharmacyName),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TitulaireContainer(width: width, height: height),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ModifierGroupement(),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      PresentField(
                        label: 'Presentation',
                        maxLines: 2,
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
                    ]),
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
                ),
              )
            ],
            body: TabBarView(
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
                OfferScreen(),
              ],
            ),
          ),
        );
      }
    });
  }
}
