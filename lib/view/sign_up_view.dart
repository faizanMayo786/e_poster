// ignore_for_file: use_build_context_synchronously

import '../utils/utils.dart';
import '/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/controller/sign_up_controller.dart';
import '/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  final controller = Get.put(SignUpController());
  SignUpView({Key? key}) : super(key: key);

  // Create Account Method
  Future<void> createAccount(BuildContext context) async {
    if (controller.validate()) {
      bool exist = !(await controller.isUserExist());
      if (exist) {
        print(await controller.validatePhoneNumber(context));
      } else {
        snackBar('User Already Exists with the Specified Number.');
      }
    }
  }

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
              'Create an Account',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          // Text Field
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.firstNameController,
              hintText: 'First Name',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          // Text Field
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.lastNameController,
              hintText: 'Last Name',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          // Text Field
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.emailController,
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          // Text Field
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.passwordController,
              hintText: 'Password',
              textInputType: TextInputType.emailAddress,
              obscureText: true,
            ),
          ),
          // Text Field
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.phoneNumberController,
              hintText: 'Phone Number',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          // Create Account Button
          Obx(
            () => CustomButton(
              // Create Account On Press Method Call
              onTap: () async {
                controller.isLoading.value = true;
                await createAccount(context);
                controller.isLoading.value = false;
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          // Goto Login Screen Button
          TextButton(
              onPressed: () {
                controller.gotoLogin();
              },
              child: const Text('Already have an account? Login'))
        ],
      ),
    );
  }
}
