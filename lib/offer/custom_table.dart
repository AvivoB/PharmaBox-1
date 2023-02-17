part of 'offer_screen.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: const TableBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            10,
          ),
          topRight: Radius.circular(
            10,
          ),
        ),
      ),
      children: [
        const TableRow(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
              ),
            ),
            color: Color.fromRGBO(239, 246, 247, 1),
          ),
          children: [
            CustomTabletext(
              text: '',
              textStyle: TextStyle(),
            ),
            CustomTabletext(
              text: "Matinée",
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            CustomTabletext(
              text: "Après-midi",
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTabletext(
              text: "Soirée",
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTabletext(
              text: "Nuit",
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(231, 237, 238, 1),
              ),
            ),
          ),
          children: [
            const CustomTabletext(
              text: 'Mar',
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            CustomCheckBox(icon: ''),
            CustomCheckBox(icon: 'cross'),
            CustomCheckBox(icon: 'check'),
            CustomCheckBox(icon: 'check'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(231, 237, 238, 1),
              ),
            ),
          ),
          children: [
            const CustomTabletext(
              text: 'Mer',
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            CustomCheckBox(icon: 'check'),
            CustomCheckBox(icon: 'cross'),
            CustomCheckBox(icon: 'cross'),
            CustomCheckBox(icon: 'cross'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(231, 237, 238, 1),
              ),
            ),
          ),
          children: [
            const CustomTabletext(
              text: 'Jeu',
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            CustomCheckBox(icon: ''),
            CustomCheckBox(icon: 'cross'),
            CustomCheckBox(icon: 'check'),
            CustomCheckBox(icon: 'cross'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(231, 237, 238, 1),
              ),
            ),
          ),
          children: [
            const CustomTabletext(
              text: 'Ven',
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            CustomCheckBox(icon: 'check'),
            CustomCheckBox(icon: 'check'),
            CustomCheckBox(icon: ''),
            CustomCheckBox(icon: 'cross'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(231, 237, 238, 1),
              ),
            ),
          ),
          children: [
            const CustomTabletext(
              text: 'Sam',
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            CustomCheckBox(icon: ''),
            CustomCheckBox(icon: ''),
            CustomCheckBox(icon: 'check'),
            CustomCheckBox(icon: 'cross'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(231, 237, 238, 1),
              ),
            ),
          ),
          children: [
            const CustomTabletext(
              text: 'Dim',
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            CustomCheckBox(icon: 'cross'),
            CustomCheckBox(icon: ''),
            CustomCheckBox(icon: 'check'),
            CustomCheckBox(icon: ''),
          ],
        ),
      ],
    );
  }
}
