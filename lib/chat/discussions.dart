// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/notificationIcon.dart';
import 'package:pharmabox/bloc/discussions_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/chat/chat_screen.dart';
import 'package:pharmabox/model/user_models/chat_model.dart';

class DiscussionsPage extends StatefulWidget {
  const DiscussionsPage({Key? key}) : super(key: key);

  @override
  State<DiscussionsPage> createState() => _DiscussionsPageState();
}

class _DiscussionsPageState extends State<DiscussionsPage> {
  @override
  void initState() {
    BlocProvider.of<DiscussionsBloc>(context).add(GetDiscussions(
        userId: BlocProvider.of<UsersBlocBloc>(context).currentUser!.id));
    super.initState();
  }

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
              BlocBuilder<DiscussionsBloc, DiscussionsState>(
                builder: (context, state) {
                  debugPrint(state.toString());
                  if (state is DiscussionsReady) {
                    return Column(
                        children: List.generate(
                            state.discussions.length,
                            (index) => DiscussionContainer(
                                  discussion: state.discussions[index],
                                  notification: null,
                                )));
                  } else {
                    return const SizedBox();
                  }
                },
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
  final ChatModel discussion;
  var notification;
  DiscussionContainer({
    Key? key,
    required this.discussion,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiverUser: discussion,
            ),
          ),
        );
      },
      child: Container(
        width: width * 0.92,
        height: height * 0.15,
        margin: EdgeInsets.only(bottom: height * 0.02),
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
              leading: Image(
                image: discussion.senderImage.startsWith("https")
                    ? NetworkImage(discussion.senderImage) as ImageProvider
                    : const AssetImage(
                        "assets/images/user.png",
                      ),
              ),
              title: Text(discussion.senderName),
              subtitle: Text(discussion.senderPoste),
              trailing: null,
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.06,
                ),
                Text(
                  discussion.senderMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
