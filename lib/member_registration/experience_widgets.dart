import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';

import '../Theme/text.dart';
import '../Widgets/gradientText.dart';
import '../business_logic/experiences_bloc/experiences_bloc.dart';
import '../general/regTextFieldAjouter.dart';
import '../model/models.dart';
import '../pharmaJob/bottomsheet.dart';

class ExperiencesContainer extends StatelessWidget {
  ExperiencesContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late ExperiencesBloc exepriencesBloc;
  void addExperience(
      BuildContext context, String nom, int anneDebut, int anneFin) {
    BlocProvider.of<ExperiencesBloc>(context).add(AddLocalExperience(
        experience: Experience(
            anneeDebut: anneDebut, anneeFin: anneFin, nomPharmacie: nom)));
  }

  @override
  Widget build(BuildContext context) {
    exepriencesBloc = BlocProvider.of<ExperiencesBloc>(context);
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
      margin: const EdgeInsets.all(20),
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
              AjouterContainerRegExp(
                label: 'Expériences',
                add: addExperience,
                image: 'assets/icons/breifcase.png',
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<ExperiencesBloc, ExperiencesState>(
            bloc: exepriencesBloc,
            builder: (context, state) {
              if (state is ExperiencesInitial) {
                return const Center(child: Text("Pas d'expériences"));
              } else {
                return Column(
                    children: List.generate(
                  state.experiences.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ExperienceWidget(
                        width: width,
                        height: height,
                        experience: state.experiences[index]),
                  ),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.experience,
  }) : super(key: key);

  final double width;
  final double height;
  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.035,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<ExperiencesBloc>(context)
                .add(RemoveLocalExperience(experience: experience));
          },
          child: Image(
            image: const AssetImage('assets/icons/deleteicon.png'),
            height: height * 0.025,
          ),
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Image(
          image: const AssetImage('assets/icons/breifcase.png'),
          height: height * 0.02,
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Text(
          '${experience.nomPharmacie}, ${experience.anneeDebut} - ${experience.anneeFin}',
          style: paragraph,
        ),
      ],
    );
  }
}

class AjouterContainerRegExp extends StatelessWidget {
  var label;
  var image;
  final Function(BuildContext, String, int, int) add;
  AjouterContainerRegExp({
    Key? key,
    this.image,
    this.label,
    required this.add,
  }) : super(key: key);
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController anneeDebutController = TextEditingController();
    TextEditingController anneFinController = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          context: context,
          builder: (context) =>SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
            child: Form(
              key: globalKey,
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
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: CustomRegistrationTextField(
                            label: "Année Debut",
                            textInputType: TextInputType.number,
                          
                            controller: anneeDebutController),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: CustomRegistrationTextField(
                            textInputType: TextInputType.number,
                            label: "Année Fin",
                            controller: anneFinController),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (globalKey.currentState!.validate()) {
                          add(
                              context,
                              controller.text,
                              int.parse(anneeDebutController.text),
                              int.parse(anneFinController.text));
                          Navigator.pop(context);
                        }
                      },
                      child: FiltersButton(
                        text: 'Enregistrer',
                        icon: false,
                      )),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
             )) ),
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
