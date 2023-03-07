part of 'offer_screen.dart';

class CustomTable extends StatefulWidget {
  List<Horaire> horraires;
  CustomTable({Key? key, required this.horraires}) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  final List<String> week = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
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
        ...List.generate(
          7,
          (index) => TableRow(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(231, 237, 238, 1),
                ),
              ),
            ),
            children: [
               CustomTabletext(
                text: week[index],
                textStyle:const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              CustomCheckBox(
                  icon: widget.horraires[index].matinee,
                  onClick: () {
                    if (widget.horraires[index].matinee.isEmpty) {
                      widget.horraires[index].matinee = 'check';
                    } else if (widget.horraires[index].matinee == 'check') {
                      widget.horraires[index].matinee = 'cross';
                    } else {
                      widget.horraires[index].matinee = '';
                    }
                    setState(() {});
                  }),
              CustomCheckBox(
                  icon: widget.horraires[index].apresMidi,
                  onClick: () {
                    if (widget.horraires[index].apresMidi.isEmpty) {
                      widget.horraires[index].apresMidi = 'check';
                    } else if (widget.horraires[index].apresMidi == 'check') {
                      widget.horraires[index].apresMidi = 'cross';
                    } else {
                      widget.horraires[index].apresMidi = '';
                    }
                    setState(() {});
                  }),
              CustomCheckBox(
                  icon: widget.horraires[index].soiree,
                  onClick: () {
                    if (widget.horraires[index].soiree.isEmpty) {
                      widget.horraires[index].soiree = 'check';
                    } else if (widget.horraires[index].soiree == 'check') {
                      widget.horraires[index].soiree = 'cross';
                    } else {
                      widget.horraires[index].soiree = '';
                    }
                    setState(() {});
                  }),
              CustomCheckBox(
                icon: widget.horraires[index].nuit,
                onClick: () {
                  if (widget.horraires[index].nuit.isEmpty) {
                    widget.horraires[index].nuit = 'check';
                  } else if (widget.horraires[index].nuit == 'check') {
                    widget.horraires[index].nuit = 'cross';
                  } else {
                    widget.horraires[index].nuit = '';
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
