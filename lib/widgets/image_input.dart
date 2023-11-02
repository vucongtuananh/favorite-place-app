import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? imageTook;
  void takeImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final openCamera = await imagePicker.pickImage(source: ImageSource.camera);
    if (openCamera == null) {
      return;
    }
    setState(() {
      imageTook = File(openCamera.path);
    });
    widget.onPickImage(imageTook!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
        label: const Text("Take picture"),
        onPressed: takeImage,
        icon: const Icon(
          Icons.camera,
        ));
    if (imageTook != null) {
      content = GestureDetector(
        onTap: takeImage,
        child: Image.file(
          imageTook!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
      height: 250,
      alignment: Alignment.center,
      width: double.infinity,
      child: content,
    );
  }
}
