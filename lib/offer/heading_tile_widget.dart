part of 'offer_screen.dart';

class HeadingTileWidget extends StatelessWidget {
  var icon;
  HeadingTileWidget({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Pharmacien adjoint",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        // Container(
        //   decoration: const BoxDecoration(
        //     color: Colors.transparent,
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/golden.png'),
        //     ),
        //   ),
        //   child: const Padding(
        //     padding: EdgeInsets.all(15.0),
        //     child: Icon(
        //       CupertinoIcons.bag,
        //     ),
        //   ),
        // ),
        Icon(
          icon,
          color: Colors.grey,
        )
      ],
    );
  }
}
