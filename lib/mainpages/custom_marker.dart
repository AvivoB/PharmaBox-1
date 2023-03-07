import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class CustomMarker extends StatefulWidget {
  final int count;
  GlobalKey globalKey = GlobalKey();
  CustomMarker({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      key: widget.globalKey,
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue,
        ),
        Text(
          widget.count.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
