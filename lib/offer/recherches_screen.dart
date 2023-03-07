import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';

import 'package:pharmabox/bloc/recherche_bloc.dart';
import 'package:pharmabox/offer/recherche_widget.dart';

class RechercheScreen extends StatefulWidget {
  const RechercheScreen({super.key});

  @override
  State<RechercheScreen> createState() => _RechercheScreenState();
}

class _RechercheScreenState extends State<RechercheScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RechercheBloc>(context).add(GetUserRecherches());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RechercheBloc, RechercheState>(
      builder: (context, state) {
        print(state);
        if (state is RecherchesReady) {
          return Column(
              children: List.generate(
                  state.recherches.length,
                  (index) => InkWell(
                      onTap: () {
                        BlocProvider.of<OffresBloc>(context).add(
                            GetFilteredOffres(
                                recherche: state.recherches[index]));
                      },
                      child: RechercheWidget(
                          recherche: state.recherches[index]))));
        } else {
          return const Center(
            child: Text("Pas de recherches"),
          );
        }
      },
    );
  }
}
