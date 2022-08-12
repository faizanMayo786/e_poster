import 'package:e_poster/model/user_model.dart';

import '../services/auth_service.dart';
import '../utils/utils.dart';
import '../view/home_view.dart';
import '../view/sign_in_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Signup Controller
class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  RxBool isLoading = false.obs;

  bool validate() {
    if (emailController.text.trim() != '' &&
        passwordController.text.trim() != '' &&
        firstNameController.text.trim() != '' &&
        lastNameController.text.trim() != '' &&
        phoneNumberController.text.trim() != '') {
      return true;
    }
    snackBar('Please Enter All The Fields');
    return false;
  }

  Future<bool> isUserExist() async {
    return await AuthService().isUserExists(phoneNumberController.text.trim());
  }

  Future<bool> validatePhoneNumber(BuildContext context) async {
    UserModel user = UserModel(
      email: emailController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      password: passwordController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
    );
    return await AuthService().phoneSignIn(
      context,
      phoneNumberController.text.trim(),
      user,
      gotoHome,
      true,
    );
  }

  gotoHome() {
    Get.off(const HomeView());
  }

  gotoLogin() {
    Get.off(SignInView());
  }
}
