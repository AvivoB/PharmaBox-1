import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmabox/member_registration/member_registration_screen.dart';

import '../main.dart';
import '../mainpages/HomePage.dart';

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
      (value) =>Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),(route)=>false));
}

Future signUpWithGoogle(BuildContext context) async {

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
      .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>const MemberRegistrationScreen(),
            ),(route)=>false
          ));
}
