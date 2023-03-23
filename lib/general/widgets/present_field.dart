import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PresentField extends StatefulWidget {
  final String label;
  final Icon? prefixIcon;
  int? maxLines;
  int? maxLength;
  bool obsecureText;
  bool readOnly;
  final TextEditingController controller;
  TextInputAction? textInputaction;
  final bool showSuffix;
  int padding;
  TextInputType? textInputType;

  PresentField(
      {super.key,
      required this.label,
      this.prefixIcon,
      this.textInputaction,
      this.readOnly = false,
      required this.controller,
      this.maxLines = 1,
      this.obsecureText = false,
      this.showSuffix = false,
      this.padding = 0,
      this.maxLength,
      this.textInputType});

  @override
  State<PresentField> createState() => _PresentFieldState();
}

bool showText = false;

class _PresentFieldState extends State<PresentField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: TextFormField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        minLines: 1,
        autofocus: false,
        maxLength: widget.maxLength,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputaction != null
            ? widget.textInputaction
            : TextInputAction.next,
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
        /*inputFormatters: [
          MultiLineFormatter(2),
        ],*/
        onChanged: (text) {
          print(text);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 20,
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
          prefixIconConstraints: const BoxConstraints(
            maxWidth: 20,
          ),
          prefixText: widget.maxLines == 1 ? '      ' : '',
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

class MultiLineFormatter extends TextInputFormatter {
  final int _maxLines;

  MultiLineFormatter(this._maxLines);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int lines = newValue.text.split(RegExp(r'\r?\n')).length;

    if (lines > _maxLines) {
      return oldValue;
    }
    return newValue;
  }
}
