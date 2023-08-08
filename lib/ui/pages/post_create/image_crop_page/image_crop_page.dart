// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';

// class ImageCropPage extends StatefulWidget {
//   final File? imagePath;
//   const ImageCropPage({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   _ImageCropPageState createState() => _ImageCropPageState();
// }

// class _ImageCropPageState extends State<ImageCropPage> {
//   late File croppedImagePath;
//   void _cropImage(filepath) async {
//     File? croppedImage = await ImageCropper.cropImage(
//       sourcePath: filepath,
//     );
//     if (croppedImage != null) {
//       setState(() {
//         croppedImagePath = croppedImage;
//       });
//     }
//   }

//   @override
//   void initState() {
//     croppedImagePath = widget.imagePath;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(),
//     );
//   }
// }
