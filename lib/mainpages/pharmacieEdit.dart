import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/constant.dart';
import 'package:pharmabox/general/widgets/custom_textfield_with_dropdown.dart';
import 'package:pharmabox/model/pharmacy_model.dart';
import 'package:pharmabox/offer/offer_screen.dart';
import 'package:pharmabox/pharmacyProfile/pharmacy_controller.dart';
import 'package:pharmabox/tabview/Advisor.dart';
import 'package:pharmabox/tabview/ProfilTab.dart';
import 'package:pharmabox/tabview/Reseau.dart';
import 'package:sizer/sizer.dart';

import '../Theme/color.dart';
import '../Widgets/space_values.dart';
import '../pharmacyProfile/pharmacieprofil.dart';
import '../pharmacyProfile/textfield.dart';

///phromicy screen

class PharmacieEdit extends StatefulWidget {
  PharmacyModel? myPharmacy;

  PharmacieEdit({Key? key, this.myPharmacy}) : super(key: key);

  PharmacyController pharmacyController = Get.find();

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

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: _tabs.length, initialIndex: 0, vsync: this);

    Future.delayed(const Duration(seconds: 1), () {
      widget.pharmacyController.getMyPharmacy((pharmacy) {
        if (pharmacy != null) {
          setState(() {
            widget.myPharmacy = pharmacy;
            pharmacyName.text = widget.myPharmacy?.pharName ?? '';
            name.text = widget.myPharmacy?.userName ?? '';
            presentation.text = widget.myPharmacy?.des ?? '';
          });
        }
      });
    });

  }

  final List<String> imgList = [
    'assets/images/PharmacyMain.png',
    'assets/images/pharmacy 2.png',
  ];

  int _current = 0;
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
            // CarouselSlider(
            //   carouselController: _controller,
            //   options: CarouselOptions(
            //     onPageChanged: (index, reason) {
            //       setState(() {
            //         _current = index;
            //       });
            //     },
            //     height: height * 0.4,
            //     viewportFraction: 1,
            //   ),
            //   items: imgList.map((i) {
            //     return Builder(
            //       builder: (BuildContext context) {
            //         return Container(
            //           height: height * 0.4,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             image: DecorationImage(
            //               fit: BoxFit.cover,
            //               image: AssetImage(
            //                 i,
            //               ),
            //             ),
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               SizedBox(
            //                 width: width * 0.9,
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Row(
            //                           children: const [
            //                             Image(
            //                               image: AssetImage(
            //                                 'assets/icons/camerawhite.png',
            //                               ),
            //                             ),
            //                             Image(
            //                               image: AssetImage(
            //                                 'assets/icons/deletewhite.png',
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         Padding(
            //                           padding:
            //                               const EdgeInsets.only(bottom: 10.0),
            //                           child: Container(
            //                             decoration: const BoxDecoration(
            //                               borderRadius: BorderRadius.all(
            //                                 Radius.circular(15),
            //                               ),
            //                               boxShadow: [
            //                                 BoxShadow(
            //                                   color: Color.fromRGBO(
            //                                       31, 92, 103, 0.17),
            //                                   offset: Offset(3, 3),
            //                                   blurRadius: 3,
            //                                 ),
            //                               ],
            //                             ),
            //                             child: Row(
            //                               children: [
            //                                 Container(
            //                                   decoration: BoxDecoration(
            //                                     color: lightGreen,
            //                                     borderRadius:
            //                                         const BorderRadius.only(
            //                                       topLeft: Radius.circular(15),
            //                                       bottomLeft:
            //                                           Radius.circular(15),
            //                                     ),
            //                                   ),
            //                                   width: width * 0.18,
            //                                   height: height * 0.05,
            //                                   child: Row(
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .spaceEvenly,
            //                                     children: [
            //                                       const Icon(
            //                                         Icons.thumb_up_alt_outlined,
            //                                         color: Colors.white,
            //                                         size: 25,
            //                                       ),
            //                                       Text(
            //                                         '535',
            //                                         style: headingWhite,
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Container(
            //                                   decoration: const BoxDecoration(
            //                                     color: Colors.white,
            //                                     borderRadius: BorderRadius.only(
            //                                       topRight: Radius.circular(15),
            //                                       bottomRight:
            //                                           Radius.circular(15),
            //                                     ),
            //                                   ),
            //                                   width: width * 0.08,
            //                                   height: height * 0.05,
            //                                   child: const Icon(
            //                                     Icons.arrow_forward_ios_rounded,
            //                                     color: Color.fromRGBO(
            //                                         89, 90, 113, 1),
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children:
            //                           imgList.asMap().entries.map((entry) {
            //                         return GestureDetector(
            //                           onTap: () =>
            //                               _controller.animateToPage(entry.key),
            //                           child: Container(
            //                             width: 8.0,
            //                             height: 8.0,
            //                             margin: EdgeInsets.symmetric(
            //                                 vertical: 8.0, horizontal: 4.0),
            //                             decoration: BoxDecoration(
            //                                 shape: BoxShape.circle,
            //                                 color:
            //                                     (Theme.of(context).brightness ==
            //                                                 Brightness.dark
            //                                             ? Colors.white
            //                                             : Colors.black)
            //                                         .withOpacity(
            //                                             _current == entry.key
            //                                                 ? 0.9
            //                                                 : 0.4)),
            //                           ),
            //                         );
            //                       }).toList(),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     );
            //   }).toList(),
            // ),

            ///add image view
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
                  Image.asset(
                    'assets/images/pharma_img.png',
                    height: 20.h,
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
              child: Column(children: [
                CustomPharmacyTextField(
                  label: 'Nom pharmacie',
                  prefixIcon: Icon(Icons.local_hospital),
                  controller: pharmacyName,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomPharmacyTextField(
                  label: 'Titulaire',
                  prefixIcon: Icon(Icons.person),
                  controller: name,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.add,
                      color: Color.fromRGBO(66, 210, 255, 1),
                    ),
                    Text(
                      'Ajouter titulaire',
                      style: TextStyle(
                          color: Color.fromRGBO(66, 210, 255, 1), fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
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
                ),
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
                      CustomSwitch(),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ]),
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
                    pharNameController: pharmacyName,
                    pharUserNameController: name,
                    pharDesController: presentation,
                    myPharmacy: widget.myPharmacy,
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
