import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  CustomSwitch(
      {Key? key, required this.initialSwitchValue, required this.onTap})
      : super(key: key);
  bool initialSwitchValue;
  final Function(bool) onTap;

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
        widget.onTap(val);
        setState(() {
          widget.initialSwitchValue = val;
        });
      },
      value: widget.initialSwitchValue,
    );
  }
}
