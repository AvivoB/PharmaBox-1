import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmabox/member_registration/member_registration_screen.dart';

import '../main.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
Future signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    print(e.toString());
  }
}

Future signUpWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    /* final GoogleSignInAuthentication googleAuth =
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
                builder: (context) => const MemberRegistrationScreen(),
              ),
            ));*/
  } catch (e) {
    print(e.toString());
  }
}

// Future<void> handleSignIn(BuildContext context) async {
//   try {
//     await signUpWithGoogle(context);
//   } catch (error) {
//     print(error);
//   }
// }

// class Authentication {
//   static Future<User?> signInWithGoogle(
//       {required BuildContext context, String exception = ''}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;

//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithCredential(credential);

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         exception = e.code;
//         // errorCode(e.code);
        // if (e.code == 'account-exists-with-different-credential') {
        //   // handle the error here
        //   errorCode(e.code);
        // } else if (e.code == 'invalid-credential') {
        //   // handle the error here
        //   errorCode(e.code);
        // }
//       } catch (e) {
//         // handle the error here
//       }
//     }

//     return user;
//   }
// }

// errorCode(String error) {
//   return Text(error);
// }
