import 'dart:ui';

import 'package:flutter/Material.dart';

class CustomRegistrationTextFieldReg extends StatefulWidget {
  final String label;
  final String image;
  int maxLines;
  bool obsecureText;
  final TextEditingController controller;
  final bool showSuffix;
  int padding;
  CustomRegistrationTextFieldReg({
    super.key,
    required this.label,
    required this.image,
    required this.controller,
    this.maxLines = 1,
    this.obsecureText = false,
    this.showSuffix = false,
    this.padding = 0,
  });

  @override
  State<CustomRegistrationTextFieldReg> createState() =>
      _CustomRegistrationTextFieldRegState();
}

bool showText = false;

class _CustomRegistrationTextFieldRegState
    extends State<CustomRegistrationTextFieldReg> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding == 0
          ? EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20,
            )
          : EdgeInsets.zero,
      child: TextFormField(
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
              ? Container(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    fit: BoxFit.fitWidth,
                    height: MediaQuery.of(context).size.height * 0.005,
                    // width: MediaQuery.of(context).size.width * 0.05,
                    image: AssetImage(
                      widget.image,
                    ),
                  ),
                )
              : null,
          prefixText: widget.maxLines == 1 ? '      ' : '',
          // prefixIconConstraints: const BoxConstraints(
          //   maxWidth: 40,
          // ),
          label: Text(
            widget.label,
            style: const TextStyle(
                // fontSize: 17,
                ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
