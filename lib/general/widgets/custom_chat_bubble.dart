import 'package:flutter/material.dart';

class CustomChatBubble extends StatelessWidget {
  final String text;
  final Color bubbleColor;
  final Color textColor;
  final MainAxisAlignment alignment;
  final double fontSize;
  const CustomChatBubble({
    super.key,
    required this.text,
    required this.bubbleColor,
    required this.textColor,
    required this.alignment,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        const SizedBox(
          width: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: bubbleColor,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30,
            ),
            child: Wrap(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
