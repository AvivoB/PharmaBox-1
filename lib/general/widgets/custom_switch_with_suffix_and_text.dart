import 'package:flutter/material.dart';

import '../../tabview/profil.dart';

class CustomSwitchWithIconAndText extends StatelessWidget {
  final String text;
  final Icon icon;
  const CustomSwitchWithIconAndText(
      {super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(
              // fontWeight: FontWeight,
              ),
        ),
        const Spacer(),
        CustomSwitch(),
      ],
    );
  }
}

class CustomSwitchWithIconAndPicture extends StatelessWidget {
  final String text;
  final String picture;
  const CustomSwitchWithIconAndPicture(
      {super.key, required this.text, required this.picture});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 2.5),
      child: Row(
        children: [
          Image(
            // color: Color(0xfF161730)

            width: 20,
            image: AssetImage(
              picture,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
          ),
          const Spacer(),
          CustomSwitch(),
        ],
      ),
    );
  }
}
