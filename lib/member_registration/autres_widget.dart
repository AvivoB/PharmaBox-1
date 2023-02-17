import 'package:flutter/material.dart';

import '../Theme/text.dart';
import '../general/widgets/custom_switch_widget.dart';

class AutresContainer extends StatefulWidget {
  final List<bool> conditions;
  final List<Function(bool)> callbacks;
  const AutresContainer(
      {Key? key,
      required this.height,
      required this.width,
      required this.conditions,
      required this.callbacks})
      : super(key: key);

  final double height;
  final double width;

  @override
  State<AutresContainer> createState() => _AutresContainerState();
}

class _AutresContainerState extends State<AutresContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: widget.height * 0.22,
      width: widget.width * 0.9,
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
            height: widget.height * 0.015,
          ),
          Row(
            children: [
              SizedBox(
                width: widget.width * 0.05,
              ),
              Text(
                'Autres',
                style: heading,
              ),
            ],
          ),
          SizedBox(
            height: widget.height * 0.02,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: widget.width * 0.05,
                      ),
                      Text(
                        "Je donne le droit à PharmaBox de \nm'envoyer des offres d'emploi",
                        style: paragraph,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CustomSwitch(
                        initialSwitchValue: widget.conditions[0],
                        onTap: (val) {
                          widget.callbacks[0](val);
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: widget.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: widget.width * 0.05,
                      ),
                      Text(
                        "Je suis d'accord avec les\nConditions Générales d'Utilisation",
                        style: paragraph,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CustomSwitch(
                        initialSwitchValue: widget.conditions[1],
                      onTap: (val) {
                          widget.callbacks[1](val);
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: widget.height * 0.02,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
