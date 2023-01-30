part of 'member_registration_screen.dart';


class MemberRegistrationAppBar extends StatelessWidget {
  MemberRegistrationAppBar({super.key});

  XFile? _logoImage;
  File? logoFile;
  var isLogoSelected = false.obs;
  final MyImagePicker _picker = MyImagePicker();

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

          GestureDetector(
            onTap: () {
              selectImage();
             // checkPermissionsAndSelectImage(context);
            },
            child:  Stack(
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
                          child: Obx(() {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: isLogoSelected.value ? Image.file(
                                logoFile!,
                                fit: BoxFit.fill,
                              ) :Image.asset(
                                'assets/images/user.png',
                                fit: BoxFit.contain,
                              ),
                            );
                          }),
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

  void checkPermissionsAndSelectImage(BuildContext context) async {
    ///checking status of permission
    var status = await Permission.photos.status;

    if (status == PermissionStatus.granted) {
      selectImage();

      ///already have permission, select image
    }

    ///if permission not allowed then request permission
    else {
      var req = await Permission.photos.request();

      ///req permission
      if (req.isGranted) {
        selectImage();

        ///permission granted, select image
      } else {
        ///user denied permission, need to get permissions manually
        var dialog = CupertinoAlertDialog(
          title: const Text("Permission Required"),
          content: const Text("Open Settings to allow photos permission."),
          actions: [
            CupertinoDialogAction(
                child: const Text("Cancel"),
                onPressed: () {
                  Get.back();
                }),
            CupertinoDialogAction(
                child: const Text("Settings"),
                onPressed: () {
                  openAppSettings();
                })
          ],
        );

        ///show dialog
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => dialog,
        );
      }
    }
  }

  void selectImage() async {
    _logoImage = await _picker.pickImage(source: ImageSource.gallery);
    isLogoSelected.value = false;
    logoFile = File(_logoImage!.path);
    isLogoSelected.value = true;

  }
}
