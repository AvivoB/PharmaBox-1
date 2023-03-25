import 'package:flutter/material.dart';
import 'package:pharmabox/general/widgets/custom_switch_widget.dart';

class PharmacyRow extends StatelessWidget {
  var icon;
  var image;
  String text;
  Function(bool)? onChanged;
  bool? initialSwitchValue;
  PharmacyRow(
      {Key? key,
      this.icon,
      this.image,
      required this.text,
      this.onChanged,
      this.initialSwitchValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                icon != null
                    ? Icon(icon)
                    : Image(
                        height: 24,
                        width: 24,
                        image: AssetImage(
                          image,
                        ),
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromRGBO(89, 90, 112, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 32,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CustomSwitch(
                initialSwitchValue: initialSwitchValue ?? false,
                onTap: onChanged!),
          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(89, 90, 112, 1),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
