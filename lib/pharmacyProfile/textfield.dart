import 'package:flutter/material.dart';

class CustomPharmacyTextField extends StatefulWidget {
  final String label;
  final Icon? prefixIcon;
  final Function() onChanged;
  final Function(String) onRealChanged;
  final void Function(String?) onSaved;
  int maxLines;
  bool readOnly;
  bool obsecureText;
  final bool showSuffix;
  int padding;
  TextEditingController? controller;
  final TextInputType textInputType;

  CustomPharmacyTextField(
      {super.key,
      required this.label,
      this.readOnly = false,
      this.prefixIcon,
      this.onSaved = emptyFunction2,
      this.onRealChanged = emptyFunction1,
      this.onChanged = emptyFunction,
      this.maxLines = 1,
      this.obsecureText = false,
      this.showSuffix = false,
      this.padding = 0,
      this.textInputType = TextInputType.text,
      this.controller});
  static void emptyFunction1(String val) {}
  static void emptyFunction2(String? val) {}

  static void emptyFunction() {}
  @override
  State<CustomPharmacyTextField> createState() =>
      _CustomPharmacyTextFieldState();
}

bool showText = false;

class _CustomPharmacyTextFieldState extends State<CustomPharmacyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: TextFormField(
        onTap: widget.onChanged,
        onChanged: widget.onRealChanged,
        onFieldSubmitted: widget.onSaved,
        readOnly: widget.readOnly,
        validator: (value) => value!.isEmpty ? "Entrez une valeur" : null,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        keyboardType: widget.textInputType,
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
          color: Color(0xfF161730),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 10,
            // right: 10,
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
          suffixIcon: widget.showSuffix
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showText = !showText;
                    });
                  },
                  icon: Icon(
                    showText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
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
