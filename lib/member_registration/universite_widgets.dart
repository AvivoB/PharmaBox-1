import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Theme/text.dart';
import '../business_logic/universites_bloc/universites_bloc.dart';
import '../model/models.dart';
import 'member_registration_screen.dart';

class UniversiteContainer extends StatelessWidget {
  UniversiteContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late UniversitesBloc universitesBloc;
  final TextEditingController controller = TextEditingController();
  void addUniversite(BuildContext context) {
    BlocProvider.of<UniversitesBloc>(context)
        .add(AddLocalUniversite(universite: Universite(nom: controller.text)));
  }

  @override
  Widget build(BuildContext context) {
    universitesBloc = BlocProvider.of<UniversitesBloc>(context);
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
                  'Faculté ou école',
                  style: heading,
                ),
              ),
              AjouterContainerReg(
                label: 'Faculté ou école',
                onTap: addUniversite,
                controller: controller,
                image: 'assets/icons/universityIcon.png',
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<UniversitesBloc, UniversitesState>(
            bloc: universitesBloc,
            builder: (context, state) {
              if (state is UniversitesInitial) {
                return const Center(child: Text("Pas d'universités"));
              } else {
                return Column(
                    children: List.generate(
                  state.universities.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: UniversiteWidget(
                        width: width,
                        height: height,
                        universite: state.universities[index]),
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

class UniversiteWidget extends StatelessWidget {
  const UniversiteWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.universite,
  }) : super(key: key);

  final double width;
  final double height;
  final Universite universite;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.035,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<UniversitesBloc>(context)
                .add(RemoveLocalUniversite(universite: universite));
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
        Image(
          image: const AssetImage('assets/icons/universityIcon.png'),
          height: height * 0.025,
        ),
        SizedBox(
          width: width * 0.03,
        ),
        Text(
          universite.nom,
          style: paragraph,
        ),
      ],
    );
  }
}
