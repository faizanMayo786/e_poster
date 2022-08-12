import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../utils/commons.dart';
import '../view/home_view.dart';
import '../view/sign_up_view.dart';

class SignInController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool isLoading = false;

  bool validate() {
    if (passwordController.text.trim() != '' &&
        phoneNumberController.text.trim() != '') {
      return true;
    }
    snackBar('Please Enter All The Fields');
    return false;
  }

  login(BuildContext context) async {
    await AuthService().login(
      phoneNumberController.text.trim(),
      passwordController.text.trim(),
      context,
    );
  }

  gotoHome() {
    Get.off(const HomeView());
  }

  gotoSignUp() {
    Get.off(SignUpView());
  }
}
