import 'package:flutter/material.dart';

void showOTPDialogue(BuildContext context, TextEditingController controller,
    VoidCallback onPressed) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
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
      );
    },
  );
}
