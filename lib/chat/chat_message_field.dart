part of 'chat_screen.dart';

class CustomChatMessageField extends StatelessWidget {
  final String receiverId;
  CustomChatMessageField({super.key, required this.receiverId});
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        margin: EdgeInsets.zero,
        shadowColor: Colors.grey,
        elevation: 20,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 30,
            left: 20,
            right: 0,
          ),
          child: Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    label: const Text("Message"),
                    floatingLabelStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 30,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(124, 237, 172, 1),
                        Color.fromRGBO(66, 210, 255, 1),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: IconButton(
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            NonTitulaire user =
                                BlocProvider.of<UsersBlocBloc>(context)
                                    .currentUser!;
                            BlocProvider.of<ChatManagmentBloc>(context).add(
                                SendMessage(
                                    chat: ChatModel(
                                        senderMessage: textController.text,
                                        senderId: user.id,
                                        senderImage: user.photoUrl,
                                        senderName:
                                            user.nom + ' ' + user.prenom,
                                        senderPoste: user.poste),
                                    receiverId: receiverId));
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
