import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddImageField extends StatefulWidget {
  const AddImageField({super.key, required this.onImageAdded});
  final ValueChanged<XFile?> onImageAdded;

  @override
  State<AddImageField> createState() => _AddImageFieldState();
}

class _AddImageFieldState extends State<AddImageField> {
  bool isImageAdded = false;

  File? imageFile;

  void _addImage() {
    isImageAdded = true;
    try {
      final ImagePicker picker = ImagePicker();
      picker.pickImage(source: ImageSource.gallery).then((pickedImage) {
        if (pickedImage != null) {
          setState(() {
            imageFile = File(pickedImage.path);
          });
        }
      });
    } catch (e) {
      // Handle any errors that occur during image picking
      isImageAdded = false;
      setState(() {
        widget.onImageAdded.call(null);
      });
      log('Error picking image: $e');
    }
    isImageAdded = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isImageAdded,

      child: GestureDetector(
        onTap: _addImage,
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.green50,
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: imageFile != null
                ? ClipOval(child: Image.file(imageFile!, fit: BoxFit.cover))
                : Icon(Icons.add_a_photo, size: 50, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
