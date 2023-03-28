import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmabox/member_registration/member_registration_screen.dart';

import '../main.dart';

Future signInWithGoogle(BuildContext context) async {
  // showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) => const Center(
  //           child: CircularProgressIndicator(),
  //         ));
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn(scopes: <String>['email']).signIn();

  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential).then(
      (value) => navigatorKey.currentState!.popUntil((route) => route.isFirst));
}

Future signUpWithGoogle(BuildContext context) async {
  // showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) => const Center(
  //           child: CircularProgressIndicator(),
  //         ));
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn(scopes: <String>['email']).signIn();

  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance
      .signInWithCredential(credential)
      .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MemberRegistrationScreen(),
            ),
          ));
}
