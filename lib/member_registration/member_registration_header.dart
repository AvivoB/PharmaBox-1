part of 'member_registration_screen.dart';

class MemberRegistrationAppBar extends StatelessWidget {
  const MemberRegistrationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(127, 127, 213, 1),
            Color.fromRGBO(134, 168, 231, 1),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Stack(
            children: [
              Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: const Color.fromRGBO(
                          208,
                          209,
                          222,
                          1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            'assets/images/user.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 3,
                right: 0,
                child: Card(
                  color: Colors.transparent,
                  elevation: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        5,
                      ),
                      child: Image.asset(
                        'assets/images/Vector.png',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              kRegistrationScreenHeaderText,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
