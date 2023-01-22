import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/general/widgets/custom_registration_textfield.dart';

class EmailImport extends StatelessWidget {
  const EmailImport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 246, 247, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image(
                          width: MediaQuery.of(context).size.width * 0.13,
                          image:
                              const AssetImage('assets/images/backButton.png')),
                    ),
                    Image(
                        width: MediaQuery.of(context).size.width * 0.13,
                        image: const AssetImage(
                          'assets/icons/notificationAppbar.png',
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Envoyer des invitations',
                      style: heading,
                    ),
                    Image(
                        width: MediaQuery.of(context).size.width * 0.13,
                        image: const AssetImage(
                          'assets/images/Button Add.png',
                        )),
                  ],
                ),
              ),
              InvitationContainer(),
              SizedBox(
                height: height * 0.02,
              ),
              InvitationContainer(),
              SizedBox(
                height: height * 0.02,
              ),
              InvitationContainer(),
              SizedBox(
                height: height * 0.02,
              ),
              InvitationContainer(),
              SizedBox(
                height: height * 0.02,
              ),
              InvitationContainer(),
              SizedBox(
                height: height * 0.02,
              ),
              InvitationContainer(),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvitationContainer extends StatelessWidget {
  const InvitationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.175,
      width: width * 0.9,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(31, 92, 103, 0.17),
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(children: [
        SizedBox(
          height: height * 0.01,
        ),
        CustomRegistrationTextField(label: 'Email', controller: controller),
        SizedBox(
          height: height * 0.01,
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            Icon(
              Icons.delete_outline,
              color: Color.fromRGBO(66, 210, 255, 1),
            ),
            Text(
              'Supprimer',
              style: TextStyle(
                  color: Color.fromRGBO(66, 210, 255, 1), fontSize: 14),
            )
          ],
        )
      ]),
    );
  }
}
