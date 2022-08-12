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
          //Text Field
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'E Poster App',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          //Text Field
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.phoneNumberController,
              hintText: 'Phone Number',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          //Text Field
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.passwordController,
              hintText: 'Password',
              textInputType: TextInputType.emailAddress,
              obscureText: true,
            ),
          ),
          // Login Button
          CustomButton(
            onTap: () async {
              controller.isLoading.value = true;
              if (controller.validate()) {
                await controller.login(context);

                if (FirebaseAuth.instance.currentUser != null) {
                  controller.gotoHome();
                }
              }
              controller.isLoading.value = false;
            },
            child: controller.isLoading.value
                ? CircularProgressIndicator.adaptive()
                : Text(
                    'Sign In',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
          // Goto SignUp Screen
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
