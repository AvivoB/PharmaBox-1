import 'package:flutter/material.dart';

class TimePickerDropdown extends StatefulWidget {
  final ValueChanged<TimeOfDay> onChanged;
  TimeOfDay initialValue;

  TimePickerDropdown({required this.onChanged, required this.initialValue});

  @override
  _TimePickerDropdownState createState() => _TimePickerDropdownState();
}

class _TimePickerDropdownState extends State<TimePickerDropdown> {
  late TimeOfDay _selectedTime;
  List<TimeOfDay> items = [];
  @override
  void initState() {
    _selectedTime = widget.initialValue;
    print(_selectedTime.toString());
    print(widget.initialValue.toString());
    for (int i = 0; i < 24; i++) {
      for (int j = 0; j < 60; j += 30) {
        final time = TimeOfDay(hour: i, minute: j);
        items = [...items, time];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TimeOfDay>(
      value: _selectedTime,
      onChanged: (value) {
        setState(() {
          _selectedTime = value!;
        });
        widget.onChanged.call(value!);
      },
      items: List.generate(
          items.length,
          (index) => DropdownMenuItem<TimeOfDay>(
                value: items[index],
                child: Text(
                  '${items[index].format(context)}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(89, 90, 113, 1)),
                ),
              )),
    );
  }
}
