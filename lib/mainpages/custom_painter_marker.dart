import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CircleAvatarPainter extends CustomPainter {
  final String text;
  final Color color;
  final double radius;

  CircleAvatarPainter(
      {required this.text, required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()..color = color;
    final textPainter = TextPainter(
        text: TextSpan(
            text: text,
            style: TextStyle(fontSize: radius * 0.8, color: Colors.white)),
        textDirection: TextDirection.ltr)
      ..layout();
    final center = Offset(radius, radius);
    canvas.drawCircle(center, radius, circlePaint);
    textPainter.paint(
        canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Future<Uint8List> toUint8List() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    paint(canvas, Size(300, 300)); // replace Size with your desired size
    final picture = recorder.endRecording();
    final image =
        await picture.toImage(300, 300); // replace 300 with your desired size
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}
