import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/groupement_bloc.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';

import '../Theme/color.dart';
import '../Theme/text.dart';
import '../Widgets/gradientText.dart';
import '../bloc/lgosearch_bloc.dart';
import '../bloc/pharmacie_bloc.dart';
import '../general/widgets/custom_slider_with_gradient.dart';

class LgoPharmacie extends StatefulWidget {
  LgoPharmacie({
    Key? key,
  }) : super(key: key);

  @override
  State<LgoPharmacie> createState() => _LgoPharmacieState();
}

class _LgoPharmacieState extends State<LgoPharmacie> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController groupementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: height * 0.015,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'LGO',
                  style: heading,
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    constraints: BoxConstraints.expand(height: height * 0.8),
                    enableDrag: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      child: SizedBox(
                          height: height,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 20,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    CustomPharmacyTextField(
                                      label: "LGO",
                                      controller: groupementController,
                                      onRealChanged: (val) {},
                                    ),
                                    Positioned(
                                        right: 10,
                                        top: 10,
                                        bottom: 10,
                                        child: IconButton(
                                          color: lightGreen,
                                          icon: const Icon(Icons.search),
                                          onPressed: () {
                                            BlocProvider.of<LgosearchBloc>(
                                                    context)
                                                .add(GetAllLgos(
                                                    input: groupementController
                                                        .text));
                                          },
                                        ))
                                  ],
                                ),
                              
                                BlocBuilder<LgosearchBloc, LgosearchState>(
                                  builder: (context, state) {
                                    if (state is LgosearchReady) {
                                      return SingleChildScrollView(
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                            state.groupements.length,
                                            (index) => ListTile(
                                              onTap: () {
                                                BlocProvider.of<PharmacieBloc>(
                                                            context)
                                                        .lgo =
                                                    state.groupements[index]
                                                        .groupement;
                                                BlocProvider.of<PharmacieBloc>(
                                                            context)
                                                        .lgoImage =
                                                    state.groupements[index]
                                                        .image;
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                              leading: Image(
                                                  height: height * 0.045,
                                                  image: NetworkImage(state
                                                      .groupements[index]
                                                      .image)),
                                              title: Text(
                                                state.groupements[index]
                                                    .groupement,
                                                style: heading,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (state is LgosearchLoading) {
                                      return const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ],
                            ),
                          )),
                    ),
                  );
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
                      'Ajouter',
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(124, 237, 172, 1),
                          Color.fromRGBO(66, 210, 255, 1),
                        ],
                      ),
                    ))),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.035,
              ),
              Image(
                  height: height * 0.02,
                  image: NetworkImage(
                      BlocProvider.of<PharmacieBloc>(context).lgoImage)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Flexible(
                child: Text(
                  BlocProvider.of<PharmacieBloc>(context).lgo,
                  style: paragraph,
                ),
              ),
            ],
          )
        ]));
  }
}
