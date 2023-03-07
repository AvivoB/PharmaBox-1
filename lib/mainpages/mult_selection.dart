import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> options;
  final List<String> selectedValues;
  final Function(List<String>) onSelectedValuesChanged;

  MultiSelectDropdown(
      {required this.options,
      required this.selectedValues,
      required this.onSelectedValuesChanged});

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<String> _selectedValues;
  @override
  void initState() {
    super.initState();
    _selectedValues = widget.selectedValues;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: null,
      onChanged: (selected) {
        setState(() {
          _selectedValues.add(selected!);
          widget.onSelectedValuesChanged(_selectedValues);
        });
      },
      items: widget.options
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
          .toList(),
    );
  }
}
