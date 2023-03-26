import 'package:flutter/material.dart';
import 'package:pharmabox/model/work_hours.dart';

class TimeRangePicker extends StatefulWidget {
  final WorkHours workHours;
  final WorkHours secondWorkHours;
  const TimeRangePicker(
      {Key? key, required this.workHours, required this.secondWorkHours})
      : super(key: key);

  @override
  _TimeRangePickerState createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
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
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () =>
                            _showTimePickerDialog(context, widget.workHours),
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
            const Spacer(),
            Switch(
              value: widget.workHours.open,
              activeColor: const Color.fromRGBO(124, 237, 172, 1),
              onChanged: (value) =>
                  setState(() => widget.workHours.open = value),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () =>
                        _showTimePickerDialog(context, widget.secondWorkHours),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Switch(
              value: widget.secondWorkHours.open,
              activeColor: const Color.fromRGBO(124, 237, 172, 1),
              onChanged: (value) =>
                  setState(() => widget.secondWorkHours.open = value),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showTimePickerDialog(
      BuildContext context, WorkHours workHours) async {
    final TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: workHours.startDate,
    );

    if (startTime != null) {
      final TimeOfDay? endTime = await showTimePicker(
          context: context, initialTime: workHours.endDate);

      if (endTime != null) {
        setState(() {
          workHours.startDate = startTime;
          workHours.endDate = endTime;
        });
      }
    }
  }
}
