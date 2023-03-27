import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/firebase/like_service.dart';

import '../Theme/color.dart';
import '../Theme/text.dart';

// ignore: must_be_immutable
class LikeButton extends StatefulWidget {
  int numberLikes;
  String docId;
  Function removeFunction;
  Future<bool> Function(String, String) checkFunction;
  Function addFunction;
  LikeButton(
      {Key? key,
      required this.numberLikes,
      required this.checkFunction,
      required this.removeFunction,
      required this.docId,
      required this.addFunction})
      : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder<bool>(
        future: widget.checkFunction(
          BlocProvider.of<UsersBlocBloc>(context).currentUser!.id,
          widget.docId,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isLiked = snapshot.data!;
            print(isLiked);

            return InkWell(
              onTap: () async {
                if (isLiked) {
                  widget.numberLikes = widget.numberLikes - 1;
                  await widget.removeFunction(
                    BlocProvider.of<UsersBlocBloc>(context).currentUser!.id,
                    widget.docId,
                  );
                } else {
                  widget.numberLikes = widget.numberLikes + 1;
                  await widget.addFunction(
                    BlocProvider.of<UsersBlocBloc>(context).currentUser!.id,
                    widget.docId,
                  );
                }
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: isLiked ? lightGreen : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: width * 0.18,
                height: height * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.thumb_up_alt_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                    Text(
                      widget.numberLikes.toString(),
                      style: headingWhite.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.055,
      width: width * 0.095,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(31, 92, 103, 0.17),
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        color: lightGreen,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
