part of 'member_registration_screen.dart';

class MemberRegistrationAppBar extends StatefulWidget {
  MemberRegistrationAppBar({super.key});

  @override
  State<MemberRegistrationAppBar> createState() =>
      _MemberRegistrationAppBarState();
}

class _MemberRegistrationAppBarState extends State<MemberRegistrationAppBar> {
  XFile? image;

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
                        backgroundImage: image != null
                            ? FileImage(File(
                                image!.path,
                              ))
                            : null,
                        backgroundColor: const Color.fromRGBO(
                          208,
                          209,
                          222,
                          1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: image != null
                              ? null
                              : Image.asset(
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
                  child:GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
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
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: const Text(
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

  _showBottomSheet(BuildContext context) {
    ImageService imageService = ImageService();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: ListTile(
                    onTap: () async {
                      image = await imageService.pickImageFromGallery();
                      if (image != null) {
                        BlocProvider.of<UsersBlocBloc>(context).imagePath =
                            image!.path;
                      }
                      setState(() {});
                    },
                    title: const Text("Gallery"),
                    leading: Icon(Icons.image),
                  ),
                ),
                Container(
                  child: ListTile(
                    onTap: () async {
                      image = await imageService.pickImageFromCamera();
                      if (image != null) {
                        BlocProvider.of<UsersBlocBloc>(context).imagePath =
                            image!.path;
                      }
                      setState(() {});
                    },
                    title: const Text("Camera"),
                    leading: Icon(Icons.camera),
                  ),
                )
              ],
            ),
          );
        });
  }
}
