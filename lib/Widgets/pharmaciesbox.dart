import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/circularwidget.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';

import '../Theme/color.dart';
import '../general/widgets/custom_elevated_button.dart';
import '../general/widgets/custom_registration_textfield.dart';
import '../pharmacyProfile/MainPage.dart';

class PharmaciesBox extends StatefulWidget {
  var pharm;
  var name;
  var image;
  var imagePharm;
  var zip;
  var isDelete;
  PharmaciesBox({
    Key? key,
    this.image,
    this.name,
    this.pharm,
    this.zip,
    this.imagePharm,
    this.isDelete,
  }) : super(key: key);

  @override
  State<PharmaciesBox> createState() => _PharmaciesBoxState();
}

class _PharmaciesBoxState extends State<PharmaciesBox> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PharmacyProfile(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        // height: height * 0.41,
        width: width * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(31, 92, 103, 0.17),
              offset: Offset(3, 3),
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: height * 0.18,
              width: width * 0.82,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(widget.imagePharm),
                  // 'assets/images/pharmacy 1.png'
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      StackMark(
                        back: 'assets/images/golden.png',
                        front: 'assets/images/front 1.png',
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      StackMark(
                        back: 'assets/images/back 2.png',
                        front: 'assets/images/front 2.png',
                      ),
                    ],
                  ),
                  LikeButton(isLiked: false),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      widget.pharm,
                      style: heading,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        '${widget.zip}, Paris',
                        style: paragraph,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image(
                          height: height * 0.04,
                          image: AssetImage('assets/images/CroppedBall.png')),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Leader Santé',
                        style: paragraph,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        height: height * 0.08,
                        fit: BoxFit.cover,
                        image: AssetImage(
                          widget.image,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.name,
                          style: paragraph,
                        ),
                      ),
                    ],
                  ),
                  widget.isDelete != 'yes'
                      ? InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: height * 0.52,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Ajouter advisor',
                                              style: heading,
                                            ),
                                            InkWell(
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
                                      Image(
                                        height: height * 0.2,
                                        image: const AssetImage(
                                          'assets/icons/winpharma.png',
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      CustomRegistrationTextField(
                                        label: 'Nom advisor',
                                        prefixIcon: const Icon(
                                          CupertinoIcons.person,
                                        ),
                                        controller: controller,
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      CustomElevatedButton(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF7CEDAC),
                                            Color(0xFF42D2FF),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        onPressed: () {},
                                        borderRadius: BorderRadius.circular(15),
                                        child: const Text(
                                          'Enregistrer',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: height * 0.05,
                            width: width * 0.2,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(31, 92, 103, 0.17),
                                  offset: Offset(3, 3),
                                  blurRadius: 3,
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Ajouter',
                                style: TextStyle(
                                  color: lightGreen,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image:
                                    AssetImage('assets/images/PhoneGreen.png'),
                                height: height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image:
                                    AssetImage('assets/images/EmailGreen.png'),
                                height: height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image:
                                    AssetImage('assets/images/SendGreen.png'),
                                height: height * 0.025,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            widget.isDelete == 'yes'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.delete_outline,
                        color: Color.fromRGBO(248, 153, 153, 1),
                      ),
                      Text(
                        'Supprimer',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(248, 153, 153, 1),
                        ),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
