import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/lgosearch_bloc.dart';
import 'package:pharmabox/business_logic/lgo_bloc/lgo_bloc.dart';

import '../Theme/color.dart';
import '../Theme/text.dart';
import '../Widgets/gradientText.dart';
import '../business_logic/langues_bloc/langues_bloc.dart';
import '../constants.dart';
import '../custom_decorations_class/custom_gradient_slider.dart';
import '../general/widgets/custom_slider_with_gradient.dart';
import '../model/models.dart';
import '../pharmacyProfile/textfield.dart';
import 'member_registration_screen.dart';

class LgoContainer extends StatelessWidget {
  LgoContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  late LgoBloc lgoBloc;
  final TextEditingController controller = TextEditingController();
  void addLangue(BuildContext context, String name,String image) {
    BlocProvider.of<LgoBloc>(context)
        .add(AddLocalLgo(lgo: Lgo(nom: name, niveau: 0,image:image)));
  }

  @override
  Widget build(BuildContext context) {
    lgoBloc = BlocProvider.of<LgoBloc>(context);
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
        mainAxisSize: MainAxisSize.min,
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
                  'LGO',
                  style: heading,
                ),
              ),
              InkWell(
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                                height: height,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          CustomPharmacyTextField(
                                            label: "LGO",
                                            controller: controller,
                                            onRealChanged: (val) {
                                            
                                            },
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
                                                  .add(GetAllLgos(input: controller.text));
                                                },
                                              ))
                                        ],
                                      ),
                                        
                                      BlocBuilder<LgosearchBloc,
                                          LgosearchState>(
                                        builder: (context, state) {
                                          if (state is LgosearchReady) {
                                            return SingleChildScrollView(
                                              padding:const EdgeInsets.only(top: 20),
                                              child: Column(
                                                children: List.generate(
                                                  state.groupements.length,
                                                  (index) => ListTile(
                                                    onTap: () {
                                                      addLangue(
                                                          context,
                                                          state
                                                              .groupements[
                                                                  index]
                                                              .groupement,state.groupements[index].image);
                                                      Navigator.pop(context);
                                                    },
                                                    leading: Image(
                                                        height: height * 0.045,
                                                        image: NetworkImage(
                                                            state
                                                                .groupements[
                                                                    index]
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
                                          } else if (state
                                              is LgosearchLoading) {
                                            return const Padding(
                                              padding:
                                                   EdgeInsets.all(10.0),
                                              child:  Center(
                                                child:
                                                    CircularProgressIndicator(),
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
                          ));
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
          Flexible(
            child: BlocBuilder<LgoBloc, LgoState>(
              bloc: lgoBloc,
              builder: (context, state) {
                if (state is LgosInitial) {
                  return const Center(child: Text("Pas de LGO"));
                } else {
                  return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        state.lgos.length,
                        (index) => Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: CustomLgo(
                              parent: state.lgos[index],
                              onTap: () {
                                BlocProvider.of<LgoBloc>(context).add(
                                    RemoveLocalLgo(lgo: state.lgos[index]));
                              },
                              assetImage: 'assets/icons/computerIcon.png',
                              categoryCount: 1,
                            ),
                          ),
                        ),
                      ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


class CustomLgo extends StatefulWidget {
  //final String title;
  // final double initialwidget.parent.niveau;
  final String assetImage;
  final Lgo parent;
  final int categoryCount;
  final VoidCallback onTap;
  const CustomLgo({
    Key? key,
    //required this.title,
    //required this.initialwidget.parent.niveau,
    required this.assetImage,
    required this.categoryCount,
    required this.parent,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomLgo> createState() =>
      _CustomLgoState();
}

class _CustomLgoState
    extends State<CustomLgo> {
  String labelText = '';

  LinearGradient _gradient = const LinearGradient(colors: []);

  @override
  void initState() {
    super.initState();
    // widget.parent.niveau = widget.parent.niveau;
    //widget.parent.niveau = widget.initialwidget.parent.niveau;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (widget.categoryCount == 3) {
      if (widget.parent.niveau < 50) {
        labelText = 'Basique';
        _gradient = kbasicGradient;
      } else if (widget.parent.niveau > 50 && widget.parent.niveau < 80) {
        labelText = 'Intérmédiaire';
        _gradient = kintermediateLevelGradient;
      } else {
        labelText = 'Couramment';
        _gradient = kexpertLevelGradient;
      }
      setState(() {});
    } else {
      if (widget.parent.niveau < 50) {
        labelText = 'Maîtrise basique';
        _gradient = kbasicGradient;
      } else if (widget.parent.niveau > 50 && widget.parent.niveau < 80) {
        labelText = 'Maîtrise intérmidiaire';
        _gradient = kintermediateLevelGradient;
      } else {
        labelText = 'Maîtrise complète';
        _gradient = kexpertLevelGradient;
      }
      setState(() {});
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.035,
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Image(
                  image: const AssetImage('assets/icons/deleteicon.png'),
                  height: height * 0.025,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Image(
                image: NetworkImage(widget.parent.image),
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Flexible(
                child: Text(
                  widget.parent.nom,
                  style: paragraph,
                ),
              ),
            ],
          ),
        ),

        Container(
          // color: lightGreen,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GradientText(
                labelText,
                style: const TextStyle(fontSize: 10),
                gradient: _gradient,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.45,
                child: SliderTheme(
                  data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.never,
                    minThumbSeparation: 0.00,
                    thumbColor: widget.parent.niveau < 50
                        ? const Color.fromRGBO(248, 153, 153, 1)
                        : widget.parent.niveau > 50 && widget.parent.niveau < 80
                            ? const Color.fromRGBO(253, 197, 113, 1)
                            : const Color.fromRGBO(124, 237, 172, 1),
                    /* : widget.parent.niveau < 50
                            ? const Color.fromRGBO(255, 222, 172, 1)
                            : const Color.fromRGBO(124, 237, 172, 1),*/
                    trackHeight: 2,
                    trackShape: GradientRectSliderTrackShape(
                      gradient: _gradient,
                    ),
                  ),
                  child: Slider(
                    min: 0,
                    max: 100,
                    value: widget.parent.niveau,
                    // divisions: 4,

                    onChanged: (double val) {
                      setState(() {
                        widget.parent.niveau = val;
                        //BlocProvider.of<E>(context).add(UpdateValue());
                      });
                    },
                  ),
                ),
              ),
              // const SizedBox(height: 10),
            ],
          ),
        ),
        // SizedBox(
        //   width: widget.categoryCount == 3
        //       ? MediaQuery.of(context).size.width * 0.05
        //       : 0,
        // ),
      ],
    );
  }
}
