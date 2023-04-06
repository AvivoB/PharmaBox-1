import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/bloc/specialisationsearch_bloc.dart';

import '../Theme/text.dart';
import '../Widgets/gradientText.dart';
import '../business_logic/specialisations_bloc/specialisations_bloc.dart';
import '../model/models.dart';
import '../pharmacyProfile/textfield.dart';
import 'member_registration_screen.dart';

class SpecialisationContainer extends StatelessWidget {
  SpecialisationContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late SpecialisationsBloc specialisationsBloc;
  final TextEditingController controller = TextEditingController();
  void addSpecialisation(BuildContext context, String name) {
    BlocProvider.of<SpecialisationsBloc>(context)
        .add(AddLocalSpecialisation(specialisation: Specialisation(nom: name)));
  }

  @override
  Widget build(BuildContext context) {
    specialisationsBloc = BlocProvider.of<SpecialisationsBloc>(context);
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
                  'Spécialisations',
                  style: heading,
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      context: context,
                      builder: (context) => Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 20,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                                height: height * 0.7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          CustomPharmacyTextField(
                                            label: "Spécialisation",
                                            controller: controller,
                                            onRealChanged: (val) {},
                                          ),
                                          Positioned(
                                              right: 10,
                                              top: 10,
                                              bottom: 10,
                                              child: IconButton(
                                                color: lightGreen,
                                                icon: const Icon(Icons.search),
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              SpecialisationsearchBloc>(
                                                          context)
                                                      .add(
                                                          GetAllSpecialisations(
                                                              input: controller
                                                                  .text));
                                                },
                                              ))
                                        ],
                                      ),
                                      BlocBuilder<SpecialisationsearchBloc,
                                          SpecialisationsearchState>(
                                        builder: (context, state) {
                                          if (state
                                              is SpecialisationsearchReady) {
                                            return SingleChildScrollView(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Column(
                                                children: List.generate(
                                                  state.groupements.length,
                                                  (index) => ListTile(
                                                    onTap: () {
                                                      addSpecialisation(
                                                          context,
                                                          state
                                                              .groupements[
                                                                  index]
                                                              .groupement);
                                                      Navigator.pop(context);
                                                    },
                                                    leading: Text(
                                                      state.groupements[index]
                                                          .groupement,
                                                      style: heading,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (state
                                              is SpecialisationsearchLoading) {
                                            return const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                          ));
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
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<SpecialisationsBloc, SpecialisationsState>(
            bloc: specialisationsBloc,
            builder: (context, state) {
              print(state);
              if (state is SpecialisationsInitial) {
                return const Center(child: Text("Pas de spécialisations"));
              } else {
                print(state.specialisations.length);
                return Column(
                    children: List.generate(
                  state.specialisations.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: SpecialisationWidget(
                        width: width,
                        height: height,
                        specialisation: state.specialisations[index]),
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

class SpecialisationWidget extends StatelessWidget {
  const SpecialisationWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.specialisation,
  }) : super(key: key);

  final double width;
  final double height;
  final Specialisation specialisation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.035,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<SpecialisationsBloc>(context)
                .add(RemoveLocalSpecialisation(specialisation: specialisation));
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
          image: const AssetImage('assets/icons/checkIcon.png'),
          height: height * 0.025,
        ),
        SizedBox(
          width: width * 0.03,
        ),
        Text(
          specialisation.nom,
          style: paragraph,
        ),
      ],
    );
  }
}
