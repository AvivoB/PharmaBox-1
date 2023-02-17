import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Theme/text.dart';
import '../business_logic/langues_bloc/langues_bloc.dart';
import '../general/widgets/custom_slider_with_gradient.dart';
import '../model/models.dart';
import 'member_registration_screen.dart';

class LanguesContainer extends StatelessWidget {
  LanguesContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late LanguesBloc languesBloc;
  final TextEditingController controller = TextEditingController();
  void addLangue(BuildContext context) {
    BlocProvider.of<LanguesBloc>(context)
        .add(AddLocalLangue(langue: Langue(nom: controller.text, niveau: 0)));
  }

  @override
  Widget build(BuildContext context) {
    languesBloc = BlocProvider.of<LanguesBloc>(context);
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
                  'Langues',
                  style: heading,
                ),
              ),
              AjouterContainerReg(
                label: 'Langue',
                onTap: addLangue,
                controller: controller,
                image: 'assets/icons/worldIcon.png',
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<LanguesBloc, LanguesState>(
            bloc: languesBloc,
            builder: (context, state) {
              if (state is LanguesInitial) {
                return const Center(child: Text("Pas de diplômes"));
              } else {
                return Column(
                    children: List.generate(
                  state.langues.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: CustomTextWithGradientSlider(
                      parent: state.langues[index],
                      onTap: () {
                        BlocProvider.of<LanguesBloc>(context).add(
                            RemoveLocalLangue(langue: state.langues[index]));
                      },
                      assetImage: 'assets/icons/worldIcon.png',
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
