import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/Widgets/button.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/membres_titualaires_reseau_bloc.dart';

import '../Widgets/countContainer.dart';
import '../Widgets/membersBox.dart';

class ReseauEdit extends StatefulWidget {
  const ReseauEdit({Key? key}) : super(key: key);

  @override
  State<ReseauEdit> createState() => _ReseauEditState();
}

class _ReseauEditState extends State<ReseauEdit> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MembresTitualairesReseauBloc>(context)
        .add(GetMembresTitulaires());
    BlocProvider.of<MembresBloc>(context).add(GetReseauMembres());
  }

  bool membre = false;
  bool titulaires = false;
  bool pharmacies = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<MembresTitualairesReseauBloc,
              MembresTitualairesReseauState>(builder: (context, state) {
            if (state is MembresTitulairesReady) {
              return CountContainer(
                count: state.membresTitulaires.length,
                text: 'Membres titulaires',
              );
            } else {
              return CountContainer(
                count: 0,
                text: 'Membres titulaires',
              );
            }
          }),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<MembresTitualairesReseauBloc,
              MembresTitualairesReseauState>(builder: (context, state) {
            if (state is MembresTitulairesReady) {
              return Column(
                  children: List.generate(
                state.membresTitulaires.length,
                (index) => MembersBoxDelete(
                  membre: state.membresTitulaires[index],
                  image: state.membresTitulaires[index].photoUrl,
                  name: state.membresTitulaires[index].nom +
                      ' ' +
                      state.membresTitulaires[index].prenom,
                  text: state.membresTitulaires[index].poste,
                  icon: Icons.local_hospital,
                ),
              ));
            } else {
              return SizedBox(
                height: height * 0.02,
              );
            }
          }),
          BlocBuilder<MembresBloc, MembresState>(builder: (context, state) {
            if (state is MembresProfileReady) {
              return CountContainer(
                count: state.membres.length,
                text: 'Membres',
              );
            } else {
              return CountContainer(
                count: 0,
                text: 'Membres',
              );
            }
          }),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<MembresBloc, MembresState>(builder: (context, state) {
            if (state is MembresProfileReady) {
              return Column(
                  children: List.generate(
                state.membres.length,
                (index) => MembersBoxDelete(
                  membre: state.membres[index],
                  image: state.membres[index].photoUrl,
                  name: state.membres[index].nom +
                      ' ' +
                      state.membres[index].prenom,
                  text: state.membres[index].localisation.ville,
                  icon: Icons.local_hospital,
                ),
              ));
            } else {
              return SizedBox(
                height: height * 0.02,
              );
            }
          }),
          CountContainer(
            count: 0,
            text: 'Pharmacies',
          ),
          SizedBox(
            height: height * 0.02,
          ),
          const TabBarButton(),
        ],
      ),
    );
  }
}
