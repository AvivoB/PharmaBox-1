import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/titulaires_bloc.dart';

import '../Theme/text.dart';
import '../member_registration/member_registration_screen.dart';
import '../model/models.dart';

class TitulaireContainer extends StatelessWidget {
  TitulaireContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late TitulaireBloc titulaireBloc;
  final TextEditingController controller = TextEditingController();
  void addTitulaire(BuildContext context) {
    BlocProvider.of<TitulaireBloc>(context)
        .add(AddLocalTitulaire(titulaire: controller.text));
  }

  @override
  Widget build(BuildContext context) {
    titulaireBloc = BlocProvider.of<TitulaireBloc>(context);
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
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
                  'Titulaires',
                  style: heading,
                ),
              ),
              AjouterContainerReg(
                label: 'Titulaires',
                onTap: addTitulaire,
                controller: controller,
                image: 'assets/images/Profil.png',
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<TitulaireBloc, TitulairesState>(
            bloc: titulaireBloc,
            builder: (context, state) {
              if (state is TitulairesInitial) {
                return const Center(child: Text("Pas de titulaires"));
              } else {
                return Column(
                    children: List.generate(
                  state.titulaires.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: TitulaireWidget(
                        width: width,
                        height: height,
                        titulaire: state.titulaires[index]),
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

class TitulaireWidget extends StatelessWidget {
  const TitulaireWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.titulaire,
  }) : super(key: key);

  final double width;
  final double height;
  final String titulaire;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.035,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<TitulaireBloc>(context)
                .add(RemoveLocalTitulaire(titulaire: titulaire));
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
          titulaire,
          style: paragraph,
        ),
      ],
    );
  }
}
