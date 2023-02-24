import 'package:flutter/material.dart';
import 'package:pharmabox/model/work_hours.dart';

class TimeRangePicker extends StatefulWidget {
  final WorkHours workHours;
  const TimeRangePicker({Key? key, required this.workHours}) : super(key: key);

  @override
  _TimeRangePickerState createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
  

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
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showTimePickerDialog(context),
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
          value:         widget.workHours.open,
          activeColor: const Color.fromRGBO(124, 237, 172, 1),
          onChanged: (value) => setState(() => widget.workHours.open = value),
        ),
      ],
    );
  }

  Future<void> _showTimePickerDialog(BuildContext context) async {
    final TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: widget.workHours.startDate,
    );

    if (startTime != null) {
      final TimeOfDay? endTime = await showTimePicker(
          context: context, initialTime: widget.workHours.endDate);

      if (endTime != null) {
        setState(() {
          widget.workHours.startDate = startTime;
          widget.workHours.endDate = endTime;
        });
      }
    }
  }
}
