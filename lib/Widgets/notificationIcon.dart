import 'package:flutter/material.dart';

import '../Theme/text.dart';

class NotificationIcon extends StatelessWidget {
  var number;
  NotificationIcon({Key? key, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.03,
      width: width * 0.06,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color.fromRGBO(248, 153, 153, 1),
      ),
      child: Center(
        child: Text(
          '$number',
          style: smallWhite,
        ),
      ),
    );
  }
}
