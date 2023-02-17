import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/circularwidget.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';

import '../Theme/color.dart';

class JobBox extends StatefulWidget {
  var pharm;
  var imagePharm;
  var zip;
  JobBox({
    Key? key,
    this.pharm,
    this.zip,
    this.imagePharm,
  }) : super(key: key);

  @override
  State<JobBox> createState() => _JobBoxState();
}

class _JobBoxState extends State<JobBox> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.5,
      width: width * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
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
      child: Column(
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: height * 0.18,
            width: width * 0.82,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(widget.imagePharm),
                // 'assets/images/pharmacy 1.png'
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    StackMark(
                      back: 'assets/images/golden.png',
                      front: 'assets/images/front 1.png',
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    StackMark(
                      back: 'assets/images/back 2.png',
                      front: 'assets/images/front 2.png',
                    ),
                  ],
                ),
                LikeButton(isLiked: false),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            width: width * 0.8,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.pharm,
                    style: heading,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            width: width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      '${widget.zip}, Paris',
                      style: paragraph,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image(
                        height: height * 0.04,
                        image: AssetImage('assets/images/CroppedBall.png')),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      'Leader Santé',
                      style: paragraph,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            width: width * 0.8,
            child: Row(
              children: [
                Image(
                  height: height * 0.07,
                  image: AssetImage(
                    'assets/images/JobGold.png',
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            width: width * 0.8,
            child: Row(
              children: [
                Text(
                  'Offre',
                  style: heading,
                ),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image(
                      height: height * 0.03,
                      image: const AssetImage('assets/images/front 3.png'),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      'Pharmacien adjoint',
                      style: paragraph,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/PhoneGreen.png'),
                        height: height * 0.025,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/EmailGreen.png'),
                        height: height * 0.025,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/SendGreen.png'),
                        height: height * 0.025,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
