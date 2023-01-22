part of 'offer_screen.dart';

class CustomTabletext extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  const CustomTabletext({super.key, required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 4,
        right: 2,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
