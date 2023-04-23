import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/member_registration/languages.dart';

import '../Theme/text.dart';
import '../Widgets/gradientText.dart';
import '../business_logic/langues_bloc/langues_bloc.dart';
import '../general/regTextFieldAjouter.dart';
import '../general/widgets/custom_slider_with_gradient.dart';
import '../model/models.dart';
import '../pharmaJob/bottomsheet.dart';

class LanguesContainer extends StatelessWidget {
  LanguesContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late LanguesBloc languesBloc;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    languesBloc = BlocProvider.of<LanguesBloc>(context);
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
                  'Langues',
                  style: heading,
                ),
              ),
              AjouterContainerReg(
                label: 'Langue',
                controller: controller,
                image: 'assets/icons/worldIcon.png',
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          BlocBuilder<LanguesBloc, LanguesState>(
            bloc: languesBloc,
            builder: (context, state) {
              if (state is LanguesInitial) {
                return const Center(child: Text("Pas de Langues"));
              } else {
                return Column(
                    children: List.generate(
                  state.langues.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: CustomTextWithGradientSlider(
                      parent: state.langues[index],
                      onTap: () {
                        BlocProvider.of<LanguesBloc>(context).add(
                            RemoveLocalLangue(
                                langue: state.langues[index].nom));
                      },
                      assetImage: 'assets/icons/worldIcon.png',
                      categoryCount: 3,
                    ),
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

class AjouterContainerReg extends StatefulWidget {
  var label;
  var image;
  AjouterContainerReg({
    Key? key,
    this.image,
    this.label,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<AjouterContainerReg> createState() => _AjouterContainerRegState();
}

class _AjouterContainerRegState extends State<AjouterContainerReg> {
  final GlobalKey<FormState> globalKey = GlobalKey();

  List<String> _selectedLanguages = [];
  void _showLanguageDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<LanguesBloc, LanguesState>(
          builder: (context, state) {
            _selectedLanguages.clear();
            for (Langue langue in state.langues) {
              _selectedLanguages=[..._selectedLanguages,langue.nom];
            }
            return AlertDialog(
              title: const Text('Séléctionner vos langues'),
              content: SizedBox(
                height: 400,
                width: 300,
                child: ListView(
                  children: [
                    for (var language in Languages.defaultLanguages)
                      CheckboxListTile(
                        title: Text(language.name),
                        value: _selectedLanguages.contains(language.name),
                        onChanged: (value) {
                          if (value!) {
                            //add
                            BlocProvider.of<LanguesBloc>(context).add(
                                AddLocalLangue(
                                    langue:
                                        Langue(nom: language.name, niveau: 0)));
                          } else {
                            _selectedLanguages.remove(language.name);
                            BlocProvider.of<LanguesBloc>(context)
                                .add(RemoveLocalLangue(langue: language.name));
                            //remove
                          }
                        },
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, _selectedLanguages);
                  },
                  child: Text('Valider'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        _showLanguageDialog(context);
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
    );
  }
}
