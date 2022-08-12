import '../services/auth_service.dart';
import '../utils/commons.dart';
import '../view/sign_in_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool isLoading = false;

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

  validatePhoneNumber(BuildContext context) async {
    await AuthService().phoneSignIn(context, phoneNumberController.text.trim());
  }

  addUser() async {
    await AuthService().addUserToDB(
      firstNameController.text,
      lastNameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      phoneNumberController.text.trim(),
    );
  }

  gotoLogin() {
    Get.off(SignInView());
  }
}
