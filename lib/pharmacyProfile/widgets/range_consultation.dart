import 'package:flutter/material.dart';
import 'package:pharmabox/model/work_hours.dart';

class RangerConsultation extends StatefulWidget {
  final WorkHours workHours;
  const RangerConsultation({Key? key, required this.workHours}) : super(key: key);

  @override
  _RangerConsultationState createState() => _RangerConsultationState();
}

class _RangerConsultationState extends State<RangerConsultation> {
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.workHours.open?
            Row(
                children: [
                  Text(
                    'de ${widget.workHours.startDate.format(context)}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(89, 90, 113, 1)),
                  ),
                  Text(
                    ' vers ${widget.workHours.endDate.format(context)}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(89, 90, 113, 1)),
                  ),
                 
                ],
              )
            : const Text(
                '   Fermé',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(248, 153, 153, 1)),
              ),
        
      ],
    );
  }
}
