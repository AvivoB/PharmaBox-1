import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';

import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/offer/offre_widget.dart';
import '../model/horaire.dart';
import 'offre_consultation_widget.dart';

class OffreConsultation extends StatefulWidget {
  const OffreConsultation({super.key});

  @override
  State<OffreConsultation> createState() => _OffreConsultationState();
}

class _OffreConsultationState extends State<OffreConsultation> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OffresBloc>(context).add(GetPharmacieOffres());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<OffresBloc, OffresState>(
        builder: (context, state) {
          print(state);
          if (state is OffresReady) {
            print(state.offres.length);
            return SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        state.offres.length,
                        (index) => InkWell(
                            onTap: () {
                              BlocProvider.of<MembresBloc>(context)
                                  .add(GetMembres(offre: state.offres[index]));
                            },
                            child: OffreConslutationWidget(offre: state.offres[index])))));
          } else {
            return const Center(
              child: Text("No offres"),
            );
          }
        },
      ),
    );
  }
}
