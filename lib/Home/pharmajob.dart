import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Home/map.dart';
import 'package:pharmabox/Theme/text.dart';

import 'bottomNavbar.dart';

class PharmaJob extends StatefulWidget {
  const PharmaJob({Key? key}) : super(key: key);

  @override
  State<PharmaJob> createState() => _PharmaJobState();
}

class _PharmaJobState extends State<PharmaJob> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
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
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Recherche sur Google Maps',
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
                    SizedBox(
                      height: height * 0.05,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Flexible(
                  child: Maps(),
                )
                // const Maps(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: BottomNavbar(startIndex: 1),
                    isIos: true,
                    duration: Duration(milliseconds: 400),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: height * 0.07,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
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
                          '6 résultats',
                          style: paragraph,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
