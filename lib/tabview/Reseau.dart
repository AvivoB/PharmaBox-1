import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/button.dart';

import '../Widgets/countContainer.dart';
import '../Widgets/jobsbox.dart';
import '../Widgets/membersBox.dart';
import '../Widgets/pharmaciesbox.dart';
import '../bloc/membres_bloc.dart';
import '../bloc/membres_titualaires_reseau_bloc.dart';

class Reseau extends StatefulWidget {
  const Reseau({Key? key}) : super(key: key);

  @override
  State<Reseau> createState() => _ReseauState();
}

class _ReseauState extends State<Reseau> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MembresTitualairesReseauBloc>(context)
        .add(GetMembresTitulaires());
    BlocProvider.of<MembresBloc>(context).add(GetReseauMembres());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
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
                  image: 'assets/images/profile 3.png',
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
                  image: 'assets/images/profile 3.png',
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
            count: 2,
            text: 'Pharmacies',
          ),
          SizedBox(
            height: height * 0.02,
          ),
          /* PharmaciesBox(
          zip: '75016',
          pharm: "Grande Pharmacie D'Aulnay",
          
          imagePharm: 'assets/images/pharmacy 1.png',
        ),*/
          SizedBox(
            height: height * 0.02,
          ),
          /*PharmaciesBox(
          zip: '94160',
          pharm: "Citypharma",
          imagePharm: 'assets/images/pharmacy 2.png',
        ),*/
          SizedBox(
            height: height * 0.02,
          ),
          const TabBarButton(),
        ],
      )),
    );
  }
}
