import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';

class CountContainer extends StatelessWidget {
  var icon;
  var text;
  var count;
  CountContainer({Key? key, this.count, this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.08,
      width: width * 0.9,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(31, 92, 103, 0.17),
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        color: Color.fromRGBO(242, 253, 255, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              icon ?? Icons.keyboard_arrow_up_outlined,
              color: Color.fromRGBO(189, 189, 201, 1),
              size: 30,
            ),
          ),
          Text(
            text,
            style: headingForm,
          ),
          Text(
            ' ($count)',
            style: numForm,
          ),
        ],
      ),
    );
  }
}
