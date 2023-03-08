import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/lgosearch_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';

import '../Theme/text.dart';
import '../Widgets/gradientText.dart';
import '../business_logic/langues_bloc/langues_bloc.dart';
import '../general/widgets/custom_slider_with_gradient.dart';
import '../model/models.dart';
import '../pharmacyProfile/textfield.dart';
import 'member_registration_screen.dart';

class LgoContainer extends StatelessWidget {
  LgoContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late LgoBloc lgoBloc;
  final TextEditingController controller = TextEditingController();
  void addLangue(BuildContext context, String name) {
    BlocProvider.of<LgoBloc>(context)
        .add(AddLocalLgo(lgo: Lgo(nom: name, niveau: 0)));
  }

  @override
  Widget build(BuildContext context) {
    lgoBloc = BlocProvider.of<LgoBloc>(context);
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
                  'LGO',
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
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            children: [
                              CustomPharmacyTextField(
                                label: "LGO",
                                controller: controller,
                                onRealChanged: (val) {
                                  BlocProvider.of<LgosearchBloc>(context)
                                      .add(GetAllLgos(input: val));
                                },
                              ),
                              BlocBuilder<LgosearchBloc, LgosearchState>(
                                builder: (context, state) {
                                  if (state is LgosearchReady) {
                                    return SingleChildScrollView(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Column(
                                        children: List.generate(
                                          state.groupements.length,
                                          (index) => ListTile(
                                            onTap: () {
                                              addLangue(
                                                  context,
                                                  state.groupements[index]
                                                      .groupement);
                                            },
                                            leading: Image(
                                                height: height * 0.045,
                                                image: NetworkImage(state
                                                    .groupements[index].image)),
                                            title: Text(
                                              state.groupements[index]
                                                  .groupement,
                                              style: heading,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (state is LgosearchLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          )));
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
          BlocBuilder<LgoBloc, LgoState>(
            bloc: lgoBloc,
            builder: (context, state) {
              if (state is LgosInitial) {
                return const Center(child: Text("Pas de LGO"));
              } else {
                return Column(
                    children: List.generate(
                  state.lgos.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: CustomTextWithGradientSlider(
                      parent: state.lgos[index],
                      onTap: () {
                        BlocProvider.of<LgoBloc>(context)
                            .add(RemoveLocalLgo(lgo: state.lgos[index]));
                      },
                      assetImage: 'assets/icons/computerIcon.png',
                      categoryCount: 3,
                    ),
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
