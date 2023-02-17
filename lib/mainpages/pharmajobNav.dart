import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Widgets/bottomsheet.dart';
import 'package:pharmabox/Widgets/jobsbox.dart';
import 'package:pharmabox/pharmacyProfile/MainPage.dart';

import '../Home/map.dart';
import '../Home/pharmajob.dart';
import '../Theme/text.dart';
import '../Widgets/customAppbar.dart';

class PharmaJobNav extends StatelessWidget {
  const PharmaJobNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(child: appBarCustom()),
            Container(
              height: height * 0.02,
              color: Colors.white,
            ),
            Container(
              height: height * 0.1,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(208, 209, 222, 1),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: width * 0.9,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.8,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Rechercher',
                                  border: InputBorder.none,
                                  icon: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.search,
                                      size: 25,
                                      color: Color.fromRGBO(208, 209, 222, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => FiltersBottomSheet(),
                                );
                              },
                              child: Image(
                                height: height * 0.04,
                                image: const AssetImage(
                                  'assets/icons/filter.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.04,
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: PharmaJob(),
                            isIos: true,
                            duration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: height * 0.2,
                        child: Maps(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                            image:
                                AssetImage('assets/images/homeindicator.png'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '2 résultats',
                          style: paragraph,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PharmacyProfile(),
                          ),
                        );
                      },
                      child: JobBox(
                        zip: '75016',
                        pharm: "Grande Pharmacie D'Aulnay",
                        imagePharm: 'assets/images/pharmacy 1.png',
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PharmacyProfile(),
                          ),
                        );
                      },
                      child: JobBox(
                        zip: '94160',
                        pharm: "Citipharma",
                        imagePharm: 'assets/images/pharmacy 2.png',
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
