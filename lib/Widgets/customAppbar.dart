import 'package:flutter/material.dart';
import 'package:pharmabox/chat/chat_screen.dart';

import '../Theme/text.dart';
import '../chat/discussions.dart';

class appBarCustom extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        'Pharma-Box',
        style: heading,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) => const Notifications(),
                  );
                },
                child: Image(
                  image:
                      const AssetImage('assets/icons/notificationAppbar.png'),
                  width: width * 0.13,
                ),
              ),
              SizedBox(
                width: width * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiscussionsPage(),
                    ),
                  );
                },
                child: Image(
                  image: const AssetImage('assets/icons/sendIcon.png'),
                  width: width * 0.11,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
            ],
          ),
        )
      ],
    );
    ;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.92,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: heading,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            NotificationContainer(
              leading: 'assets/images/profile 3.png',
              title: 'Arnaud Roche added you to his network',
              color: Color.fromRGBO(239, 246, 247, 1),
            ),
            NotificationContainer(
              leading: 'assets/images/pharmacy1round.png',
              title: "Grande Pharmacie D'Aulnay added you to their network",
              color: Color.fromRGBO(239, 246, 247, 1),
            ),
            NotificationContainer(
              leading: 'assets/images/profile 3.png',
              title: 'Arnaud Roche accepted your invitation',
              color: Colors.white,
            ),
            NotificationContainer(
              leading: 'assets/images/pharmacy1round.png',
              title:
                  "Grande Pharmacie D'Aulnay has added Arnaud Roche in their network",
              color: Colors.white,
            ),
            NotificationContainerNoImage(
              title: "A new job offer matches your job request",
              color: Colors.white,
            ),
            NotificationContainerNoImage(
              title: "A new job offer matches your job request",
              color: Colors.white,
            ),
            NotificationContainerNoImage(
              title: "A new job offer matches your job request",
              color: Colors.white,
            ),
            NotificationContainer(
              leading: 'assets/images/profile 1.png',
              title: 'Isabelle Rettig added you to her network',
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationContainer extends StatelessWidget {
  var color;
  var title;
  var leading;
  NotificationContainer({Key? key, this.color, this.leading, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ListTile(
      tileColor: color,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: const Text(
        '12/02/2022',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(141, 141, 151, 1),
        ),
      ),
      leading: Container(
        height: height * 0.065,
        width: width * 0.12,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(leading),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
      trailing: const Image(
        image: AssetImage('assets/images/deleteRed.png'),
      ),
    );
  }
}

class NotificationContainerNoImage extends StatelessWidget {
  var color;
  var title;
  var leading;
  NotificationContainerNoImage({Key? key, this.color, this.leading, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ListTile(
      tileColor: color,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: const Text(
        '12/02/2022',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(141, 141, 151, 1),
        ),
      ),
      trailing: const Image(
        image: AssetImage('assets/images/deleteRed.png'),
      ),
    );
  }
}
