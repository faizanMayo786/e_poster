import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// snack reuse
snackBar(String message, [Color backgroundColor = Colors.grey]) =>
    Get.showSnackbar(
      GetSnackBar(
        maxWidth: Get.width * 0.9,
        margin: const EdgeInsets.all(12),
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
        backgroundColor: backgroundColor,
        duration: const Duration(milliseconds: 3000),
        message: message,
      ),
    );


// image reuse
pickImage(ImageSource source,
    [double height = 480, double width = 640, int quality = 50]) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(
    source: source,
    maxHeight: height,
    maxWidth: width,
    // imageQuality: quality,
  );
  if (file != null) {
    return await file.readAsBytes();
  }
}