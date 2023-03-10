import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationTest extends StatelessWidget {
  const AnimationTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            // Load a Lottie file from your assets
            Lottie.asset('assets/first.json'),

            // Load a Lottie file from a remote url
           
            // Load an animation and its images from a zip file
            Lottie.asset('assets/second.json'),
          ],
        ),
      ),
    );
  }
}
