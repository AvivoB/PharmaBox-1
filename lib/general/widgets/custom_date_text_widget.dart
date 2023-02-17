import 'package:flutter/material.dart';

class CustomDateTextWidget extends StatelessWidget {
  final String date;
  final Color textColor;
  final FontWeight fontWeight;
  const CustomDateTextWidget({
    super.key,
    required this.date,
    required this.textColor,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          date,
          style: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
