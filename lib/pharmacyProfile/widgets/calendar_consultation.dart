import 'package:flutter/material.dart';
import 'package:pharmabox/pharmacyProfile/widgets/range_consultation.dart';

import '../../model/work_hours.dart';
import '../horraires_ouvreture.dart';

class ConsultationCalendar extends StatelessWidget {
  final List<WorkHours> workHours;
  const ConsultationCalendar({Key? key, required this.workHours})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> month = [
      'Lun',
      'Mar',
      'Mer',
      'Jeu',
      'Ven',
      'Sam',
      'Dim',
    ];
    return Column(
        children: List.generate(
            7,
            (index) => Row(children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.14,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(239, 246, 247, 1),
                    ),
                    child: Center(
                      child: Text(
                        month[index],
                        style: const TextStyle(
                          color: Color.fromRGBO(89, 90, 113, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                 Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Color.fromRGBO(231, 237, 237, 1),
                        width: 1.5,
                      )),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: RangerConsultation(workHours: workHours[index*2],secondWorkHours:workHours[index*2+1])),
                  ),
                ])));
  }
}
