import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/mainpages/HomePage.dart';
import 'package:pharmabox/Onboarding/SignUp.dart';
import 'package:pharmabox/Onboarding/forgotPass.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/button.dart';

import '../Widgets/utility.dart';
import '../firebase/googlelogin.dart';
import '../main.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String loginError = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool pass = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Vous n’avez pas encore de compte?",
                style: paragraph,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: Text(
                  " Inscription",
                  style: blueNorm,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pharma-Box',
                style: heading,
              ),
            ],
          ),
          SizedBox(
            height: height * 0.04,
          ),
          SizedBox(
            width: width * 0.85,
            child: Center(
              child: Text(
                'Connectez - vous à votre compte',
                style: paragraph,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Text(
            loginError,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.red),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: width * 0.85,
                  child: TextFormField(
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Entrer un email valide'
                            : null,
                    controller: emailController,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  width: width * 0.85,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: !pass,
                    validator: (value) => value != null && value.length < 8
                        ? 'Entrez un mot de passe à 8 chiffres minimum'
                        : null,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: const OutlineInputBorder(),
                      suffixIcon: pass == false
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  pass = !pass;
                                });
                              },
                              child: const Image(
                                image: AssetImage('assets/images/hideeye.png'),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  pass = !pass;
                                });
                              },
                              child: const Icon(
                                Icons.remove_red_eye,
                                size: 25,
                              )),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          SizedBox(
            width: width * 0.85,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForgotPass(),
                  ),
                );
              },
              child: Text(
                'Mot de passe oublié',
                style: blueNorm,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: InkWell(
              onTap: () async {
                final isValid = formKey.currentState!.validate();
                if (!isValid) return;
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  Navigator.push(
                      context, MaterialPageRoute(builder:(_)=> HomePage()));
                } on FirebaseAuthException catch (error) {
                  if (error.code == 'user-not-found') {
                    setState(() {
                      loginError = 'Utilisateur non trouvé';
                    });
                  } else if (error.code == 'wrong-password') {
                    setState(() {
                      loginError = 'Mauvais mot de passe';
                    });
                  } else if (error.code == 'network-request-failed') {
                    setState(() {
                      loginError = 'la demande de réseau a échoué.';
                    });
                  }
                  Utility.showSnack('Alert', error.message ?? 'Error');
                }
                // signIn(emailController, passwordController, context, formKey);
              },
              child: LogInButton(
                text: "Me connecter",
              ),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: InkWell(
              onTap: () {
                signInWithGoogle(context);
              },
              child: LogInButtonGoogle(
                text: "Connexion via Google",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Future signIn(
//     TextEditingController emailController,
//     TextEditingController passwordController,
//     BuildContext context,
//     GlobalKey<FormState> formKey) async {
//   final isValid = formKey.currentState!.validate();
//   if (!isValid) return;
//   try {
//     await FirebaseAuth.instance
//         .signInWithEmailAndPassword(
//             email: emailController.text.trim(),
//             password: passwordController.text.trim())
//         .then(
//           (value) =>
//               navigatorKey.currentState!.popUntil((route) => route.isFirst),
//         );
//   } on FirebaseAuthException catch (error) {
//     if (error.code == 'user-not-found') {
//       loginError = 'Utilisateur non trouvé';
//     } else if (error.code == 'wrong-password') {
//       loginError = 'Mauvais mot de passe';
//     }
//   }
// }
