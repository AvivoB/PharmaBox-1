import 'package:flutter/material.dart';
import 'package:pharmabox/constant.dart';
import 'package:pharmabox/general/widgets/custom_chat_bubble.dart';
import 'package:pharmabox/general/widgets/custom_date_text_widget.dart';
import 'package:pharmabox/general/widgets/custom_rounded_icon_button.dart';
part 'chat_app_bar.dart';
part 'chat_message_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // padding: const EdgeInsets.only(left: 10, right: 10),
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: const BoxDecoration(
                        gradient: kLinearAppBarGradient,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CustomRoundedIconButton(
                                  backgroundColor: Colors.white,
                                  iconColor: Color(0xfF161730),
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_sharp,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Center(
                                    child: Image(
                                      height: height * 0.1,
                                      fit: BoxFit.fitHeight,
                                      image: const AssetImage(
                                          'assets/images/profile 1.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Column(
                                    children: const <Widget>[
                                      Text(
                                        "Isabelle Rettig",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Pharmacienne",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CustomRoundedIconButton(
                                backgroundColor:
                                    const Color.fromRGBO(124, 237, 172, 1),
                                iconColor: Colors.white,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.14,
                    ),
                    const CustomDateTextWidget(
                      date: '24 Août 2022',
                      textColor: Color(0xfF161730),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    CustomChatBubble(
                      text: kLeftChatMessage,
                      bubbleColor: Colors.white,
                      textColor: Colors.grey.shade600,
                      alignment: MainAxisAlignment.start,
                      fontSize: 17,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    const CustomChatBubble(
                      text: kRightChatMessage,
                      bubbleColor: Color.fromRGBO(124, 237, 172, 1),
                      textColor: Colors.white,
                      alignment: MainAxisAlignment.end,
                      fontSize: 17,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const Align(alignment: Alignment.topCenter, child: ChatAppBar()),
          const Align(
              alignment: Alignment.bottomCenter,
              child: CustomChatMessageField())
        ],
      ),
    );
  }
}
