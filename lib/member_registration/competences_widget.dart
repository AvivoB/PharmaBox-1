import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/business_logic/competences_bloc/competences_bloc.dart';

import '../Theme/text.dart';
import '../business_logic/universites_bloc/universites_bloc.dart';
import '../general/widgets/custom_switch_widget.dart';
import '../model/models.dart';
import 'member_registration_screen.dart';

class CompetencesContainer extends StatelessWidget {
  CompetencesContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late CompetencesBloc competencesBloc;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    competencesBloc = BlocProvider.of<CompetencesBloc>(context);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.015,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Compétences',
              style: heading,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<CompetencesBloc, CompetencesState>(
            bloc: competencesBloc,
            builder: (context, state) {
              return Column(
                  children: List.generate(
                state.competences.length,
                (index) => Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: CompetencesWidget(
                      width: width,
                      height: height,
                      competence: state.competences[index]),
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class CompetencesWidget extends StatelessWidget {
  const CompetencesWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.competence,
  }) : super(key: key);

  final double width;
  final double height;
  final Competence competence;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            Image(
              image: AssetImage(competence.asset),
              height: height * 0.025,
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              competence.nom,
              style: paragraph,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CustomSwitch(
            initialSwitchValue: competence.enabled,
            onTap: (val) {
              BlocProvider.of<CompetencesBloc>(context)
                  .add(AddRemoveCompetence(competence: competence));
            },
          ),
        ),
      ],
    );
  }
}
