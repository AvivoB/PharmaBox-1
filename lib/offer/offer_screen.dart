import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';

import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/offer/offre_widget.dart';
import '../model/horaire.dart';
part 'heading_tile_widget.dart';
part 'table_text_widget.dart';
part 'custom_check_box.dart';
part 'custom_table.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
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
          if (state is OffresReady) {
            return  SingleChildScrollView(
              padding: const EdgeInsets.only(bottom:50),
                   child:Column( children: List.generate(
                        state.offres.length,
                        (index) => InkWell(
                            onTap: () {
                              BlocProvider.of<MembresBloc>(context)
                                  .add(GetMembres(offre: state.offres[index]));
                            },
                            child: OffreWidget(offre: state.offres[index])))));
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
