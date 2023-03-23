import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';

class LogInButton extends StatelessWidget {
  var text;
  LogInButton({Key? key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(124, 237, 172, 1),
            Color.fromRGBO(66, 210, 255, 1)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.065,
      child: Center(
        child: Text(
          text,
          style: buttonText,
        ),
      ),
    );
  }
}

class LogInButtonGoogle extends StatelessWidget {
  var text;
  LogInButtonGoogle({Key? key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(124, 237, 172, 1),
            Color.fromRGBO(66, 210, 255, 1)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.065,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image(
                image: const AssetImage('assets/icons/Google.png'),
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: buttonText,
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarButton extends StatelessWidget {
  const TabBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Color.fromRGBO(66, 210, 255, 1),
            Color.fromRGBO(124, 237, 172, 1),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Icon(
              Icons.phone_outlined,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.email_outlined,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Icon(
              Icons.send_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
