import 'package:flutter/material.dart';

class CustomRoundedIconButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;
  final Icon icon;
  const CustomRoundedIconButton({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: backgroundColor,
        child: icon,
      ),
    );
  }
}
