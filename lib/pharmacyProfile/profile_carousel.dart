import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/pharmacie_bloc.dart';
import '../firebase/image_service.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({Key? key}) : super(key: key);

  @override
  _MyCarouselSliderState createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  late List<String> images;
  XFile? image;

  void addImage(String imageUrl) {
    setState(() {
      images.add(imageUrl);
      BlocProvider.of<PharmacieBloc>(context).images = images;
    });
  }

  void removeImage() {
    if (images.isNotEmpty) {
      setState(() {
        images.removeAt(currentIndex);
        BlocProvider.of<PharmacieBloc>(context).images = images;
      });
    }
  }

  bool isLocalImage(String imageUrl) {
    print(imageUrl);
    return imageUrl.startsWith('/data/');
  }

  bool isNetworkImage(String imageUrl) {
    return imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = BlocProvider.of<PharmacieBloc>(context).images;
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // print(BlocProvider.of <PharmacieBloc> (context).images[0]);
    return  Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1,
                aspectRatio: 1,
                padEnds: false,
                onPageChanged: ((index, reason) => currentIndex = index)
                //height: 200.0,
                //autoPlay: true,
                ),
            items: images.map((imageUrl) {
              return isLocalImage(
                imageUrl,
              )
                  ? Image.file(
                      File(
                        imageUrl,
                      ),
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    );
            }).toList(),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/Vector.png',
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    removeImage();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Image.asset(
                      'assets/images/delete.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      
    );
  }

  _showBottomSheet(BuildContext context) {
    ImageService imageService = ImageService();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () async {
                  image = await imageService.pickImageFromGallery();
                  if (image != null) {
                    addImage(image!.path);
                  }
                },
                title: const Text("Gallery"),
                leading: const Icon(Icons.image),
              ),
              ListTile(
                onTap: () async {
                  image = await imageService.pickImageFromCamera();
                  if (image != null) {
                    addImage(image!.path);
                  }
                },
                title: const Text("Camera"),
                leading: const Icon(Icons.camera),
              ),
            ],
          );
        });
  }
}
