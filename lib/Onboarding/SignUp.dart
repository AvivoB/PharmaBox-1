import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/Onboarding/Login.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/button.dart';
import 'package:pharmabox/firebase/googlelogin.dart';
import 'package:pharmabox/main.dart';
import 'package:pharmabox/member_registration/member_registration_screen.dart';
import '../Home/HomePage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String error = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();
  bool pass = false;
  bool confirmPass = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Avez-vous déjà un compte?",
                style: paragraph,
              ),
              GestureDetector(
                onTap: () {
                  // StreamBuilder<User?>(
                  //     stream: FirebaseAuth.instance.authStateChanges(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return HomePage();
                  //       } else {
                  //         return LogIn();
                  //       }
                  //     });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogIn(),
                      ));
                },
                child: Text(
                  " Me connecter",
                  style: blueNorm,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.15,
            ),
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
              child: Wrap(
                children: [
                  Text(
                    'Créez votre compte Pharma-Box et rejoignez un réseau dédié à la pharmacie',
                    style: paragraph,
                    textAlign: TextAlign.center,
                  ),
                  // errorCode(error),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Text(
              error,
              style: const TextStyle(
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
                      controller: email,
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
                      validator: (value) => value != null && value.length < 8
                          ? 'Entrez un mot de passe à 8 chiffres minimum'
                          : null,
                      controller: password,
                      obscureText: !pass,
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
                                  image:
                                      AssetImage('assets/images/hideeye.png'),
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
                        // suffix: Image(
                        //   image: AssetImage('assets/images/hideeye.png'),
                        // ),
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.85,
                    child: TextFormField(
                      controller: confirmPassword,
                      validator: (value) => value != password.text
                          ? 'Mot de passe non valide'
                          : null,
                      obscureText: !confirmPass,
                      decoration: InputDecoration(
                        labelText: 'Confirmez votre mot de passe',
                        border: const OutlineInputBorder(),
                        suffixIcon: confirmPass == false
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    confirmPass = !confirmPass;
                                  });
                                },
                                child: const Image(
                                  image:
                                      AssetImage('assets/images/hideeye.png'),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    confirmPass = !confirmPass;
                                  });
                                },
                                child: const Icon(
                                  Icons.remove_red_eye,
                                  size: 25,
                                ),
                              ),
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MemberRegistrationScreen(),
                    ));
              },
              child: InkWell(
                onTap: () async {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //       const MemberRegistrationScreen(),
                  //     ));
                  // return;


                  final isValid = formKey.currentState!.validate();
                  if (!isValid) return;
                  // showDialog(
                  //     barrierDismissible: false,
                  //     context: context,
                  //     builder: (context) => const Center(
                  //           child: CircularProgressIndicator(),
                  //         ));
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email.text.trim(),
                            password: password.text.trim())
                        .then(
                          (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MemberRegistrationScreen(),
                              )),
                        );
                  } on FirebaseAuthException catch (e) {
                    print(e);
                    if (e.code == 'email-already-in-use') {
                      setState(() {
                        error = 'Email déjà utilisé';
                      });
                    } else if (e.code == 'network-request-failed') {
                      setState(() {
                        error = 'la demande de réseau a échoué.';
                      });
                    }
                  }
                  // signUp(email, password, context, formKey);
                },
                child: LogInButton(
                  text: "M'inscrire",
                ),
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            InkWell(
              onTap: ()  {
                // try {
                //   await signUpWithGoogle(context);
                // } on FirebaseAuthException catch (uwu) {
                //   if (uwu.code == 'account-exists-with-different-credential') {
                //     setState(() {
                //       error =
                //           "compte-existe-avec-différentes informations d'identification";
                //     });
                //   } else if (uwu.code == 'invalid-credential') {
                //     setState(() {
                //       error = "les informations d'identification invalides";
                //     });
                //   } else if (uwu.code == 'network_error') {
                //     setState(() {
                //       error = 'la demande de réseau a échoué.';
                //     });
                //   }
                //   // print(e);

                // }
                signUpWithGoogle(context);
              },
              child: LogInButtonGoogle(
                text: "S'inscrire via Google",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future signUp(TextEditingController email, TextEditingController password,
    BuildContext context, GlobalKey<FormState> formKey) async {}
