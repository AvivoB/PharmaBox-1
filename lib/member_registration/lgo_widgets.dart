import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';

import '../Theme/text.dart';
import '../business_logic/langues_bloc/langues_bloc.dart';
import '../general/widgets/custom_slider_with_gradient.dart';
import '../model/models.dart';
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
  void addLangue(BuildContext context) {
    BlocProvider.of<LgoBloc>(context)
        .add(AddLocalLgo(lgo: Lgo(nom: controller.text, niveau: 0)));
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
              AjouterContainerReg(
                label: 'LGO',
                onTap: addLangue,
                controller: controller,
                image: 'assets/icons/computerIcon.png',
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
