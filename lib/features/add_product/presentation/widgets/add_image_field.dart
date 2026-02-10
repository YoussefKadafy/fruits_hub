import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddImageField extends StatefulWidget {
  const AddImageField({super.key, required this.onImageAdded});
  final ValueChanged<File?> onImageAdded;

  @override
  State<AddImageField> createState() => _AddImageFieldState();
}

class _AddImageFieldState extends State<AddImageField> {
  bool isImageLoading = false;
  File? imageFile;

  void _addImage() {
    isImageLoading = true;
    try {
      final ImagePicker picker = ImagePicker();
      picker.pickImage(source: ImageSource.gallery).then((pickedImage) {
        if (pickedImage != null) {
          setState(() {
            imageFile = File(pickedImage.path);
            widget.onImageAdded.call(imageFile);
            isImageLoading = false;
          });
        }
      });
    } catch (e) {
      // Handle any errors that occur during image picking
      isImageLoading = false;
      setState(() {
        widget.onImageAdded.call(null);
      });
      log('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isImageLoading,

      child: GestureDetector(
        onTap: imageFile != null ? null : _addImage,
        child: Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.green50,
            border: Border.all(color: Colors.black),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              imageFile != null
                  ? Image.file(imageFile!, fit: BoxFit.fill)
                  : Icon(Icons.add_a_photo, size: 50, color: AppColors.primary),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      imageFile = null;
                      widget.onImageAdded.call(null);
                    });
                  },
                  icon: const Icon(Icons.close, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
