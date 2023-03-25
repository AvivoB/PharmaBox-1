
import 'package:flutter/material.dart';

import '../../model/horaire.dart';
import '../../offer/offer_screen.dart';

class CustomTableConsultation extends StatefulWidget {
  List<Horaire> horraires;
  CustomTableConsultation({Key? key, required this.horraires}) : super(key: key);

  @override
  State<CustomTableConsultation> createState() => _CustomTableConsultationState();
}

class _CustomTableConsultationState extends State<CustomTableConsultation> {
  final List<String> week = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  @override
  Widget build(BuildContext context) {
    return Table(
      border: const TableBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            10,
          ),
          topRight: Radius.circular(
            10,
          ),
        ),
      ),
      children: [
        const TableRow(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xfF161730),
              ),
            ),
            color: Color.fromRGBO(239, 246, 247, 1),
          ),
          children: [
            CustomTabletext(
              text: '',
              textStyle: TextStyle(),
            ),
            CustomTabletext(
              text: "Matinée",
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xfF161730),
              ),
            ),
            CustomTabletext(
              text: "Après-midi",
              textStyle: TextStyle(
                color: Color(0xfF161730),
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTabletext(
              text: "Soirée",
              textStyle: TextStyle(
                color: Color(0xfF161730),
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTabletext(
              text: "Nuit",
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xfF161730),
              ),
            ),
          ],
        ),
        ...List.generate(
          7,
          (index) => TableRow(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(231, 237, 238, 1),
                ),
              ),
            ),
            children: [
              CustomTabletext(
                text: week[index],
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xfF161730),
                ),
              ),
              CustomCheckBox(
                  icon: widget.horraires[index].matinee,
                  onClick: () {
                    if (widget.horraires[index].matinee.isEmpty) {
                      widget.horraires[index].matinee = 'check';
                    } else if (widget.horraires[index].matinee == 'check') {
                      widget.horraires[index].matinee = 'cross';
                    } else {
                      widget.horraires[index].matinee = '';
                    }
                    setState(() {});
                  }),
              CustomCheckBox(
                  icon: widget.horraires[index].apresMidi,
                  onClick: () {
                   
                  }),
              CustomCheckBox(
                  icon: widget.horraires[index].soiree,
                  onClick: () {
                   
                  }),
              CustomCheckBox(
                icon: widget.horraires[index].nuit,
                onClick: () {
                 
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}