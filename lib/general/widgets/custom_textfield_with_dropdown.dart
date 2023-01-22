import 'package:flutter/material.dart';

class CustomTextfieldDropdown extends StatefulWidget {
  final String label;
  final Icon prefixIcon;
  final Icon suffixIcon;
  int maxLines;
  bool obsecureText;
  final TextEditingController controller;
  final bool showSuffix;
  int padding;
  CustomTextfieldDropdown({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.maxLines = 1,
    this.obsecureText = false,
    this.showSuffix = false,
    this.padding = 0,
    required this.suffixIcon,
  });

  @override
  State<CustomTextfieldDropdown> createState() =>
      _CustomTextfieldDropdownState();
}

bool showText = false;

class _CustomTextfieldDropdownState extends State<CustomTextfieldDropdown> {
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
        onTap: () {},
        controller: widget.controller,
        autofocus: false,
        textInputAction: TextInputAction.next,
        obscureText: widget.obsecureText
            ? showText
                ? true
                : false
            : false,
        maxLines: widget.maxLines,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          letterSpacing: 0.3,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: widget.maxLines == 1 ? 2 : 25,
          ),
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
          suffixIcon: widget.suffixIcon,
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
