import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pharmabox/Home/HomePage.dart';
import 'package:pharmabox/Widgets/countContainer.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/Widgets/jobsbox.dart';
import 'package:pharmabox/Widgets/membersBox.dart';
import 'package:pharmabox/Widgets/pharmaciesbox.dart';
import '../Home/map.dart';
import '../Theme/text.dart';

class Explorer extends StatefulWidget {
  const Explorer({Key? key}) : super(key: key);

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  bool membres = true;
  bool pharmacies = true;
  bool jobs = true;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: appBarCustom(),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(child: appBarCustom()),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: height * 0.02,
                    // ),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(208, 209, 222, 1),
                        ),
                        borderRadius: BorderRadius.circular(30),
                        // color: Colors.red,
                      ),
                      width: width * 0.9,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Paris',
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
                      height: height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: HomePage(),
                            isIos: true,
                            duration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        height: height * 0.25,
                        child: Maps(),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Hero(
                                        tag: 'anim',
                                        child: Image(
                                          image: AssetImage(
                                            'assets/images/homeindicator.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '6 résultats',
                                    style: paragraph,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    membres = !membres;
                                  });
                                },
                                child: CountContainer(
                                  icon: membres
                                      ? Icons.keyboard_arrow_up_outlined
                                      : Icons.keyboard_arrow_down_outlined,
                                  count: 3,
                                  text: 'Membres',
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              membres
                                  ? Column(
                                      children: [
                                        MembersBox(
                                          image: 'assets/images/profile 1.png',
                                          name: 'Isabelle Rettig',
                                          zip: '94160',
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        MembersBox(
                                          image: 'assets/images/profile 2.png',
                                          name: 'Valerie Balague',
                                          zip: '75004',
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        MembersBox(
                                          image: 'assets/images/profile 3.png',
                                          name: 'Arnaud Roche',
                                          zip: '75016',
                                        ),
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    pharmacies = !pharmacies;
                                  });
                                },
                                child: CountContainer(
                                  icon: pharmacies
                                      ? Icons.keyboard_arrow_up_outlined
                                      : Icons.keyboard_arrow_down_outlined,
                                  count: 2,
                                  text: 'Pharmacies',
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              pharmacies
                                  ? Column(
                                      children: [
                                        PharmaciesBox(
                                          name: 'Jimmy Azoulay',
                                          zip: '75016',
                                          pharm: "Grande Pharmacie D'Aulnay",
                                          image: 'assets/images/profile 3.png',
                                          imagePharm:
                                              'assets/images/pharmacy 1.png',
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        PharmaciesBox(
                                          name: 'Valerie Balague',
                                          zip: '94160',
                                          pharm: "Citypharma",
                                          image: 'assets/images/profile 2.png',
                                          imagePharm:
                                              'assets/images/pharmacy 2.png',
                                        ),
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    jobs = !jobs;
                                  });
                                },
                                child: CountContainer(
                                  icon: jobs
                                      ? Icons.keyboard_arrow_up_outlined
                                      : Icons.keyboard_arrow_down_outlined,
                                  count: 1,
                                  text: 'Jobs',
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              jobs
                                  ? JobBox(
                                      zip: '75016',
                                      pharm: "Grande Pharmacie D'Aulnay",
                                      imagePharm:
                                          'assets/images/pharmacy 1.png',
                                    )
                                  : Container(),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
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
