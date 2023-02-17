import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/button.dart';
import 'package:pharmabox/importContacts/importbyemail.dart';
import 'package:pharmabox/mainpages/addMembers.dart';

import '../Widgets/countContainer.dart';
import '../Widgets/customAppbar.dart';
import '../Widgets/jobsbox.dart';
import '../Widgets/membersBox.dart';
import '../Widgets/pharmaciesbox.dart';

class ReseauTab extends StatefulWidget {
  const ReseauTab({Key? key}) : super(key: key);

  @override
  State<ReseauTab> createState() => _ReseauTabState();
}

class _ReseauTabState extends State<ReseauTab> {
  bool membres1 = true;
  bool membres2 = true;
  bool pharmacies = true;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarCustom(),
      backgroundColor: const Color.fromRGBO(239, 246, 247, 1),
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mon réseau",
                      style: heading,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return const ReseauBottomSheet();
                            });
                      },
                      child: Image(
                        height: height * 0.06,
                        image: const AssetImage('assets/images/Button Add.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    membres1 = !membres1;
                  });
                },
                child: CountContainer(
                  icon: membres1
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  count: 1,
                  text: 'Membres titulaires',
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              membres1
                  ? MembersBoxDelete(
                      image: 'assets/images/profile 3.png',
                      name: 'Arnaud Roche',
                      zip: 'removeDelete',
                      text: "Grande Pharmacie\n D'Aulnay, 94160,\n Paris",
                      icon: Icons.local_hospital,
                    )
                  : Container(),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    membres2 = !membres2;
                  });
                },
                child: CountContainer(
                  icon: membres2
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  count: 1,
                  text: 'Membres titulaires',
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              membres2
                  ? Column(
                      children: [
                        MembersBoxDelete(
                          image: 'assets/images/profile 1.png',
                          name: 'Isabelle Rettig',
                          zip: 'removeDelete',
                          text: '94161, Paris',
                          icon: Icons.location_on_outlined,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        MembersBoxDelete(
                          image: 'assets/images/profile 2.png',
                          name: 'Valerie Balague',
                          zip: 'removeDelete',
                          icon: Icons.location_on_outlined,
                          text: '94160, Paris',
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
                          imagePharm: 'assets/images/pharmacy 1.png',
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        PharmaciesBox(
                          name: 'Valerie Balague',
                          zip: '94160',
                          pharm: "Citypharma",
                          image: 'assets/images/profile 2.png',
                          imagePharm: 'assets/images/pharmacy 2.png',
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReseauContainer extends StatelessWidget {
  bool change;
  var color;
  var borderColor;
  var icon;
  ReseauContainer(
      {Key? key, this.color, this.borderColor, this.icon, required this.change})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.88,
      height: height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(color: change == false ? Colors.white : Colors.blue),
        color:
            change == false ? Colors.white : Color.fromRGBO(239, 246, 247, 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(31, 92, 103, 0.17),
            offset: Offset(3, 3),
            blurRadius: 4,
          ),
        ],
      ),
      child: ListTile(
        leading: icon == 'image'
            ? Image(
                width: width * 0.14,
                fit: BoxFit.cover,
                image: const AssetImage(
                  'assets/images/profile 1.png',
                ),
              )
            : CircleAvatar(
                radius: 25,
                backgroundColor: Color.fromRGBO(208, 209, 222, 1),
                child: Image(
                  image: AssetImage('assets/images/userReseau.png'),
                  width: width * 0.08,
                ),
              ),
        title: const Text(
          'Isabelle Rettig',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          'Amis depuis: 12/02/2022',
          style: normGrey,
        ),
      ),
    );
  }
}

class ReseauBottomSheet extends StatelessWidget {
  const ReseauBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Image(
                  height: 20,
                  color: Color.fromRGBO(89, 90, 113, 1),
                  image: AssetImage('assets/icons/Google.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Importer carnet d'adresses Gmail",
                  style: paragraph,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Image(
                  height: 20,
                  color: Color.fromRGBO(89, 90, 113, 1),
                  image: AssetImage('assets/icons/meta.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Importer carnet d'adresses Facebook",
                  style: paragraph,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => AddMember()),
                ),
              );
            },
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.phone,
                    color: Color.fromRGBO(89, 90, 113, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Importer carnet d'adresses téléphone",
                    style: paragraph,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => EmailImport()),
                ),
              );
            },
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.mail_outline,
                    color: Color.fromRGBO(89, 90, 113, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Envoyer des invitations par email',
                    style: paragraph,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
