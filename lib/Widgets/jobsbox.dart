import 'package:flutter/material.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/circularwidget.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';
import 'package:pharmabox/firebase/chat_service.dart';
import 'package:pharmabox/firebase/like_service.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Theme/color.dart';
import '../chat/chat_screen.dart';
import '../model/user_models/chat_model.dart';

class JobBox extends StatefulWidget {
  var pharm;
  var imagePharm;
  var zip;
  Pharmacie pharmacie;
  final String jobName;
  JobBox({
    Key? key,
    required this.pharmacie,
    required this.jobName,
    this.pharm,
    this.zip,
    this.imagePharm,
  }) : super(key: key);

  @override
  State<JobBox> createState() => _JobBoxState();
}

class _JobBoxState extends State<JobBox> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.4,
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
            padding:
                EdgeInsets.all(widget.imagePharm.startsWith('assets/') ? 8 : 0),
            height: height * 0.18,
            width: width * 0.82,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              color: Color(0xfF161730),
            ),
            child: widget.imagePharm.startsWith('assets/')
                ? Image.asset(
                    widget.imagePharm,
                    fit: BoxFit.contain,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(widget.imagePharm, fit: BoxFit.cover)),
            // 'assets/images/pharmacy 1.png'

            /*Row(
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
            ),*/
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
                  Flexible(
                    child: Text(
                      widget.pharm,
                      style: heading,
                    ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Flexible(
                        child: Text(
                          '${widget.zip}',
                          maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          style: paragraph,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.pharmacie.groupementImage,
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Flexible(
                        child: Text(
                          widget.pharmacie.groupementName,
                          maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          style: paragraph,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /*SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            width: width * 0.8,
            child: Row(
              children: [
                Image(
                  height: height * 0.07,
                  image: AssetImage(
                    'assets/images/JobGold.png',
                  ),
                )
              ],
            ),
          ),*/
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Image(
                  height: height * 0.03,
                  image: const AssetImage('assets/images/front 3.png'),
                  fit: BoxFit.cover,
                ),
                SizedBox(width: width * 0.02),
                Text(
                  widget.jobName,
                  textAlign: TextAlign.left,
                  style: paragraph,
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            color: const Color(0xFFEFF6F7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: FutureBuilder(
                    future:
                        LikeService().getPharmacieLikes(widget.pharmacie.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return LikeButton(
                          numberLikes: snapshot.data as int,
                          removeFunction: LikeService().removePharmacieLikes,
                          addFunction: LikeService().addPharmacieLikes,
                          docId: widget.pharmacie.id,
                          checkFunction: LikeService().checkPharmacieUser,
                        );
                      } else {
                        return LikeButton(
                          numberLikes: 0,
                          removeFunction: LikeService().removePharmacieLikes,
                          addFunction: LikeService().addPharmacieLikes,
                          checkFunction: LikeService().checkPharmacieUser,
                          docId: widget.pharmacie.id,
                        );
                      }
                    },
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image:
                              const AssetImage('assets/images/PhoneGreen.png'),
                          height: height * 0.03,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: widget.pharmacie.email,
                            query: 'subject=Objet Subject&body=Body',
                          );
                          await launchUrl(params);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('assets/images/EmailGreen.png'),
                          height: height * 0.03,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          ChatService chatService = ChatService();
                          NonTitulaire owner = await chatService
                              .getPharmacieOwner(widget.pharmacie.id);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                receiverUser: ChatModel(
                                  senderName: owner.nom + ' ' + owner.prenom,
                                  senderMessage: "",
                                  senderImage: owner.photoUrl,
                                  senderPoste: owner.poste,
                                  senderId: widget.pharmacie.id,
                                ),
                              ),
                            ),
                          );
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('assets/images/SendGreen.png'),
                          height: height * 0.03,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
