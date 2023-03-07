import 'package:flutter/material.dart';

import '../../Theme/text.dart';
import '../../Widgets/gradientText.dart';
import '../../constants.dart';
import '../../custom_decorations_class/custom_gradient_slider.dart';
import '../../model/slider_parent.dart';

class CustomSliderConsul extends StatefulWidget {
  //final String title;
  // final double initialwidget.parent.niveau;
  final String assetImage;
  final SliderParent parent;
  final int categoryCount;
  const CustomSliderConsul({
    Key? key,
    //required this.title,
    //required this.initialwidget.parent.niveau,
    required this.assetImage,
    required this.categoryCount,
    required this.parent,
  }) : super(key: key);

  @override
  State<CustomSliderConsul> createState() => _CustomSliderConsulState();
}

class _CustomSliderConsulState extends State<CustomSliderConsul> {
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
        labelText = 'Moyen';
        _gradient = kintermediateLevelGradient;
      } else {
        labelText = 'Maitrise complète';
        _gradient = kexpertLevelGradient;
      }
      setState(() {});
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.035,
                ),
                Image(
                  image: AssetImage(widget.assetImage),
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  widget.parent.nom,
                  style: paragraph,
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
                      activeTickMarkColor: Colors.white,
                      tickMarkShape: SliderTickMarkShape.noTickMark,
                      thumbShape: SliderComponentShape.noThumb,
                      thumbColor: widget.categoryCount == 3
                          ? widget.parent.niveau < 50
                              ? const Color.fromRGBO(248, 153, 153, 1)
                              : widget.parent.niveau > 50 &&
                                      widget.parent.niveau < 80
                                  ? const Color.fromRGBO(253, 197, 113, 1)
                                  : const Color.fromRGBO(124, 237, 172, 1)
                          : widget.parent.niveau < 50
                              ? const Color.fromRGBO(255, 222, 172, 1)
                              : const Color.fromRGBO(124, 237, 172, 1),
                      trackHeight: 4,
                      trackShape: GradientRectSliderTrackShape(
                        gradient: _gradient,
                        darkenInactive: true,
                      ),
                    ),
                    child: Slider(
                      min: 0,
                      max: 100,
                      value: widget.parent.niveau,
                      // divisions: 4,

                      onChanged: (double val) {},
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
      ),
    );
  }
}
