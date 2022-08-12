// ignore_for_file: use_build_context_synchronously

import '/utils/commons.dart';
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
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.firstNameController,
              hintText: 'First Name',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.lastNameController,
              hintText: 'Last Name',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.emailController,
              hintText: 'Email',
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
          Padding(
            padding: edgeInsets,
            child: TextFieldInput(
              controller: controller.phoneNumberController,
              hintText: 'Phone Number',
              textInputType: TextInputType.emailAddress,
            ),
          ),
          CustomButton(
            onTap: () async {
              if (controller.validate()) {
                bool exist = !(await controller.isUserExist());
                if (exist) {
                  await controller.validatePhoneNumber(context);
                  if (FirebaseAuth.instance.currentUser != null) {
                    await controller.addUser();
                  }
                } else {
                  snackBar('User Already Exists with the Specified Number.');
                }
              }
            },
            btnText: 'Create Account',
          ),
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
