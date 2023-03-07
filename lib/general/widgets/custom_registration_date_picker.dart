import 'package:flutter/material.dart';

class CustomRegistrationDatePicker extends StatefulWidget {
  final String label;
  final Icon prefixIcon;
  int maxLines;
  final TextEditingController controller;
  int padding;
  CustomRegistrationDatePicker({
    Key? key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.maxLines = 1,
    this.padding = 0,
  }) : super(key: key);

  @override
  State<CustomRegistrationDatePicker> createState() =>
      _CustomRegistrationDatePickerState();
}

class _CustomRegistrationDatePickerState
    extends State<CustomRegistrationDatePicker> {
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
        controller: widget.controller,
        autofocus: false,
        textInputAction: TextInputAction.next,
        maxLines: widget.maxLines,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          letterSpacing: 0.6,
          color: Colors.black,
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(
                DateTime.now().year - 1,
              ),
              locale: const Locale("fr", "FR"),
              firstDate: DateTime(1940),
              lastDate: DateTime(DateTime.now().year));
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
          label: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
