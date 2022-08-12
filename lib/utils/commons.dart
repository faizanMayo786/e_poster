import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBar(String message, [Color backgroundColor = Colors.red]) =>
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
