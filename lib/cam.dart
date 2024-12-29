import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class Mycam extends StatefulWidget {
  const Mycam({super.key});

  @override
  State<Mycam> createState() => _MycamState();
}

class _MycamState extends State<Mycam> {
  File? pickedimage_;
  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedimage_ = File(pickedFile!.path);
    });
  }

  Future<void> _captureImageFromcamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      pickedimage_ = File(pickedFile!.path);
    });
  }

  Future<XFile> _compressimage(File image) async {
    final compressimage = await FlutterImageCompress.compressAndGetFile(
        image.absolute.path, '${image.path}_compress.jpg');
    return compressimage!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera App"),
      ),
      body: Center(
          child: pickedimage_ == null
              ? Text("No Image Selected")
              : Image.file(pickedimage_!)),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _pickImageFromGallery,
            child: Icon(Icons.photo_library),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: _captureImageFromcamera,
            child: Icon(Icons.camera_alt_outlined),
          ),
        ],
      ),
    );
  }
}
