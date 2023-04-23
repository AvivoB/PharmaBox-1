import 'package:flutter/material.dart';

class CustomRegistrationDatePickerToDayMindate extends StatefulWidget {
  final String label;
  final Icon prefixIcon;
  int maxLines;
  final TextEditingController controller;
  int padding;
  CustomRegistrationDatePickerToDayMindate({
    Key? key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.maxLines = 1,
    this.padding = 0,
  }) : super(key: key);

  @override
  State<CustomRegistrationDatePickerToDayMindate> createState() =>
      _CustomRegistrationDatePickerToDayMindateState();
}

class _CustomRegistrationDatePickerToDayMindateState
    extends State<CustomRegistrationDatePickerToDayMindate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding == 0
          ? const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20,
            )
          : EdgeInsets.zero,
      child: TextFormField(
        readOnly: true,
        validator: (value) =>
            value == "DD/MM/YYYY" ? "Please choose a date" : null,
        controller: widget.controller,
        autofocus: false,
        textInputAction: TextInputAction.next,
        maxLines: widget.maxLines,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          letterSpacing: 0.6,
          color: Color(0xfF161730),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              locale: const Locale("fr", "FR"),
              firstDate: DateTime.now(),
              lastDate: DateTime(2200));
          if (pickedDate != null) {
            widget.controller.text =
                '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 2),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          prefixIcon: widget.maxLines == 1
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: widget.prefixIcon,
                )
              : null,
          prefixText: widget.maxLines == 1 ? '      ' : '',
          prefixIconConstraints: const BoxConstraints(
            maxWidth: 20,
          ),
          label: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
