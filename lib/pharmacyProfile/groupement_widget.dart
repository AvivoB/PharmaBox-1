import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/groupement_bloc.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';

import '../Theme/text.dart';
import '../Widgets/gradientText.dart';
import '../bloc/pharmacie_bloc.dart';

class ModifierGroupement extends StatefulWidget {
  ModifierGroupement({
    Key? key,
  }) : super(key: key);

  @override
  State<ModifierGroupement> createState() => _ModifierGroupementState();
}

class _ModifierGroupementState extends State<ModifierGroupement> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController groupementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Image(
          fit: BoxFit.cover,
          image: NetworkImage(
            BlocProvider.of<PharmacieBloc>(context).groupementImage,
          )),
      title: Text(
        "Groupement",
        style: heading.copyWith(fontSize: 14),
      ),
      subtitle: Text(
        BlocProvider.of<PharmacieBloc>(context).groupement,
        style: paragraph,
      ),
      trailing: InkWell(
        onTap: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              context: context,
              builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: height * 0.4,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        CustomPharmacyTextField(
                          label: "Groupement",
                          controller: groupementController,
                          onRealChanged: (val) {
                            BlocProvider.of<GroupementBloc>(context)
                                .add(GetAllGroupements(input: val));
                          },
                        ),
                        BlocBuilder<GroupementBloc, GroupementState>(
                          builder: (context, state) {
                            if (state is GroupementsReady) {
                              return SingleChildScrollView(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: List.generate(
                                    state.groupements.length,
                                    (index) => ListTile(
                                      onTap: () {
                                        BlocProvider.of<PharmacieBloc>(context)
                                                .groupement =
                                            state.groupements[index].groupement;
                                        BlocProvider.of<PharmacieBloc>(context)
                                                .groupementImage =
                                            state.groupements[index].image;
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      leading: Image(
                                          height: height * 0.045,
                                          image: NetworkImage(
                                              state.groupements[index].image)),
                                      title: Text(
                                        state.groupements[index].groupement,
                                        style: heading,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is GroupementsLoading) {
                              return const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ));
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ],
                    )),
                  )));
        },
        child: Container(
            height: height * 0.035,
            width: width * 0.18,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(31, 92, 103, 0.17),
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: const Center(
                child: GradientText(
              'Modifier',
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(124, 237, 172, 1),
                  Color.fromRGBO(66, 210, 255, 1),
                ],
              ),
            ))),
      ),
    );
  }
}
