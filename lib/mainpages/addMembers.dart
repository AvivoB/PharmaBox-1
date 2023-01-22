import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/customAppbar.dart';
import 'package:pharmabox/mainpages/reseau.dart';

class AddMember extends StatefulWidget {
  AddMember({Key? key}) : super(key: key);

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  bool cont1 = false;
  bool cont2 = false;
  bool cont3 = false;
  bool cont4 = false;
  bool cont5 = false;
  bool cont6 = false;
  bool cont7 = false;
  bool cont8 = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 246, 247, 1),
      appBar: appBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const  Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Image(
                    image: AssetImage('assets/images/backButton.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Container(
                  width: width * 0.92,
                  height: height * 1.25,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(31, 92, 103, 0.17),
                        offset: Offset(3, 3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: width * 0.85,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            'Importer carnet d’adresses téléphone',
                            style: heading,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont1 = true;
                                cont2 = true;
                                cont3 = true;
                                cont4 = true;
                                cont5 = true;
                                cont6 = true;
                                cont7 = true;
                                cont8 = true;
                              });
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Color.fromRGBO(66, 210, 255, 1),
                                ),
                                Text(
                                  'Sélectionner tous',
                                  style: blueNorm,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont1 = !cont1;
                              });
                            },
                            child: ReseauContainer(
                              change: cont1,
                              // color: Color.fromRGBO(239, 246, 247, 1),
                              color: Colors.white,
                              icon: 'image',
                              borderColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont2 = !cont2;
                              });
                            },
                            child: ReseauContainer(
                              change: cont2,
                              color: Color.fromRGBO(239, 246, 247, 1),
                              // color: Colors.white,
                              icon: 'image',
                              borderColor: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont3 = !cont3;
                              });
                            },
                            child: ReseauContainer(
                              change: cont3,
                              // color: Color.fromRGBO(239, 246, 247, 1),
                              color: Colors.white,
                              icon: 'icon',
                              borderColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont4 = !cont4;
                              });
                            },
                            child: ReseauContainer(
                              change: cont4,
                              color: Color.fromRGBO(239, 246, 247, 1),
                              // color: Colors.white,
                              icon: 'icon',
                              borderColor: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont5 = !cont5;
                              });
                            },
                            child: ReseauContainer(
                              change: cont5,
                              color: Color.fromRGBO(239, 246, 247, 1),
                              // color: Colors.white,
                              icon: 'icon',
                              borderColor: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont6 = !cont6;
                              });
                            },
                            child: ReseauContainer(
                              change: cont6,
                              // color: Color.fromRGBO(239, 246, 247, 1),
                              color: Colors.white,
                              icon: 'icon',
                              borderColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont7 = !cont7;
                              });
                            },
                            child: ReseauContainer(
                              change: cont7,
                              color: Color.fromRGBO(239, 246, 247, 1),
                              // color: Colors.white,
                              icon: 'icon',
                              borderColor: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont8 = !cont8;
                              });
                            },
                            child: ReseauContainer(
                              change: cont8,
                              // color: Color.fromRGBO(239, 246, 247, 1),
                              color: Colors.white,
                              icon: 'icon',
                              borderColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              width: width * 0.92,
              height: height * 0.065,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(124, 237, 172, 1),
                  Color.fromRGBO(66, 210, 255, 1),
                ]),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(31, 92, 103, 0.17),
                    offset: Offset(3, 3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Envoyer des invitations',
                    style: bigWhite,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
