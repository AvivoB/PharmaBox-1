import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  CustomSwitch({Key? key, this.onChanged,this.initialSwitchValue = false}) : super(key: key);
  Function(bool)? onChanged;
  var initialSwitchValue = false;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      toggleSize: 16,
      height: 22,
      activeColor: const Color.fromRGBO(124, 237, 172, 1),
      width: 40,
      onToggle: (val) {
        widget.onChanged?.call(val);
        setState(() {
          widget.initialSwitchValue = val;
        });
      },
      value: widget.initialSwitchValue ,
    );
  }
}
