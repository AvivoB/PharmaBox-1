part of 'chat_screen.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        gradient: kLinearAppBarGradient,
      ),
      child: Column(
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.03,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomRoundedIconButton(
                backgroundColor: Colors.white,
                iconColor: Color(0xfF161730),
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Isabelle Rettig",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Pharmacienne",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              CustomRoundedIconButton(
                backgroundColor: const Color.fromRGBO(124, 237, 172, 1),
                iconColor: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.call),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
