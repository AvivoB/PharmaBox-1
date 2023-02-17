import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmabox/Home/HomePage.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/business_logic/competences_bloc/competences_bloc.dart';
import 'package:pharmabox/business_logic/experiences_bloc/experiences_bloc.dart';
import 'package:pharmabox/business_logic/langues_bloc/langues_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';
import 'package:pharmabox/business_logic/universites_bloc/universites_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/constant.dart';
import 'package:pharmabox/general/regTextFieldAjouter.dart';
import 'package:pharmabox/general/widgets/custom_registration_date_picker.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';

import 'package:pharmabox/general/widgets/custom_elevated_button.dart';
import 'package:pharmabox/member_registration/universite_widgets.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/bottomsheet.dart';
import '../Widgets/gradientText.dart';
import '../firebase/image_service.dart';
import '../model/localisation.dart';
import '../model/telephone.dart';
import 'autres_widget.dart';
import 'competences_widget.dart';
import 'experience_widgets.dart';
import 'langues_widgets.dart';
import 'lgo_widgets.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController controller = ScrollController();
  List<bool> conditions = [false, false];
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
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          MemberRegistrationAppBar(),
          Flexible(
            child: SingleChildScrollView(
              controller: controller,
              child: Form(
                key: formKey,
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
                            items: <String>['Tutor', 'NonTutor']
                                .map((String value) {
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
                        UniversiteContainer(height: height, width: width),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        LanguesContainer(height: height, width: width),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        LgoContainer(height: height, width: width),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        CompetencesContainer(height: height, width: width),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        ExperiencesContainer(width: width, height: height),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        AutresContainer(
                          height: height,
                          width: width,
                          conditions: conditions,
                          callbacks: [
                            (val) {
                              setState(() {
                                conditions[0] = !conditions[0];
                              });
                            },
                            (val) {
                              setState(() {
                                conditions[1] = !conditions[1];
                              });
                            }
                          ],
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          NonTitulaire nonTitulaire = NonTitulaire.creation(
                              nom: firstNameController.text,
                              photoUrl: BlocProvider.of<UsersBlocBloc>(context).imagePath != null
                                  ? BlocProvider.of<UsersBlocBloc>(context)
                                      .imagePath!
                                  : 'https://firebasestorage.googleapis.com/v0/b/pharmabox-effd0.appspot.com/o/user.png?alt=media&token=fa1292f7-7679-4c3b-b6e5-7831a9ac4ca4',
                              prenom: lastNameController.text,
                              presentation: descriptionController.text,
                              email: emailController.text,
                              telephone: Telephone(
                                  numeroTelephone:
                                      int.parse(phoneController.text),
                                  visible: false),
                              poste: jobTitleController.text,
                              experiences: BlocProvider.of<ExperiencesBloc>(context)
                                  .state
                                  .experiences,
                              lgos:
                                  BlocProvider.of<LgoBloc>(context).state.lgos,
                              universites: BlocProvider.of<UniversitesBloc>(context)
                                  .state
                                  .universities,
                              naissance: dateOfBirthController.text,
                              langues: BlocProvider.of<LanguesBloc>(context)
                                  .state
                                  .langues,
                              localisation: Localisation(
                                  codePostal:
                                      int.parse(postalCodeController.text),
                                  ville: addressController.text),
                              competences:
                                  BlocProvider.of<CompetencesBloc>(context)
                                      .state
                                      .competences,
                              droitOffres: conditions[0],
                              accepterConditions: conditions[1]);
                          BlocProvider.of<UsersBlocBloc>(context)
                              .add(AddUser(user: nonTitulaire));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        } else {
                          controller.animateTo(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
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
            ),
          )
        ],
      ),
    );
  }
}

class AjouterContainerReg extends StatelessWidget {
  var label;
  var image;
  final Function onTap;
  AjouterContainerReg({
    Key? key,
    this.image,
    this.label,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
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
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Form(
                  key: globalKey,
                  child: Column(
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
                        height: height * 0.02,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (globalKey.currentState!.validate()) {
                              onTap(context);
                              Navigator.pop(context);
                            }
                          },
                          child: FiltersButton(
                            text: 'Enregistrer',
                            icon: false,
                          )),
                    ],
                  ),
                ),
              ),
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
