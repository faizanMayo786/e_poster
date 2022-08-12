import '../controller/sign_in_controller.dart';
import '../widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInView extends GetView<SignInController> {
  @override
  final controller = Get.put(SignInController());
  SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'E Poster App',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.phoneNumberController,
              hintText: 'Phone Number',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.passwordController,
              hintText: 'Password',
              textInputType: TextInputType.emailAddress,
              obscureText: true,
            ),
          ),
          CustomButton(
            onTap: () async {
              if (controller.validate()) {
                await controller.login(context);
                if (FirebaseAuth.instance.currentUser != null) {
                  controller.gotoHome();
                }
              }
            },
            btnText: 'Sign In',
          ),
          TextButton(
              onPressed: () {
                controller.gotoSignUp();
              },
              child: const Text('Don\'t have an account? Signup'))
        ],
      ),
    );
  }
}
