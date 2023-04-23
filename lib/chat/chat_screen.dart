// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/chat_display_bloc.dart';
import 'package:pharmabox/bloc/chat_managment_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';

import 'package:pharmabox/constant.dart';
import 'package:pharmabox/general/widgets/custom_chat_bubble.dart';
import 'package:pharmabox/general/widgets/custom_date_text_widget.dart';
import 'package:pharmabox/general/widgets/custom_rounded_icon_button.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

import '../model/user_models/chat_model.dart';

part 'chat_app_bar.dart';
part 'chat_message_field.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel receiverUser;
  const ChatScreen({
    Key? key,
    required this.receiverUser,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    BlocProvider.of<ChatDisplayBloc>(context).add(DisplayMessages(
        senderId: BlocProvider.of<UsersBlocBloc>(context).currentUser!.id,
        receiverId: widget.receiverUser.senderId));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(controller.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  ScrollController controller = ScrollController();
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
                controller: controller,
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
                                      image: widget.receiverUser.senderImage
                                              .startsWith("https")
                                          ? NetworkImage(widget.receiverUser
                                              .senderImage) as ImageProvider
                                          : const AssetImage(
                                              "assets/images/user.png",
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        widget.receiverUser.senderName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        widget.receiverUser.senderPoste,
                                        style: const TextStyle(
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
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    BlocBuilder<ChatDisplayBloc, ChatDisplayState>(
                      builder: (context, state) {
                        debugPrint(state.toString());
                        if (state is MessagesReady) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            controller.animateTo(
                                controller.position.maxScrollExtent + 100,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                          });

                          return Column(
                              children: List.generate(
                            state.messages.length,
                            (index) => CustomChatBubble(
                              text: state.messages[index].senderMessage,
                              bubbleColor: state.messages[index].senderId ==
                                      widget.receiverUser.senderId
                                  ? Colors.white
                                  : const Color.fromRGBO(124, 237, 172, 1),
                              textColor: state.messages[index].senderId ==
                                      widget.receiverUser.senderId
                                  ? Colors.grey.shade600
                                  : Colors.white,
                              alignment: state.messages[index].senderId ==
                                      widget.receiverUser.senderId
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              fontSize: 17,
                            ),
                          ));
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // const Align(alignment: Alignment.topCenter, child: ChatAppBar()),
          Align(
              alignment: Alignment.bottomCenter,
              child: CustomChatMessageField(
                receiverId: widget.receiverUser.senderId,
              ))
        ],
      ),
    );
  }
}
