import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Otp Dialouge
Future<void> showOTPDialogue(
    TextEditingController controller, VoidCallback onPressed) async {
  await Get.dialog(
    AlertDialog(
      title: const Text('Enter OTP'),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text('Done'),
        ),
      ],
      content: SizedBox(
        height: 80,
        child: Column(
          children: [
            TextField(
              controller: controller,
            )
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
