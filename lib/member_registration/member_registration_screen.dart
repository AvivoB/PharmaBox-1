import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharmabox/Home/HomePage.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/utility.dart';
import 'package:pharmabox/constant.dart';
import 'package:pharmabox/general/regTextFieldAjouter.dart';
import 'package:pharmabox/general/widgets/custom_registration_date_picker.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';
import 'package:pharmabox/general/widgets/custom_slider_with_gradient.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';

import 'package:pharmabox/general/widgets/custom_elevated_button.dart';
import 'package:pharmabox/local/my_hive.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/bottomsheet.dart';
import '../Widgets/gradientText.dart';
import '../Widgets/my_image_picker.dart';
import '../Widgets/space_values.dart';
import '../model/user_model.dart';

import 'dart:convert';
import 'dart:io';

part 'member_registration_header.dart';

class MemberRegistrationScreen extends StatefulWidget {
  const MemberRegistrationScreen({super.key});

  @override
  State<MemberRegistrationScreen> createState() =>
      _MemberRegistrationScreenState();
}

class _MemberRegistrationScreenState extends State<MemberRegistrationScreen> {
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
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();

    var user = FirebaseAuth.instance.currentUser;
    emailController.text = user?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
           MemberRegistrationAppBar(),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomRegistrationTextField(
                    label: 'Nom',
                    prefixIcon: const Icon(
                      CupertinoIcons.person,
                    ),
                    controller: lastNameController,
                  ),
                  CustomRegistrationTextField(
                    label: 'Prénom',
                    prefixIcon: const Icon(
                      CupertinoIcons.person,
                    ),
                    controller: firstNameController,
                  ),
                  Stack(
                    children: [
                      CustomRegistrationTextField(
                        label: 'Poste',
                        prefixIcon: const Icon(
                          CupertinoIcons.bag,
                        ),
                        controller: jobTitleController,
                        textInputType: TextInputType.none,
                      ),
                      Positioned(
                        right: 7.w,
                        child: DropdownButton<String>(
                          items: <String>[
                            'Pharmacy owner',
                            'Admin',
                            'Tutor',
                            'NonTutor'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            jobTitleController.text = val ?? '';
                          },
                        ),
                      ),
                    ],
                  ),

                  CustomRegistrationTextField(
                    label: 'Email',
                    prefixIcon: const Icon(
                      CupertinoIcons.mail,
                    ),
                    controller: emailController,
                  ),
                  // CustomRegistrationTextField(
                  //   label: 'Nouveau mot de passe',
                  //   prefixIcon: const Icon(
                  //     Icons.lock_outline,
                  //   ),
                  //   showSuffix: true,
                  //   obsecureText: true,
                  //   controller: passwordController,
                  // ),
                  // CustomRegistrationTextField(
                  //   label: 'Confirmation mot de passe',
                  //   prefixIcon: const Icon(
                  //     Icons.lock_outline,
                  //   ),
                  //   showSuffix: true,
                  //   obsecureText: true,
                  //   controller: confirmPasswordController,
                  // ),
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
                    maxLength: 10,
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                  ),
                  CustomRegistrationTextField(
                    label: 'Code postal',
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                    ),
                    controller: postalCodeController,
                    maxLength: 5,
                    textInputType: TextInputType.number,
                  ),
                  CustomRegistrationTextField(
                    label: 'Ville',
                    prefixIcon: const Icon(
                      Icons.location_city_outlined,
                    ),
                    controller: addressController,
                  ),
                  CustomRegistrationTextField(
                    label: 'Presentation',
                    prefixIcon: const Icon(
                      Icons.location_city_outlined,
                    ),
                    controller: descriptionController,
                    maxLines: 13,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: height * 0.12,
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
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Faculté ou école',
                                    style: heading,
                                  ),
                                ),
                                AjouterContainerReg(
                                  label: 'Faculté ou école',
                                  image: 'assets/icons/universityIcon.png',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.035,
                                ),
                                Image(
                                  image: const AssetImage(
                                      'assets/icons/deleteicon.png'),
                                  height: height * 0.025,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Image(
                                  image: const AssetImage(
                                      'assets/icons/universityIcon.png'),
                                  height: height * 0.025,
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Text(
                                  'Université de Paris',
                                  style: paragraph,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: height * 0.12,
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
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Spécialisations',
                                    style: heading,
                                  ),
                                ),
                                AjouterContainerReg(
                                  label: 'Spécialisations',
                                  image: 'assets/icons/checkIcon.png',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.035,
                                ),
                                Image(
                                  image: const AssetImage(
                                      'assets/icons/deleteicon.png'),
                                  height: height * 0.025,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Image(
                                  image: const AssetImage(
                                      'assets/icons/checkIcon.png'),
                                  height: height * 0.025,
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Text(
                                  'Homéopathie',
                                  style: paragraph,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: height * 0.18,
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
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'LGO',
                                    style: heading,
                                  ),
                                ),
                                AjouterContainerReg(
                                  label: 'LGO',
                                  image: 'assets/icons/computerIcon.png',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            const CustomTextWithGradientSlider(
                              title: 'WinPharma',
                              assetImage: 'assets/icons/computerIcon.png',
                              initialValue: 60,
                              categoryCount: 2,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            const CustomTextWithGradientSlider(
                              title: 'PharmaLand',
                              assetImage: 'assets/icons/computerIcon.png',
                              initialValue: 40,
                              categoryCount: 2,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: height * 0.3,
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
                              height: height * 0.015,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                Text(
                                  'Compétences',
                                  style: heading,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Image(
                                          image: const AssetImage(
                                              'assets/icons/covid.png'),
                                          height: height * 0.025,
                                        ),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        Text(
                                          'Test COVID',
                                          style: paragraph,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CustomSwitch(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Image(
                                          image: const AssetImage(
                                              'assets/icons/Vaccination.png'),
                                          height: height * 0.025,
                                        ),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        Text(
                                          'Vaccination',
                                          style: paragraph,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CustomSwitch(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Image(
                                          image: const AssetImage(
                                              'assets/icons/payantIcon.png'),
                                          height: height * 0.025,
                                        ),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        Text(
                                          'Gestion du tiers payant',
                                          style: paragraph,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CustomSwitch(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Image(
                                          image: const AssetImage(
                                              'assets/icons/TesttubeIcon.png'),
                                          height: height * 0.025,
                                        ),
                                        SizedBox(
                                          width: width * 0.025,
                                        ),
                                        Text(
                                          'Gestion des labos',
                                          style: paragraph,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CustomSwitch(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: height * 0.24,
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
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Langues',
                                    style: heading,
                                  ),
                                ),
                                AjouterContainerReg(
                                  label: 'Langues',
                                  image: 'assets/icons/worldIcon.png',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const CustomTextWithGradientSlider(
                              title: 'Français',
                              assetImage: 'assets/icons/worldIcon.png',
                              initialValue: 40,
                              categoryCount: 3,
                            ),
                            SizedBox(height: height * 0.01),
                            const CustomTextWithGradientSlider(
                              title: 'Anglais',
                              assetImage: 'assets/icons/worldIcon.png',
                              initialValue: 86,
                              categoryCount: 3,
                            ),
                            SizedBox(height: height * 0.01),
                            const CustomTextWithGradientSlider(
                              title: 'Allemand',
                              assetImage: 'assets/icons/worldIcon.png',
                              initialValue: 60,
                              categoryCount: 3,
                            ),
                            SizedBox(height: height * 0.01),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Container(
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
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Expériences',
                                    style: heading,
                                  ),
                                ),
                                AjouterContainerReg(
                                  label: 'Expériences',
                                  image: 'assets/icons/breifcase.png',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.035,
                                    ),
                                    Image(
                                      image: const AssetImage(
                                          'assets/icons/deleteicon.png'),
                                      height: height * 0.025,
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Image(
                                      image: const AssetImage(
                                          'assets/icons/breifcase.png'),
                                      height: height * 0.02,
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(
                                      'Pharmacie Centrale, 2019 - 2022',
                                      style: paragraph,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.035,
                                    ),
                                    Image(
                                      image: const AssetImage(
                                          'assets/icons/deleteicon.png'),
                                      height: height * 0.025,
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Image(
                                      image: const AssetImage(
                                          'assets/icons/breifcase.png'),
                                      height: height * 0.02,
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(
                                      'Pharmacie de la Gare, 2016 - 2019',
                                      style: paragraph,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: height * 0.22,
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
                              height: height * 0.015,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                Text(
                                  'Autres',
                                  style: heading,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Text(
                                          "Je donne le droit à PharmaBox de \nm'envoyer des offres d'emploi",
                                          style: paragraph,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CustomSwitch(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Text(
                                          "Je suis d'accord avec les\nConditions Générales d'Utilisation",
                                          style: paragraph,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CustomSwitch(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF7CEDAC),
                        Color(0xFF42D2FF),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      if (jobTitleController.text.isEmpty) {
                        Utility.showSnack('Alert', 'Please select user type');
                        return;
                      }

                      if (emailController.text.isEmpty) {
                        Utility.showSnack('Alert', 'Please enter email first');
                        return;
                      }

                      var user = UserModel();
                      user.fname = firstNameController.text;
                      user.lname = lastNameController.text;
                      user.type = jobTitleController.text;
                      user.email = emailController.text;
                      user.dob = dateOfBirthController.text;
                      user.phone = phoneController.text;
                      user.postalCode = postalCodeController.text;
                      user.presentation = descriptionController.text;
                      user.ville = addressController.text;

                      createUser(context, user);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const HomePage(),
                      //     ));
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: const Text(
                      'Créer un nouveau compte',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

createUser(BuildContext context, UserModel userModel) async {
  var userID = FirebaseAuth.instance.currentUser?.uid;

  if (userID == null) {
    Get.back();
    return;
  }

  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('users');

  var userMap = userModel.toMap();

  await reference.child(userID).set(userMap);

  MyHive.saveUser(userModel);

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ));

  // final docUser = FirebaseFirestore.instance.collection('users').doc();
  // final json = {
  //   'nom': nom,
  //   'Prénom': prenom,
  //   'Poste': poste,
  //   'Email': email,
  //   'password': password,
  //   'DOB': dob,
  //   'Téléphone': telephone,
  //   'postal': postal,
  //   'Ville': ville,
  //   'Presentation': presentation,
  // };
  //
  // await docUser.set(json);
}

class AjouterContainerReg extends StatelessWidget {
  var label;
  var image;

  AjouterContainerReg({
    Key? key,
    this.image,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            //height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ajouter',
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
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomRegistrationTextFieldReg(
                    image: image,
                    maxLines: 1,
                    padding: 1,
                    label: label,
                    controller: controller,
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                FiltersButton(
                  text: 'Enregistrer',
                  icon: false,
                ),
                Spaces.y2,
              ],
            ),
          ),
        );
      },
      child: Container(
          height: height * 0.035,
          width: width * 0.18,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(31, 92, 103, 0.17),
                offset: Offset(3, 3),
                blurRadius: 3,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: const Center(
              child: GradientText(
            'Ajouter',
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(124, 237, 172, 1),
                Color.fromRGBO(66, 210, 255, 1),
              ],
            ),
          ))),
    );
  }
}
