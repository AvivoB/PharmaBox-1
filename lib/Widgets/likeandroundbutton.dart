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
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(31, 92, 103, 0.17),
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                widget.isLiked = !widget.isLiked;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: !widget.isLiked ? lightGreen : Colors.blue[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              width: width * 0.18,
              height: height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                  Text(
                    !widget.isLiked ? '535' : '536',
                    style: headingWhite,
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            width: width * 0.08,
            height: height * 0.05,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromRGBO(89, 90, 113, 1),
            ),
          ),
        ],
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
