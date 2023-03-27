/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';
import 'package:pharmabox/Widgets/membersBox.dart';

import '../general/widgets/custom_elevated_button.dart';
import '../general/widgets/custom_registration_textfield.dart';

class ContainerAdvisor extends StatelessWidget {
  var logo;
  var text;
  ContainerAdvisor({
    Key? key,
    this.logo,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: height * 0.1,
      width: width * 0.9,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(242, 253, 255, 1),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                image: AssetImage(logo),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Text(
                text,
                style: heading,
              ),
            ],
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
                    return Container(
                      height: height * 0.52,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ajouter advisor',
                                  style: heading,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image(
                            height: height * 0.2,
                            image: const AssetImage(
                              'assets/icons/winpharma.png',
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomRegistrationTextField(
                            label: 'Nom advisor',
                            prefixIcon: const Icon(
                              CupertinoIcons.person,
                            ),
                            controller: controller,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomElevatedButton(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF7CEDAC),
                                Color(0xFF42D2FF),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width,
                            onPressed: () {},
                            borderRadius: BorderRadius.circular(15),
                            child: const Text(
                              'Enregistrer',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const AjouterContainer()),
        ],
      ),
    );
  }
}

class AdvisorTabContainer extends StatelessWidget {
  var logo;
  var text;
  AdvisorTabContainer({
    Key? key,
    this.logo,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: height * 0.1,
      width: width * 0.9,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(242, 253, 255, 1),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                image: AssetImage(logo),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Text(
                text,
                style: heading,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContainerAdvisor2 extends StatelessWidget {
  var logo;
  var text;
  var number;
  var icon;
  ContainerAdvisor2({
    Key? key,
    this.logo,
    this.text,
    this.number,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: height * 0.1,
      width: width * 0.9,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(242, 253, 255, 1),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 35,
                color: Colors.grey,
              ),
              Image(
                image: AssetImage(
                  logo,
                ),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Text(
                "$text ($number)",
                style: heading,
              ),
            ],
          ),
          Row(
            children: [
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
                      return Container(
                        height: height * 0.52,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ajouter advisor',
                                    style: heading,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image(
                              height: height * 0.2,
                              image: const AssetImage(
                                'assets/icons/winpharma.png',
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomRegistrationTextField(
                              label: 'Nom advisor',
                              prefixIcon: const Icon(
                                CupertinoIcons.person,
                              ),
                              controller: controller,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomElevatedButton(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF7CEDAC),
                                  Color(0xFF42D2FF),
                                ],
                              ),
                              width: MediaQuery.of(context).size.width,
                              onPressed: () {},
                              borderRadius: BorderRadius.circular(15),
                              child: const Text(
                                'Enregistrer',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: AjouterContainer(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ExtensionWidget extends StatefulWidget {
  var name;
  var image;
  ExtensionWidget({Key? key, this.image, this.name}) : super(key: key);

  @override
  State<ExtensionWidget> createState() => _ExtensionWidgetState();
}

class _ExtensionWidgetState extends State<ExtensionWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: height * 0.17,
      width: width * 0.9,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
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
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(
                      height: height * 0.05,
                      fit: BoxFit.cover,
                      image: AssetImage(
                        widget.image,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      widget.name,
                      style: paragraph,
                    ),
                  ],
                ),
                LikeButton(isLiked: false),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 4,
              right: 4,
            ),
            width: width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    ModifierContainer(),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: Color.fromRGBO(248, 153, 153, 1),
                    ),
                    Text(
                      'Supprimer',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(248, 153, 153, 1),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
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
                  width: width * 0.25,
                  height: height * 0.05,
                  child: Center(
                    child: Icon(
                      Icons.thumb_down_alt_outlined,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ExtensionWidget2 extends StatefulWidget {
  var name;
  var image;
  ExtensionWidget2({Key? key, this.image, this.name}) : super(key: key);

  @override
  State<ExtensionWidget2> createState() => _ExtensionWidget2State();
}

class _ExtensionWidget2State extends State<ExtensionWidget2> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: height * 0.17,
      width: width * 0.9,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
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
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(
                      height: height * 0.05,
                      fit: BoxFit.cover,
                      image: AssetImage(
                        widget.image,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      widget.name,
                      style: paragraph,
                    ),
                  ],
                ),
                LikeButton(isLiked: false),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 4,
              right: 4,
            ),
            width: width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
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
                  width: width * 0.25,
                  height: height * 0.05,
                  child: Center(
                    child: Icon(
                      Icons.thumb_down_alt_outlined,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
*/