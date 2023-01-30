import 'package:flutter/material.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';

class PharmacyRow extends StatelessWidget {
  var icon;
  var image;
  String text;
  Function(bool)? onChanged;
  bool? initialSwitchValue;
  PharmacyRow({Key? key, this.icon, this.image, required this.text,this.onChanged,this.initialSwitchValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              icon != null
                  ? Icon(icon)
                  : Image(
                      image: AssetImage(image),
                      width: 30,
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Color.fromRGBO(89, 90, 112, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CustomSwitch(onChanged: onChanged,initialSwitchValue: initialSwitchValue ?? false,),
            ),
            // CustomSwitch(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
          ],
        ),
      ],
    );
  }
}

class PharmacyRowWithoutSwitch extends StatelessWidget {
  var icon;
  var image;
  String text;
  PharmacyRowWithoutSwitch(
      {Key? key, this.icon, this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          icon != null
              ? Icon(icon)
              : Image(
                  width: MediaQuery.of(context).size.width * 0.045,
                  fit: BoxFit.contain,
                  image: AssetImage(
                    image,
                  ),
                ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Color.fromRGBO(89, 90, 112, 1),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
