import 'package:flutter/material.dart';
import 'package:pharmabox/model/work_hours.dart';

class RangerConsultation extends StatefulWidget {
  final WorkHours workHours;
  final WorkHours secondWorkHours;
  const RangerConsultation(
      {Key? key, required this.workHours, required this.secondWorkHours})
      : super(key: key);

  @override
  _RangerConsultationState createState() => _RangerConsultationState();
}

class _RangerConsultationState extends State<RangerConsultation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.workHours.open
                ? Row(
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
        ),
        Visibility(
          visible: widget.secondWorkHours.open,
          child: Row(
            children: [
              Text(
                'de ${widget.secondWorkHours.startDate.format(context)}',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(89, 90, 113, 1)),
              ),
              Text(
                ' vers ${widget.secondWorkHours.endDate.format(context)}',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(89, 90, 113, 1)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
