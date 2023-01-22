part of 'offer_screen.dart';

class CustomCheckBox extends StatefulWidget {
  String icon;
  CustomCheckBox({super.key, required this.icon});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0.0,
        top: 5,
        right: 30,
      ),
      child: GestureDetector(
        onTap: () {
          if (widget.icon.isEmpty) {
            widget.icon = 'check';
          } else if (widget.icon == 'check') {
            widget.icon = 'cross';
          } else {
            widget.icon = '';
          }
          setState(() {});
        },
        child: Container(
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.icon == 'check'
                ? const Color.fromRGBO(124, 237, 172, 1)
                : widget.icon == 'cross'
                    ? const Color.fromRGBO(248, 153, 153, 1)
                    : const Color.fromRGBO(253, 197, 113, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: widget.icon == 'check'
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : widget.icon == 'cross'
                  ? const Icon(
                      Icons.close,
                      color: Colors.white,
                    )
                  : const Icon(
                      null,
                    ),
        ),
      ),
    );
  }
}
