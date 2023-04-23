part of 'chat_screen.dart';

class CustomChatMessageField extends StatelessWidget {
  const CustomChatMessageField({super.key});

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
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.white,
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
