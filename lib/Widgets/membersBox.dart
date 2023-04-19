import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/Theme/color.dart';
import 'package:pharmabox/Theme/text.dart';
import 'package:pharmabox/Widgets/gradientText.dart';
import 'package:pharmabox/Widgets/likeandroundbutton.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/membres_gestion_bloc.dart';
import 'package:pharmabox/bloc/verifier_membre_bloc.dart';
import 'package:pharmabox/model/user_models/chat_model.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/membres_titualaires_reseau_bloc.dart';
import '../chat/chat_screen.dart';
import '../firebase/like_service.dart';
import '../general/widgets/custom_elevated_button.dart';
import '../general/widgets/custom_registration_textfield.dart';

class MembersBox extends StatefulWidget {
  var image;
  var name;
  var zip;
  var poste;
  NonTitulaire user;
  MembersBox(
      {Key? key,
      this.image,
      this.name,
      this.zip,
      required this.poste,
      required this.user})
      : super(key: key);

  @override
  State<MembersBox> createState() => _MembersBoxState();
}

class _MembersBoxState extends State<MembersBox> {
  VerifierMembreBloc verifierMembreBloc = VerifierMembreBloc();
  @override
  void initState() {
    super.initState();
    verifierMembreBloc.add(VerifierMembre(membre: widget.user));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.17,
      width: width * 0.9,
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
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
            height: height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: widget.image.startsWith("https")
                          ? NetworkImage(widget.image) as ImageProvider
                          : const AssetImage(
                              "assets/images/user.png",
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: paragraph,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.poste,
                            style: normGrey,
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          /*Image(
                              height: height * 0.05,
                              image: AssetImage(
                                'assets/images/GoldMember.png',
                              ),
                            ),*/
                        ],
                      ),
                    ),
                  ],
                ),
                AjouterContainer(
                    membre: widget.user, verifierMembreBloc: verifierMembreBloc)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                      '${widget.zip}',
                      style: paragraph,
                    ),
                  ],
                ),
                Row(
                  children: [],
                )
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
                    future: LikeService().getUserLikes(widget.user.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return LikeButton(
                          numberLikes: snapshot.data as int,
                          removeFunction: LikeService().removeUserLikes,
                          addFunction: LikeService().addUserLikes,
                          docId: widget.user.id,
                          checkFunction: LikeService().checkUsersLikes,
                        );
                      } else {
                        return LikeButton(
                            numberLikes: 0,
                            removeFunction: LikeService().removeUserLikes,
                            addFunction: LikeService().addUserLikes,
                            checkFunction: LikeService().checkUsersLikes,
                            docId: widget.user.id);
                      }
                    },
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(),
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
                            path: widget.user.email,
                            query: 'subject=Objet Subject&body=Body',
                          );
                          if (await canLaunch(params.toString())) {
                            await launch(params.toString());
                          } else {
                            throw 'Could not launch';
                          }
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              receiverUser: ChatModel(
                                senderName: widget.name,
                                senderMessage: "",
                                senderImage: widget.image,
                                senderPoste: widget.poste,
                                senderId: widget.user.id,
                              ),
                            ),
                          ),
                        );
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

class MembersBoxDelete extends StatelessWidget {
  final NonTitulaire membre;
  var image;
  var name;
  var zip;
  var text;
  var icon;
  MembersBoxDelete({
    required this.membre,
    Key? key,
    this.image,
    this.name,
    this.zip,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      // height: height * 0.28,
      width: width * 0.9,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
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
            height: height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(
                      height: height * 0.08,
                      fit: BoxFit.cover,
                      image: image.startsWith("https")
                          ? NetworkImage(image) as ImageProvider
                          : const AssetImage(
                              "assets/images/user.png",
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: paragraph,
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          Text(
                            membre.poste,
                            style: normGrey,
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
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
                  child: const SizedBox(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      // color: Colors.grey,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      text,
                      style: paragraph,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/PhoneGreen.png'),
                        height: height * 0.025,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/EmailGreen.png'),
                        height: height * 0.025,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/SendGreen.png'),
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
          InkWell(
            onTap: () {
              BlocProvider.of<MembresGestionBloc>(context)
                  .add(DeleteMembre(membre: membre));
            },
            child: Row(
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
            ),
          )
        ],
      ),
    );
  }
}

class AjouterContainer extends StatelessWidget {
  NonTitulaire membre;
  AjouterContainer(
      {Key? key, required this.membre, required this.verifierMembreBloc})
      : super(key: key);
  VerifierMembreBloc verifierMembreBloc;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<VerifierMembreBloc, VerifierMembreState>(
        bloc: verifierMembreBloc,
        builder: (context, state) {
          return InkWell(
            onTap: () {
              if (state is MembreAbsent) {
                BlocProvider.of<MembresGestionBloc>(context)
                    .add(AddMembre(membre: membre));
                verifierMembreBloc.add(VerifierMembre(membre: membre));
              } else {
                BlocProvider.of<MembresGestionBloc>(context)
                    .add(DeleteMembre(membre: membre));
                verifierMembreBloc.add(VerifierMembre(membre: membre));
              }
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
                    child: GradientText(
                  state is MembreAbsent ? 'Ajouter' : "Supprimer",
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(124, 237, 172, 1),
                      Color.fromRGBO(66, 210, 255, 1),
                    ],
                  ),
                ))),
          );
        });
  }
}

class ModifierContainer extends StatelessWidget {
  const ModifierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
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
            return SizedBox(
              height: height * 0.52,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    width: MediaQuery.of(context).size.width,
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
        height: height * 0.04,
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
        child: const Center(
            child: GradientText(
          'Modifier',
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(124, 237, 172, 1),
              Color.fromRGBO(66, 210, 255, 1),
            ],
          ),
        )),
      ),
    );
  }
}
