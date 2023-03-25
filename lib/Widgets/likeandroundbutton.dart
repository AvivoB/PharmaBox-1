import 'package:flutter/material.dart';

import '../Theme/color.dart';
import '../Theme/text.dart';

// ignore: must_be_immutable
class LikeButton extends StatefulWidget {
  bool isLiked = false;
  LikeButton({Key? key, required this.isLiked}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          widget.isLiked = !widget.isLiked;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: !widget.isLiked ? lightGreen : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: width * 0.18,
        height: height * 0.03,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.thumb_up_alt_outlined,
              color: Colors.black,
              size: 25,
            ),
            Text(
              !widget.isLiked ? '0' : '0',
              style: headingWhite.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.055,
      width: width * 0.095,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(31, 92, 103, 0.17),
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        color: lightGreen,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
