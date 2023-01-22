import 'package:flutter/material.dart';

class StackMark extends StatelessWidget {
  var back;
  var front;
  StackMark({Key? key, this.back, this.front}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.06,
      width: width * 0.1,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(31, 92, 103, 0.17),
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(back),
        ),
      ),
      child: Image(
        image: AssetImage(front),
      ),
    );
  }
}
