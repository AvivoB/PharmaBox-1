import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/titulaires_bloc.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';

import '../Theme/text.dart';
import '../general/regTextFieldAjouter.dart';
import '../member_registration/member_registration_screen.dart';
import '../model/models.dart';
import '../pharmaJob/bottomsheet.dart';

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

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    titulaireBloc = BlocProvider.of<TitulaireBloc>(context);
    return Column(
      children: [
        BlocBuilder<TitulaireBloc, TitulairesState>(
          bloc: titulaireBloc,
          builder: (context, state) {
            if (state is TitulairesInitial) {
              return const SizedBox();
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
        InkWell(
          onTap: () {
            titulaireBloc.titulaires.length == 3
                ? showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Alerte'),
                        content: SingleChildScrollView(
                          child: Text(
                              "Vous pouvez pas ajouter plus de 3 titulaires"),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Annuler'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  )
                : showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Form(
                            key: globalKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ajouter un titulaire',
                                        style: heading,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: CustomRegistrationTextFieldReg(
                                    image: 'assets/images/Profil.png',
                                    maxLines: 1,
                                    padding: 1,
                                    label: 'Titulaire',
                                    controller: controller,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (globalKey.currentState!.validate()) {
                                        addTitulaire(context);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: FiltersButton(
                                      text: 'Enregistrer',
                                      icon: false,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
          child: Row(
            children: const [
              Text(
                "Ajouter titulaire",
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.add, color: Colors.blue),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}

class TitulaireWidget extends StatefulWidget {
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
  State<TitulaireWidget> createState() => _TitulaireWidgetState();
}

class _TitulaireWidgetState extends State<TitulaireWidget> {
  final TextEditingController tituController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tituController.text = widget.titulaire;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: CustomPharmacyTextField(
              label: "Titulaire",
              maxLines: 1,
              prefixIcon: const Icon(Icons.person),
              readOnly: true,
              controller: tituController,
            ),
          ),
        ),
        SizedBox(
          width: widget.width * 0.03,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<TitulaireBloc>(context)
                .add(RemoveLocalTitulaire(titulaire: widget.titulaire));
          },
          child: Image(
            image: const AssetImage('assets/icons/deleteicon.png'),
            height: widget.height * 0.025,
          ),
        ),
      ],
    );
  }
}
