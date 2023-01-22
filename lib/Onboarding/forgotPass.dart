import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/Onboarding/SignUp.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/button.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailController = TextEditingController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.25,
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
              child: Center(
                child: Text(
                  'Réinitialiser votre mot de passe',
                  style: paragraph,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            SizedBox(
              height: height * 0.15,
              width: width * 0.85,
              child: Center(
                child: index == 1
                    ? Text(
                        "Si l'adresse email saisi existe, vous recevrez un email avec le lien de réinitialisation",
                        style: paragraph,
                        textAlign: TextAlign.center,
                      )
                    : Text(''),
              ),
            ),
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
              height: height * 0.03,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  index = 1;
                });
                try {
                  FirebaseAuth.instance.sendPasswordResetEmail(
                    email: emailController.text.trim(),
                  );
                  // .then((value) => );
                } on FirebaseAuthException catch (e) {
                  print(e);
                }
              },
              child: LogInButton(
                text: "Réinitialiser mon mot de passe",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
