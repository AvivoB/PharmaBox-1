import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/notificationIcon.dart';
import 'package:pharmabox/chat/chat_screen.dart';

class DiscussionsPage extends StatefulWidget {
  DiscussionsPage({Key? key}) : super(key: key);

  @override
  State<DiscussionsPage> createState() => _DiscussionsPageState();
}

class _DiscussionsPageState extends State<DiscussionsPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 246, 247, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.015),
                        child: const Image(
                          image: AssetImage(
                            'assets/images/backButton.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text(
                      'Discussions',
                      style: heading,
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              DiscussionContainer(),
              SizedBox(
                height: height * 0.02,
              ),
              DiscussionContainer(
                notification: 'null',
              ),
              SizedBox(
                height: height * 0.02,
              ),
              DiscussionContainer(),
              SizedBox(
                height: height * 0.02,
              ),
              DiscussionContainer(
                notification: 'null',
              ),
              SizedBox(
                height: height * 0.02,
              ),
              DiscussionContainer(
                notification: 'null',
              ),
              SizedBox(
                height: height * 0.02,
              ),
              DiscussionContainer(
                notification: 'null',
              ),
              SizedBox(
                height: height * 0.02,
              ),
              DiscussionContainer(
                notification: 'null',
              ),
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

class DiscussionContainer extends StatelessWidget {
  var notification;
  DiscussionContainer({Key? key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ),
        );
      },
      child: Container(
        width: width * 0.92,
        height: height * 0.15,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(31, 92, 103, 0.17),
              offset: Offset(3, 3),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              leading: const Image(
                image: AssetImage('assets/images/profile 1.png'),
              ),
              title: const Text('Isabelle Rettig'),
              subtitle: const Text('Pharmacienne'),
              trailing:
                  notification == null ? NotificationIcon(number: '3') : null,
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.06,
                ),
                const Text('Hello, je recherche un poste de pharmacie...'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
